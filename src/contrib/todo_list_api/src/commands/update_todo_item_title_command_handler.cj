package todo_list_api.commands

import todo_list_api.services.*
import naivemediator.abstractions.*
import naivemediator.macros.*
//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*
//通用的返回值
import naiveserviceresult.*

@NIService
public class UpdateTodoItemTitleCommandHandler <: IRequestHandler<UpdateTodoItemTitleCommand, TypedServiceResult<String>> {
    public UpdateTodoItemTitleCommandHandler(private let toDoItemStorage: IToDoItemStorage) {
    }
    public func handle(request: UpdateTodoItemTitleCommand): TypedServiceResult<String> {
        return toDoItemStorage.updateTitle(request.id, request.title);
    }
}
