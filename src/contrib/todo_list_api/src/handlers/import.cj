package todo_list_api.handlers

import todo_list_api.services.*
import todo_list_api.commands.*
import todo_list_api.integration_events.*

import tea.*
//中介者模式
import naivemediator.abstractions.*
import naivemediator.macros.*
import naivemediator.*
//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*
import naiveteaset.*
//通用的返回值
import naiveserviceresult.*

//引用标准日志空间
import log.*

public func addHandler(context: TeaContext): Unit {
    //将http请求转为CreateToDoItemCommand实例
    let command = context.bindJson<CreateToDoItemCommand>()
    /* let storage=@NIGetRequiredService[context.serviceProvider](IToDoItemStorage)
    let key=storage.add(command.title,command.content) */
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${CreateToDoItemCommand.__naivemediator__qualifiedName}")
    //从依赖注入容器中取出中介者模式
    let mediator = @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    //让中介者转发command
    let result = mediator.send(command)
    context.json(200, result.toTypedViewModel())
}

public func deleteItemHandler(context: TeaContext): Unit {
    let command = context.bindJson<DeleteTodoItemCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${DeleteTodoItemCommand.__naivemediator__qualifiedName}")
    logger.info("----- request data ${command.id}")
    let mediator = @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    //让中介者转发command
    let result = mediator.send(command)
    context.json(200, result.toViewModel())
}
public func updateItemContentHandler(context: TeaContext): Unit {
    let command = context.bindJson<UpdateTodoItemContentCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${UpdateTodoItemContentCommand.__naivemediator__qualifiedName}")
    logger.info("----- request data ${command.id} ")
    let mediator = @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    //让中介者转发command
    let result = mediator.send(command)
    context.json(200, result.toViewModel())
}
public func updateItemTitleHandler(context: TeaContext): Unit {
    let command = context.bindJson<UpdateTodoItemTitleCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${UpdateTodoItemTitleCommand.__naivemediator__qualifiedName}")
    logger.info("----- request data ${command.id} ")
    let mediator = @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    //让中介者转发command
    let result = mediator.send(command)
    context.json(200, result.toTypedViewModel())
}
public func finishItemHandler(context: TeaContext): Unit {
    let command = context.bindJson<FinishToDoItemCommand>()
    let logger = @NIGetRequiredService[context.serviceProvider](Logger)
    logger.info("----- Handling ${FinishToDoItemCommand.__naivemediator__qualifiedName}")
    logger.info("----- request data ${command.id} ")
    let mediator = @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    //让中介者转发command
    let result = mediator.send(command)
    context.json(200, result.toViewModel())
}
public func checkServiceHandler(context: TeaContext): Unit {
    let storage = @NIGetRequiredService[context.serviceProvider](IToDoItemStorage)
    context.string(200, storage.toString())
}
public func itemIdAssignedIntegrationEventHandler(p: TeaContext) {
    let integrationEvent = p.bindJson<ItemIdAssignedIntegrationEvent>()
    let logger = @NIGetRequiredService[p.serviceProvider](Logger)
    logger.info("----- Handling ${ItemIdAssignedIntegrationEvent.__naivemediator__qualifiedName}")
    
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(integrationEvent)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}