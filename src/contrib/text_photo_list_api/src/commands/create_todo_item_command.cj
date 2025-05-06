package text_photo_list_api.commands
//json和这个类互相映射
import cjjson.*
import cjjson.macros.*
@JsonAdapter
public class CreateToDoItemCommand{
public var content:String=""
public var title:String=""
}