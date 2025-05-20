package todo_list_api.services

import todo_list_api.models.*
import std.collection.*
import std.time.*
// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*
import mysqlclient4cj.cdbc.*
import std.database.sql.*
//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*
//通用的返回值
import naiveserviceresult.*

@NIService
public class ToDoItemStorage <: IToDoItemStorage {
    public ToDoItemStorage(
        private let connectionProvider: IDatabaseConnectionProvider,
        private let identityService: IIdentityService
    ) {}
    public func toString(): String {
        return "IToDoItemStorage"
    }
    public func delete(id: Int64): ServiceResult {
        let (sql, params) = @NSUpdate(ToDoItem) {p => [p.isDeleted << true]}
            .setWhere {p => p.id == id}
            .and {
                p => p.userIdentityGuid == identityService.getUserIdentityGuid()
            }
            .and {p => p.isDeleted == false}
            .toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            statement.update(params)
            return ServiceResult.success()
        }

        throw Exception("this should not happen")
    }
    public func finish(id: Int64): ServiceResult {
        let (sql, params) = @NSUpdate(ToDoItem) {p => [p.isCompleted << true,p.completedTime<<DateTime.now()]}
            .setWhere {p => p.id == id}
            .and {
                p => p.userIdentityGuid == identityService.getUserIdentityGuid()
            }
            .and {p => p.isDeleted == false}
            .and{p => p.isCompleted == false}
            .toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            statement.update(params)
            return ServiceResult.success()
        }

        throw Exception("this should not happen")
    }

    public func add(title: String, content: String): TypedServiceResult<String> {
        let (sql, params) = @NSInsertInto(ToDoItem) {
            p => [p.title << title, p.content << content, p.userIdentityGuid << identityService.getUserIdentityGuid(),p.createdTime << DateTime.now()]
        }.toSQLWithParams()
        print(sql)

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            let updateResult = statement.update(params)
            return TypedServiceResult<String>.success(updateResult.lastInsertId.toString());
        }
        throw Exception("Not Implemented ")
    }
    public func updateContent(id: Int64, content: String): ServiceResult {
        let (sql, params) = @NSUpdate(ToDoItem) {p => [p.content << content]}
            .setWhere {p => p.id == id}
            .and {
                p => p.userIdentityGuid == identityService.getUserIdentityGuid()
            }
            .and {p => p.isDeleted == false}
            .toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            statement.update(params)
            return ServiceResult.success()
        }

        throw Exception("this should not happen")
    }
     public func updateTitle(id: Int64, title: String): TypedServiceResult<String> {
        let (sql, params) = @NSUpdate(ToDoItem) {p => [p.title << title]}
            .setWhere {p => p.id == id}
            .and {
                p => p.userIdentityGuid == identityService.getUserIdentityGuid()
            }
            .and {p => p.isDeleted == false}
            .toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            let updateResult = statement.update(params)
            return TypedServiceResult<String>.success(updateResult.lastInsertId.toString());
        }

        throw Exception("this should not happen")
    }
        public func updateItemId(id: Int64, itemId: Int64): ServiceResult {
        let (sql, params) = @NSUpdate(ToDoItem) {p => [p.todoItemId << itemId]}.setWhere {p => p.id == id}.and {
            p => p.userIdentityGuid == identityService.getUserIdentityGuid()
        }.and {p => p.isDeleted == false}.toSQLWithParams()

        try (connection = connectionProvider.getConnection()) {
            let statement = connection.prepareStatement(sql)
            statement.update(params)
            return ServiceResult.success()
        }

        throw Exception("this should not happen")
    }
}
