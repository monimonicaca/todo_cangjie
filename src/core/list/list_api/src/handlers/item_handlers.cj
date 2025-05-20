package list_api.handlers

import list_api.commands.*
import list_api.queries.*

// tea
import tea.*

// naiveteaset
import naiveteaset.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// naivemediator
import naivemediator.*

// naiveserviceresult
import naiveserviceresult.*
import std.convert.*

public func listItemHandler(p: TeaContext): Unit {
    let listId = Int64.tryParse(p.query("listId") ?? throw Exception("missing query parameter listId")) ?? throw Exception(
        "missing query parameter listId")
    let skip = Int64.tryParse(p.query("skip") ?? throw Exception("missing query parameter skip")) ?? throw Exception(
        "missing query parameter skip")
    let take = Int64.tryParse(p.query("take") ?? throw Exception("missing query parameter take")) ?? throw Exception(
        "missing query parameter take")

    let queryService = @NIGetRequiredService[p.serviceProvider](IItemQueryService)
    let items = queryService.list(listId, skip, take).toTypedViewModel()
    p.json(200, items)
}

public func getItemHandler(p: TeaContext): Unit {
    let id = Int64.tryParse(p.query("id") ?? throw Exception("missing query parameter id")) ?? throw Exception(
        "missing query parameter id")
    let queryService = @NIGetRequiredService[p.serviceProvider](IItemQueryService)
    let result = queryService.get(id)
    p.json(200, result.toTypedViewModel())
}

public func createItemHandler(p: TeaContext): Unit {
    let command = p.bindJson<CreateItemCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}

public func updateItemContentHandler(p: TeaContext): Unit {
    let command = p.bindJson<UpdateItemContentCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}
public func updateItemTitleHandler(p: TeaContext): Unit {
    let command = p.bindJson<UpdateItemTitleCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}
public func deleteItemHandler(p: TeaContext): Unit {
    let command = p.bindJson<DeleteItemCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}
public func finishItemHandler(p: TeaContext): Unit {
    let command = p.bindJson<FinishItemCommand>()
    let mediator = @NIGetRequiredService[p.serviceProvider](NaiveMediator)
    let result = mediator.send(command)
    p.json<ServiceResultViewModel>(200, result.toViewModel())
}