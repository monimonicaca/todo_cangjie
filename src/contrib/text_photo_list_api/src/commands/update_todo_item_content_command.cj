package text_photo_list_api.commands

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
public class UpdateTodoItemContentCommand <: Hashable & Equatable<UpdateTodoItemContentCommand> {
    public var id: Int64 = 0
    public var content: String = ""
    public func hashCode(): Int64 {
        return id;
    }
    public operator func !=(rhs: UpdateTodoItemContentCommand): Bool {
        if (rhs.id != hashCode()) {
            return true;
        } else {
            return false;
        }
    }
    public operator func ==(rhs: UpdateTodoItemContentCommand): Bool {
        if (rhs.id != hashCode()) {
            return false;
        } else {
            return true;
        }
    }
}
