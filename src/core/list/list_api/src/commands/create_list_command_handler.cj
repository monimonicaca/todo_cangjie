package list_api.commands

import list_domain.aggregate_models.list_aggregate.*
import list_api.services.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

@NIService
public class CreateListCommandHandler <: IRequestHandler<CreateListCommand, ServiceResult> {
    public CreateListCommandHandler(
        private let listRepository: IListRepository,
        private let identityService: IIdentityService
    ) {}

    public func handle(request: CreateListCommand): ServiceResult {
        let list = TodoList(request.name, request.typeId, identityService.getUserIdentityGuid())
        listRepository.add(list)
        //执行SQL语句，存储数据
        return if (listRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}
