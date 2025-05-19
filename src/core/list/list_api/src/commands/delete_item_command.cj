package list_api.commands


import serialization.serialization.*

// naivemediator
import naivemediator.abstractions.*
import naivemediator.macros.*

// naiveserviceresult
import naiveserviceresult.*
import cjjson.*
import cjjson.macros.*

@NMIRequest[@ sourcePackage(), ServiceResult]
public class DeleteItemCommand <: Hashable & Equatable<DeleteItemCommand> & IJsonAdapter<DeleteItemCommand> {
    public var id: Int64 = 0

    //处理任一类型的数据
    public var contribJson: DataModelStruct = DataModelStruct()

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write("DeleteItemCommand")
        hasher.write(id.hashCode())
        hasher.write(contribJson.toJson().toJsonString().hashCode())
        hasher.finish()
    }

    public operator func ==(that: DeleteItemCommand): Bool {
        this.hashCode() == that.hashCode()
    }

    public operator func !=(that: DeleteItemCommand): Bool {
        this.hashCode() != that.hashCode()
    }

    public static func deserialize(dataModel: DataModel): DeleteItemCommand {
        var dms: DataModelStruct = match (dataModel) {
            case data: DataModelStruct => data
            case _ => throw Exception("DeleteItemCommand: not a DataModelStruct")
        }
        let obj = DeleteItemCommand()

        try {
            obj.id = Int64.deserialize(dms.get("id"))
        } catch (e: DataModelException) {
            let dm = dms.get("id")

            if (dm.isNull()) {
                throw JsonFieldNotExist("DeleteItemCommand", "id")
            } else {
                throw JsonTypeMismatch("DeleteItemCommand", "id", "String", dm.toJsonType())
            }
        }
        obj.contribJson = match (dms.get("contribJson")) {
            case data: DataModelStruct => data
            case _ => throw Exception("DeleteItemCommand#contribJson: not a DataModelStruct")
        }

        return obj
    }

    public func serialize(): DataModel {
        let dms = DataModelStruct()

        dms.add(field("id", id)).add(Field("contribJson", contribJson))
        return dms
    }

    public static func fromJson(str: String): DeleteItemCommand {
        return str |> JsonValue.fromStr |> DataModel.fromJson |> DeleteItemCommand.deserialize
    }

    public func toJson(): String {
        return this.serialize().toJson().toString()
    }
}
