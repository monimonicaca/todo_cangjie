package list_api.commands

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
public class CreateItemCommandHandler <: IRequestHandler<CreateItemCommand, ServiceResult> {
    public CreateItemCommandHandler(
        private let contribUrlService: IContribUrlService,
        private let itemRepository: IItemRepository,
        private let listQueryService: IListQueryService,
        private let identityService: IIdentityService,
        private let listIntegrationEventService: IListIntegrationEventService
    ) {}

    public func handle(request: CreateItemCommand): ServiceResult {
        let typeId = match (setQueryService.get(request.setId).result) {
            case Some(v) => v.typeId
            case None => throw Exception("this should not happen")
        }
        var contribUrl = "${contribUrlService.getContribUrl(typeId)}/item/create"
        let contribJson = request.contribJson.toJson().toJsonString()

        let httpClient = ClientBuilder().build()
        let httpRequest = HttpRequestBuilder().method("POST").url(contribUrl).body(contribJson).build()
        let httpResponse = httpClient.send(httpRequest)
        let responseStream = httpResponse.body
        let responseStreamReader = StringReader(responseStream)
        let json = responseStreamReader.readToEnd()
        let jsonValue = JsonValue.fromStr(json)
        let dataModel = DataModel.fromJson(jsonValue)
        let result = TypedServiceResultViewModel<String>.deserialize(dataModel)

        if (result.status != Success) {
            return result.toServiceResult()
        }

        let contribId = match (result.result) {
            case Some(v) => v
            case None => throw Exception("this should not happen")
        }

        let item = RecAllItem(typeId, request.setId, contribId, identityService.getUserIdentityGuid())
        itemRepository.add(item)
        if (!itemRepository.unitOfWork.saveEntities()) {
            ServiceResult.failure()
        }

        var itemIdAssignedIntegrationEvent = ItemIdAssignedIntegrationEvent(typeId, contribId, item.id)
        listIntegrationEventService.addAndSaveEvent(itemIdAssignedIntegrationEvent)

        return if (itemRepository.unitOfWork.saveEntities()) {
            ServiceResult.success()
        } else {
            ServiceResult.failure()
        }
    }
}
