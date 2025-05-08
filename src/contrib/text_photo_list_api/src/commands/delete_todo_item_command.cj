package text_photo_list_api.commands

import serialization.serialization.*

//json和这个类互相映射
import cjjson.*
import cjjson.macros.*
//中介者模式
import naivemediator.abstractions.*
import naivemediator.macros.*
//通用的返回值
import naiveserviceresult.*

@NMIRequest[@ sourcePackage(), ServiceResult]
@JsonAdapter
public class DeleteTodoItemCommand {
    public var id: Int64 = 0
}
