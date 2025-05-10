package text_photo_list_api.commands

import text_photo_list_api.services.*
import naivemediator.abstractions.*
import naivemediator.macros.*
//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*
//通用的返回值
import naiveserviceresult.*

@NIService
public class UpdateTodoItemContentCommandHandler <: IRequestHandler<UpdateTodoItemContentCommand, ServiceResult> {
    public UpdateTodoItemContentCommandHandler(private let toDoItemStorage: IToDoItemStorage) {
    }
    public func handle(request: UpdateTodoItemContentCommand): ServiceResult {
        return toDoItemStorage.updateContent(request.id, request.content);
    }
}
