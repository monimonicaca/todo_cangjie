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
public class FinishToDoItemCommandHandler <: IRequestHandler<FinishToDoItemCommand, ServiceResult> {
    public FinishToDoItemCommandHandler(private let toDoItemStorage: IToDoItemStorage) {
    }
    public func handle(request: FinishToDoItemCommand): ServiceResult {
        return toDoItemStorage.finish(request.id);
    }
}
