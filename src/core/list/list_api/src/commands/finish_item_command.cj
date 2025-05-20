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
public class FinishItemCommand <: Hashable & Equatable<FinishItemCommand> & IJsonAdapter<FinishItemCommand> {
    public var id: Int64 = 0

    //处理任一类型的数据
    public var contribJson: DataModelStruct = DataModelStruct()

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write("FinishItemCommand")
        hasher.write(id.hashCode())
        hasher.write(contribJson.toJson().toJsonString().hashCode())
        hasher.finish()
    }

    public operator func ==(that: FinishItemCommand): Bool {
        this.hashCode() == that.hashCode()
    }

    public operator func !=(that: FinishItemCommand): Bool {
        this.hashCode() != that.hashCode()
    }

    public static func deserialize(dataModel: DataModel): FinishItemCommand {
        var dms: DataModelStruct = match (dataModel) {
            case data: DataModelStruct => data
            case _ => throw Exception("FinishItemCommand: not a DataModelStruct")
        }
        let obj = FinishItemCommand()

        try {
            obj.id = Int64.deserialize(dms.get("id"))
        } catch (e: DataModelException) {
            let dm = dms.get("id")

            if (dm.isNull()) {
                throw JsonFieldNotExist("FinishItemCommand", "id")
            } else {
                throw JsonTypeMismatch("FinishItemCommand", "id", "String", dm.toJsonType())
            }
        }
        obj.contribJson = match (dms.get("contribJson")) {
            case data: DataModelStruct => data
            case _ => throw Exception("FinishItemCommand#contribJson: not a DataModelStruct")
        }

        return obj
    }

    public func serialize(): DataModel {
        let dms = DataModelStruct()

        dms.add(field("id", id)).add(Field("contribJson", contribJson))
        return dms
    }

    public static func fromJson(str: String): FinishItemCommand {
        return str |> JsonValue.fromStr |> DataModel.fromJson |> FinishItemCommand.deserialize
    }

    public func toJson(): String {
        return this.serialize().toJson().toString()
    }
}
