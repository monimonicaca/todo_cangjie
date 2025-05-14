package list_domain.aggregate_models.list_aggregate

import naiveseedwork.*

//查list本身
public interface IListRepository <: IRepository<TodoList> {
    func add(todoList: TodoList): Unit

    func update(todoList: TodoList): Unit

    func get(listId: Int64): ?TodoList
}
