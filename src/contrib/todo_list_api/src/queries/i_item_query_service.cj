package todo_list_api.queries

// naiveserviceresult
import naiveserviceresult.*

public interface IItemQueryService {
    func list( skip: Int64, take: Int64): TypedServiceResult<Array<ItemViewModel>>

    func get(id: Int64): TypedServiceResult<ItemViewModel>
}
