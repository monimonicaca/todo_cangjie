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
public class DeleteToDoItemCommandHandler <: IRequestHandler<DeleteTodoItemCommand, ServiceResult> {
    public DeleteToDoItemCommandHandler(private let toDoItemStorage: IToDoItemStorage) {
    }
    public func handle(request: DeleteTodoItemCommand): ServiceResult {
        return toDoItemStorage.delete(request.id);
    }
}
