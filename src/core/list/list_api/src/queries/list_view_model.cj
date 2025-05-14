package list_api.queries

// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*
import cjjson.*
import cjjson.macros.*

//返回给用户的数据
@NSTable["todoList"]
@JsonAdapter
public class ListViewModel {
    @NSColumn
    public var id: String = ""

    @NSColumn
    public var name: String = ""

    @NSColumn
    public var typeId: Int64 = 0
}
