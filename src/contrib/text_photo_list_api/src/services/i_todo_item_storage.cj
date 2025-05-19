package text_photo_list_api.services

//通用的返回值
import naiveserviceresult.*

public interface IToDoItemStorage {
    func toString(): String
    func add(title: String, content: String): TypedServiceResult<String>

    func delete(id: Int64): ServiceResult

    func updateContent(id: Int64, content: String): ServiceResult

    func finish(id:Int64) :ServiceResult

func updateTitle(id:Int64,title:String):TypedServiceResult<String>
func updateItemId(id: Int64, itemId: Int64): ServiceResult

}
