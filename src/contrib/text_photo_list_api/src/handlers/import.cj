package text_photo_list_api.handlers

import text_photo_list_api.services.*
import text_photo_list_api.commands.*
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

public func addHandler(context: TeaContext): Unit {
    //将http请求转为CreateToDoItemCommand实例
    let command = context.bindJson<CreateToDoItemCommand>()
    /* let storage=@NIGetRequiredService[context.serviceProvider](IToDoItemStorage)
    let key=storage.add(command.title,command.content) */
    //从依赖注入容器中取出中介者模式
    let mediator = @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    //让中介者转发command
    let result = mediator.send(command)
    context.json(200, result.toTypedViewModel())
}

public func deleteItemHandler(context: TeaContext): Unit {
    let command = context.bindJson<DeleteTodoItemCommand>()
    let mediator = @NIGetRequiredService[context.serviceProvider](NaiveMediator)
    //让中介者转发command
    let result = mediator.send(command)
    context.json(200, result.toViewModel())
}

public func checkServiceHandler(context: TeaContext): Unit {
    let storage = @NIGetRequiredService[context.serviceProvider](IToDoItemStorage)
    context.string(200, storage.toString())
}
