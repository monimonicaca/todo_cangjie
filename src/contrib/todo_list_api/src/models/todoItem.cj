package todo_list_api.models
import std.time.*
// naivesqlbuilder
import naivesqlbuilder.abstractions.*
import naivesqlbuilder.macros.*
import std.collection.*

@NSTable["todoItem"]
public class ToDoItem {
    @NSColumn
    public var id: Int64 = 0
    @NSColumn
    public var todoItemId: ?Int64 = None
    @NSColumn
    public var title: String = ""
    @NSColumn
    public var content: String = ""
    @NSColumn
    public var userIdentityGuid: String = ""
    @NSColumn
    public var isCompleted: Bool = false;
    @NSColumn
    public var isDeleted: Bool = false;
    @NSColumn
    public var image_url: String = "";
    @NSColumn 
public var completedTime:DateTime= DateTime.fromUnixTimeStamp(Duration.Zero)
@NSColumn
public var createdTime:DateTime= DateTime.fromUnixTimeStamp(Duration.Zero)

}
