package todo_list_api.commands

import todo_list_api.models.*
import todo_list_api.services.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivevalidation
import naivevalidation.*
import naivevalidation.macros.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*

@NIService
//DeleteToDoCommand对象必须可以判等
public class DeleteToDoCommandValidator <: AbstractValidator<DeleteTodoItemCommand> {
    public DeleteToDoCommandValidator(
        connectionProvider: IDatabaseConnectionProvider,
        identityService: IIdentityService
    ) {
        @NVRuleFor({p => p.id})
            .must {
                id =>
                let (sql, params) = @NSSelectFrom(ToDoItem) {_ => []}
                    .setWhere {p => p.id == id}
                    .and {
                        p => p.userIdentityGuid == identityService.getUserIdentityGuid()
                    }
                    .and {p => p.isDeleted == false}
                    .toSQLWithParams()

                try (connection = connectionProvider.getConnection()) {
                    let statement = connection.prepareStatement(sql)
                    let queryResult = statement.query(params)
                    return !(@NSMapTo[ToDoItem](queryResult) |> isEmpty)
                }
                throw Exception("this should not happen")
            }
            .withMessage("ToDoItem not found")
    }
}
