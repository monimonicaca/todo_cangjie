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
public class CreateItemCommand <: Hashable & Equatable<CreateItemCommand> & IJsonAdapter<CreateItemCommand> {
    public var listId: Int64 = 0
    //处理任一类型的数据
    public var contribJson: DataModelStruct = DataModelStruct()

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write("CreateItemCommand")
        hasher.write(listId.hashCode())
        hasher.write(contribJson.toJson().toJsonString().hashCode())
        hasher.finish()
    }

    public operator func ==(that: CreateItemCommand): Bool {
        this.hashCode() == that.hashCode()
    }

    public operator func !=(that: CreateItemCommand): Bool {
        this.hashCode() != that.hashCode()
    }

    public static func deserialize(dataModel: DataModel): CreateItemCommand {
        var dms: DataModelStruct = match (dataModel) {
            case data: DataModelStruct => data
            case _ => throw Exception("CreateItemCommand: not a DataModelStruct")
        }
        let obj = CreateItemCommand()

        try {
            obj.listId = Int64.deserialize(dms.get("listId"))
        } catch (e: DataModelException) {
            let dm = dms.get("listId")
            if (dm.isNull()) {
                throw JsonFieldNotExist("CreateItemCommand", "listId")
            } else {
                throw JsonTypeMismatch("CreateItemCommand", "listId", "String", dm.toJsonType())
            }
        }

        obj.contribJson = match (dms.get("contribJson")) {
            case data: DataModelStruct => data
            case _ => throw Exception("CreateItemCommand#contribJson: not a DataModelStruct")
        }

        return obj
    }

    public func serialize(): DataModel {
        let dms = DataModelStruct()

        dms.add(field("listId", listId)).add(Field("contribJson", contribJson))

        return dms
    }

    public static func fromJson(str: String): CreateItemCommand {
        /* let dm = DataModel.fromJson(JsonValue.fromStr(str))
        return CreateItemCommand.deserialize(dm) */
        return str |> JsonValue.fromStr |> DataModel.fromJson |> CreateItemCommand.deserialize
    }

    public func toJson(): String {
        return this.serialize().toJson().toString()
    }
}
