package text_photo_list_api.models

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
    public var createdAt: Int64 = 0;
    @NSColumn
    public var updatedAt: Int64 = 0;
    @NSColumn
    public var userIdentityGuid: String = ""
    @NSColumn
    public var isCompleted: Bool = false;
    @NSColumn
    public var isDeleted: Bool = false;
    @NSColumn
    public var image_url: String = "";
}
