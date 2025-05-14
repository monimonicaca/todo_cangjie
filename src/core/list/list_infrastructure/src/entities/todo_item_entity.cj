package list_infrastructure.entities

import list_domain.aggregate_models.item_aggregate.*

// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*

@NSTable["todoItem"]
public class TodoItemEntity <: TodoItem {
    @NSColumnForInheritedField["id"](var __id: Int64)
    @NSColumnForInheritedField["typeId"](var __typeId: Int64)
    @NSColumnForInheritedField["listId"](var __listId: Int64)
    @NSColumnForInheritedField["contribId"](var __contribId: String)
    @NSColumnForInheritedField["userIdentityGuid"](var __userIdentityGuid: String)
    @NSColumnForInheritedField["isDeleted"](var __isDeleted: Bool)

    public func asTodoItem(): TodoItem {
        return this
    }
}
