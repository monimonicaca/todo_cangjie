package todo_list_api

import todo_list_api.handlers.*
import todo_list_api.services.*
import todo_list_api.commands.*
import todo_list_api.integration_events.*

import tea.*
import dapr_tea.subscription.*
// naiveteaset
//流水线
import naiveteaset.macros.*
import naiveteaset.naivevalidation.*
//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*
//中介者模式
import naivemediator.abstractions.*
import naivemediator.macros.*
import naivemediator.*

// naivelogger
import naivelogger.*
import naivelogger.print_logger.*
import naivelogger_seq.*

func mapHandlers(tea: Tea): Tea {
    tea.post("add", addHandler)
    tea.post("delete", deleteItemHandler)
    tea.post("update/content",updateItemContentHandler)
    tea.post("update/title",updateItemTitleHandler)
    tea.post("finish",finishItemHandler)
    return tea
}

func addCustomApplicationServices(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    //Scoped请求内存活
    @NIAddScoped[serviceCollection](IToDoItemStorage,ToDoItemStorage)
    @NIAddScoped[serviceCollection](IIdentityService,MockIdentityService)
    //全局一个实例
    @NIAddSingleton[serviceCollection](IDatabaseConnectionProvider,DatabaseConnectionProvider)
    return serviceCollection
}
//注册中介者
func addCustomMediator(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddTransient[serviceCollection](NaiveMediator)
    //注册流水线
    //@NIAddTransient[serviceCollection](IPipelineBehavior, ValidatorBehavior)

    @NMRegisterTransientHandler[serviceCollection](CreateToDoItemCommand,CreateToDoItemCommandHandler)

    @NMRegisterTransientHandler[serviceCollection](DeleteTodoItemCommand,DeleteToDoItemCommandHandler)
  // @NVRegisterTransientValidator[serviceCollection](DeleteTodoItemCommand,DeleteToDoCommandValidator)

    @NMRegisterTransientHandler[serviceCollection](UpdateTodoItemContentCommand,UpdateTodoItemContentCommandHandler)
    //@NVRegisterTransientValidator[serviceCollection](UpdateTodoItemContentCommand,UpdateTodoItemCommandValidator)

    @NMRegisterTransientHandler[serviceCollection](FinishToDoItemCommand,FinishToDoItemCommandHandler)
        @NMRegisterTransientHandler[serviceCollection](ItemIdAssignedIntegrationEvent, ItemIdAssignedIntegrationEventHandler)

    @NMRegisterTransientHandler[serviceCollection](UpdateTodoItemTitleCommand,UpdateTodoItemTitleCommandHandler)
    return serviceCollection
}
//注册日志
func addCustomLogger(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    serviceCollection |> addNaiveLogger {
        p => p.usePrintLogger {_ =>}.useSeqLogger {p => p.addr = "todo-seq"}
    }
    return serviceCollection
}
func mapTopicHandlers(tea: Tea): Tea {
    // 订阅事件并注册事件Handler
    tea
        .topic
        .pubsubName("todo-pubsub")
        .topic("ItemIdAssignedIntegrationEvent")
        .post("/itemIdAssigned", itemIdAssignedIntegrationEventHandler)
    tea.subscriptions.mapHandler()

    return tea
}

