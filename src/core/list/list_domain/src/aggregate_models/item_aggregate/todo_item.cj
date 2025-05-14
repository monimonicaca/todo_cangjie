package list_domain.aggregate_models.item_aggregate

// naiveseedwork
import naiveseedwork.*

public open class TodoItem <: Entity & IAggregateRoot {
    public var __typeId: Int64 = 0

    public var __listId: Int64 = 0

    public var __contribId: String = String.empty

    public var __userIdentityGuid: String = String.empty

    public var __isDeleted: Bool = false

    public init() {}

    public init(typeId: Int64, listId: Int64, contribId: String, userIdentityGuid: String) {
        __typeId = typeId
        __listId = listId
        __contribId = contribId
        __userIdentityGuid = userIdentityGuid
    }

    public func setDeleted(): Unit {
        if (__isDeleted) {
            throwDeletedException()
        }

        __isDeleted = true
    }

    public func setSetId(listId: Int64): Unit {
        if (__isDeleted) {
            throwDeletedException()
        }

        __listId = listId
    }

    private func throwDeletedException(): Unit {
        throw Exception("集合已删除。")
    }
}
