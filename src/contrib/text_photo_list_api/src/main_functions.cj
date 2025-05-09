package text_photo_list_api

import text_photo_list_api.handlers.*
import text_photo_list_api.services.*
import text_photo_list_api.commands.*
import tea.*
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
    @NIAddTransient[serviceCollection](IPipelineBehavior, ValidatorBehavior)

    @NMRegisterTransientHandler[serviceCollection](CreateToDoItemCommand,CreateToDoItemCommandHandler)
    @NMRegisterTransientHandler[serviceCollection](DeleteTodoItemCommand,DeleteToDoItemCommandHandler)
    @NVRegisterTransientValidator[serviceCollection](DeleteTodoItemCommand,DeleteToDoCommandValidator)
    return serviceCollection
}
//注册日志
func addCustomLogger(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    serviceCollection |> addNaiveLogger {
        p => p.usePrintLogger {_ =>}.useSeqLogger {p => p.addr = "todo-seq"}
    }
    return serviceCollection
}
