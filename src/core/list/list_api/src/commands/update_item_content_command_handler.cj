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
public class UpdateItemContentCommandHandler <: IRequestHandler<UpdateItemContentCommand, ServiceResult> {
    public UpdateItemContentCommandHandler(
        private let contribUrlService: IContribUrlService,
        private let listQueryService: IListQueryService,
        private let itemQueryService: IItemQueryService,
        private let identityService: IIdentityService
    ) {}

    public func handle(request: UpdateItemContentCommand): ServiceResult {
        let typeId = match (listQueryService.get(request.listId).result) {
            case Some(v) => v.typeId
            case None => throw Exception("this should not happen")
        }
        //获得url
        var contribUrl = "${contribUrlService.getContribUrl(typeId)}/update/content"
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
