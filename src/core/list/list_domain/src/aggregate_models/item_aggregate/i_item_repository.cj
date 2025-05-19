package list_domain.aggregate_models.item_aggregate

import naiveseedwork.*

public interface IItemRepository <: IRepository<TodoItem> {
    func add(todoItem: TodoItem): Unit

    func update(todoItem: TodoItem): Unit

    func update(todoItem:TodoItem,isDelete:Bool):Unit

    func get(itemId: Int64): ?TodoItem
}
