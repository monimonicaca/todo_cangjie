package list_api.queries

// naiveserviceresult
import naiveserviceresult.*

public interface IItemQueryService {
    func list(listId: Int64, skip: Int64, take: Int64): TypedServiceResult<Array<ItemViewModel>>

    func get(id: Int64): TypedServiceResult<ItemViewModel>
}
