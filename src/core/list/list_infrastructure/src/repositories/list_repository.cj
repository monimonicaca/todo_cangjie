package list_infrastructure.repositories

import list_domain.*
import list_domain.aggregate_models.list_aggregate.*
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
public class ListRepository <: IListRepository {
    public ListRepository(private let context: IDatabaseContext, private let idGenerator: IHiLoIdGenerator) {}

    public func add(todoList: TodoList): Unit {
        context.update {
            connection =>
            todoList.__id = idGenerator.getNextId(TodoListEntityDesc().tableName)
            let (sql, params) = @NSInsertInto(TodoListEntity) {
                p => [
                    p.__id << todoList.__id,
                    p.__name << todoList.__name,
                    p.__typeId << todoList.__typeId,
                    p.__userIdentityGuid << todoList.__userIdentityGuid,
                    p.__isDeleted << todoList.__isDeleted
                ]
            }.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func update(todoList: TodoList): Unit {
        context.update {
            connection =>
            let (sql, params) = @NSUpdate(TodoListEntity) {
                p => [
                    p.__name << todoList.__name,
                    p.__typeId << todoList.__typeId,
                    p.__userIdentityGuid << todoList.__userIdentityGuid,
                    p.__isDeleted << todoList.__isDeleted
                ]
            }.setWhere {p => p.__id == todoList.__id}.toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
    }

    public func get(listId: Int64): ?TodoList {
        let queryResult = context.query {
            connection =>
            let (sql, params) = @NSSelectFrom(TodoListEntity) {_ => []}
                .setWhere {p => p.__id == listId}
                .toSQLWithParams()
            return (connection.prepareStatement(sql), params)
        }
        return @NSMapTo[TodoListEntity](queryResult) |> map {p => p.asTodoList()} |> first
    }

    public prop unitOfWork: IUnitOfWork {
        get() {
            return context
        }
    }
}
