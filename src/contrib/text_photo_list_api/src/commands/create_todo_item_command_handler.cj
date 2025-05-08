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
public class CreateToDoItemCommandHandler <: IRequestHandler<CreateToDoItemCommand, TypedServiceResult<String>> {
    public CreateToDoItemCommandHandler(private let toDoItemStorage: IToDoItemStorage) {
    }
    public func handle(request: CreateToDoItemCommand): TypedServiceResult<String> {
        return toDoItemStorage.add(request.title, request.content);
    }
}
