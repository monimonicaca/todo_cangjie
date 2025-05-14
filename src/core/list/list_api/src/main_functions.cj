package list_api

import list_infrastructure.*
import list_infrastructure.repositories.*
import list_api.behaviors.*
import list_api.commands.*
import list_api.handlers.*
//import list_api.integration_events.*
import list_api.queries.*
import list_api.services.*
//import event_bus.abstractions.*
//import event_bus.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.*
import naivemediator.abstractions.*
import naivemediator.macros.*

// naivelogger
import naivelogger.*
import naivelogger.print_logger.*
import naivelogger_seq.*

// naiveteaset
import naiveteaset.macros.*
import naiveteaset.naivevalidation.*

// tea
import tea.*

// hellohilo
import hellohilo.*

//注册日志
func addCustomLogger(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    serviceCollection |> addNaiveLogger {
        p => p.usePrintLogger {_ =>}.useSeqLogger {p => p.addr = "todo-seq"}
    }
    return serviceCollection
}

func addCustomApplicationServices(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddSingleton[serviceCollection](IDatabaseConnectionProvider, DatabaseConnectionProvider)
    @NIAddSingleton[serviceCollection](IHiLoConnectionProvider, HiLoConnectionProvider)
    @NIAddSingleton[serviceCollection](IHiLoIdGenerator, HiLoIdGenerator)
    @NIAddSingleton[serviceCollection](IListQueryService,ListQueryService)

    @NIAddScoped[serviceCollection](IListRepository, ListRepository)
    @NIAddScoped[serviceCollection](IIdentityService,MockIdentityService)
    @NIAddScoped[serviceCollection](IDatabaseContext, DatabaseContext)
    return serviceCollection
}

func addCustomMediator(serviceCollection: INaiveServiceCollection): INaiveServiceCollection {
    @NIAddTransient[serviceCollection](NaiveMediator)
    @NIAddTransient[serviceCollection](IPipelineBehavior, ValidatorBehavior)

    @NMRegisterTransientHandler[serviceCollection](CreateListCommand,CreateListCommandHandler)
    @NMRegisterTransientHandler[serviceCollection](UpdateListCommand,UpdateListCommandHandler)
    @NMRegisterTransientHandler[serviceCollection](DeleteListCommand,DeleteListCommandHandler)
    return serviceCollection
}

func mapHandlers(tea: Tea): Tea {
    tea.get("", {p: TeaContext => p.string(200, "list_api")})
    tea.post("list/create", createListHandler)
    tea.post("list/update", updateListHandler)
    tea.post("list/delete", deleteListHandler)
    tea.get("list/list", listListHandler)
    tea.get("list/get", getListHandler)
    return tea
}
