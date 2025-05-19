package list_infrastructure.repositories

import list_domain.*
import list_domain.aggregate_models.item_aggregate.*
import list_infrastructure.*
import list_infrastructure.entities.*

// naiveseedwork
import naiveseedwork.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*

// hellohilo
import hellohilo.*

@NIService
public class ItemRepository <: IItemRepository {
    public ItemRepository(private let context: IDatabaseContext, private let idGenerator: IHiLoIdGenerator) {}

    public func add(todoItem: TodoItem): Unit {
        context.update {
            connection =>
            todoItem.__id = idGenerator.getNextId(TodoItemEntityDesc().tableName)
            let (sql, params) = @NSInsertInto(TodoItemEntity) {
                p => [
                    p.__id << todoItem.__id,
                    p.__typeId << todoItem.__typeId,
                    p.__listId << todoItem.__listId,
                    p.__contribId << todoItem.__contribId,
                    p.__userIdentityGuid << todoItem.__userIdentityGuid,
                    p.__isDeleted << todoItem.__isDeleted
                ]
            }.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func update(todoItem: TodoItem): Unit {
        context.update {
            connection =>
            let (sql, params) = @NSUpdate(TodoItemEntity) {
                p => [
                    p.__typeId << todoItem.__typeId,
                    p.__listId << todoItem.__listId,
                    p.__contribId << todoItem.__contribId,
                    p.__userIdentityGuid << todoItem.__userIdentityGuid,
                    p.__isDeleted << todoItem.__isDeleted
                ]
            }.setWhere {p => p.__id == todoItem.__id}.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func get(itemId: Int64): ?TodoItem {
        let queryResult = context.query {
            connection =>
            let (sql, params) = @NSSelectFrom(TodoItemEntity) {_ => []}
                .setWhere {p => p.__id == itemId}
                .toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
        return @NSMapTo[TodoItemEntity](queryResult) |> map {p => p.asTodoItem()} |> first
    }

    public prop unitOfWork: IUnitOfWork {
        get() {
            return context
        }
    }
public func delete(todoItem: TodoItem){
    context.update {
            connection =>
            let (sql, params) = @NSUpdate(TodoItemEntity) {
                p => [
                    p.__typeId << todoItem.__typeId,
                    p.__listId << todoItem.__listId,
                    p.__contribId << todoItem.__contribId,
                    p.__userIdentityGuid << todoItem.__userIdentityGuid,
                    p.__isDeleted << true
                ]
            }.setWhere {p => p.__id == todoItem.__id}.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }

}
    public func update(todoItem: TodoItem,isDeleted:Bool): Unit {
        if(isDeleted){
            delete(todoItem)
        }else{
            update(todoItem)
        }
    }
}
