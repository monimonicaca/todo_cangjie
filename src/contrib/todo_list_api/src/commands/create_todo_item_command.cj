package todo_list_api.commands

//json和这个类互相映射
import cjjson.*
import cjjson.macros.*
//中介者模式
import naivemediator.abstractions.*
import naivemediator.macros.*
//通用的返回值
import naiveserviceresult.*

@NMIRequest[@ sourcePackage(), TypedServiceResult<String>]
@JsonAdapter
public class CreateToDoItemCommand {
    public var content: String = ""
    public var title: String = ""
}
