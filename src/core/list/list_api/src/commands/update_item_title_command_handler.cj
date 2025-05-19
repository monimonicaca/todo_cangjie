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
public class UpdateItemTitleCommandHandler <: IRequestHandler<UpdateItemTitleCommand, ServiceResult> {
    public UpdateItemTitleCommandHandler(
        private let contribUrlService: IContribUrlService,
        private let listQueryService: IListQueryService,
        private let itemQueryService: IItemQueryService,
        private let identityService: IIdentityService
    ) {}

    public func handle(request: UpdateItemTitleCommand): ServiceResult {
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
        var contribUrl = "${contribUrlService.getContribUrl(typeId)}/update/title"
        let contribJson = request.contribJson.toJson().toJsonString()
        //转发
        let result = TypedServiceResultViewModel<String>.deserialize(RequestUtil.getRequest(contribUrl, contribJson))

        if (result.status != Success) {
            return result.toServiceResult()
        } else {
            ServiceResult.success()
        }

        /*  var itemIdAssignedIntegrationEvent = ItemIdAssignedIntegrationEvent(typeId, contribId, item.id)
        listIntegrationEventService.addAndSaveEvent(itemIdAssignedIntegrationEvent)
         */
        // return if (itemRepository.unitOfWork.saveEntities()) {
        //     ServiceResult.success()
        // } else {
        //     ServiceResult.failure()
        // }
    }
}
