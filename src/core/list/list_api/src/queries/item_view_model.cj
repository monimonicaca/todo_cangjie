package list_api.queries

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
    public var id: String = ""

    @NSColumn
    public var typeId: Int64 = 0

    @NSColumn
    public var listId: Int64 = 0

    @NSColumn
    public var contribId: String = ""
}
