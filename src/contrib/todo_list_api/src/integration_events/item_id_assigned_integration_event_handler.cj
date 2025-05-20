package todo_list_api.integration_events

import todo_list_api.services.*

// naivemediator
import naivemediator.abstractions.*

// naiveserviceresult
import naiveserviceresult.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// others
import std.convert.*

@NIService
public class ItemIdAssignedIntegrationEventHandler <: IRequestHandler<ItemIdAssignedIntegrationEvent, ServiceResult> {
    public ItemIdAssignedIntegrationEventHandler(private let todoItemStorage: IToDoItemStorage) {}

    public func handle(request: ItemIdAssignedIntegrationEvent): ServiceResult {
        if (request.typeId != 1) {
            return ServiceResult.success()
        }

        return todoItemStorage.updateItemId(
            Int64.tryParse(request.contribId) ?? throw Exception("cannot parse contribId"), request.itemId)
    }
}
