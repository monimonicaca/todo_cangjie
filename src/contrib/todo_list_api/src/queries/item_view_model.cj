package todo_list_api.queries

import std.time.*
// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*
import cjjson.*
import cjjson.macros.*

@NSTable["todoItem"]
@JsonAdapter
public class ItemViewModel {
     @NSColumn
    public var id: Int64 = 0
    @NSColumn
    public var title: String = ""
    @NSColumn
    public var content: String = ""
    @NSColumn
    public var completedTime: String = ""
    @NSColumn
    public var createdTime: String = ""
}
