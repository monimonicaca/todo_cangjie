package text_photo_list_api.handlers
import text_photo_list_api.services.*
import text_photo_list_api.commands.*

import tea.*

//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

import naiveteaset.*
public func addHandler(context:TeaContext):Unit{
    //将http请求转为CreateToDoItemCommand实例
    let command=context.bindJson<CreateToDoItemCommand>()
    let storage=@NIGetRequiredService[context.serviceProvider](IToDoItemStorage)
    let key=storage.add(command.title,command.content)
    context.string(200,key)
}
