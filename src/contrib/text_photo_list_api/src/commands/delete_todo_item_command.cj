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
public class DeleteTodoItemCommand <: Hashable & Equatable<DeleteTodoItemCommand> {
    public var id: Int64 = 0
    public func hashCode(): Int64 {
        return id.hashCode();
    }
    public operator func !=(rhs: DeleteTodoItemCommand): Bool {
        if (rhs.id.hashCode() != hashCode()) {
            return true;
        } else {
            return false;
        }
    }
    public operator func ==(rhs: DeleteTodoItemCommand): Bool {
        if (rhs.id.hashCode() != hashCode()) {
            return false;
        } else {
            return true;
        }
    }
}
