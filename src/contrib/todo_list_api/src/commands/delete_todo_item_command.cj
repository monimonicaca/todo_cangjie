package todo_list_api.commands

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
        var hasher = DefaultHasher()
        hasher.write("DeleteTodoItemCommand")
        hasher.write(id.hashCode())

        hasher.finish()
    }

    public operator func ==(that: DeleteTodoItemCommand): Bool {
        this.hashCode() == that.hashCode()
    }

    public operator func !=(that: DeleteTodoItemCommand): Bool {
        this.hashCode() != that.hashCode()
    }
}
