package list_api.commands


import list_api.utils.*
import list_domain.aggregate_models.item_aggregate.*
// import list_api.integration_events.*
import list_api.queries.*
import list_api.services.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*
import encoding.json.*
import net.http.*
import serialization.serialization.*
import std.io.*

@NIService
public class FinishItemCommandHandler <: IRequestHandler<FinishItemCommand, ServiceResult> {
    public FinishItemCommandHandler(
        private let contribUrlService: IContribUrlService,
        private let listQueryService: IListQueryService,
        private let itemQueryService: IItemQueryService,
        private let identityService: IIdentityService,
private let itemRepositoryService:IItemRepository
    ) {}

    public func handle(request: FinishItemCommand): ServiceResult {
       
        let listId = match (itemQueryService.get(request.id).result) {
            case Some(v) => v.listId
            case None => throw Exception("illegal mistake")
        }
        if (listId == 0) {
            return ServiceResult.failure()
        }
        let typeId = match (listQueryService.get(listId).result) {
            case Some(v) => v.typeId
            case None => throw Exception("this should not happen")
        }
        //获得url
        var contribUrl = "${contribUrlService.getContribUrl(typeId)}/finish"
        let contribJson = request.contribJson.toJson().toJsonString()
        //转发
        let result = TypedServiceResultViewModel<String>.deserialize(RequestUtil.getRequest(contribUrl, contribJson))

        if (result.status != Success) {
            return result.toServiceResult()
        } else {
            ServiceResult.success()
        }
    }
}
