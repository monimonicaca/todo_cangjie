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
public class UpdateItemContentCommand <: Hashable & Equatable<UpdateItemContentCommand> & IJsonAdapter<UpdateItemContentCommand> {
    public var id: Int64 = 0
    public var listId: Int64 = 0
    //处理任一类型的数据
    public var contribJson: DataModelStruct = DataModelStruct()

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write("UpdateItemContentCommand")
        hasher.write(id.hashCode())
        hasher.write(listId.hashCode())
        hasher.write(contribJson.toJson().toJsonString().hashCode())
        hasher.finish()
    }

    public operator func ==(that: UpdateItemContentCommand): Bool {
        this.hashCode() == that.hashCode()
    }

    public operator func !=(that: UpdateItemContentCommand): Bool {
        this.hashCode() != that.hashCode()
    }

    public static func deserialize(dataModel: DataModel): UpdateItemContentCommand {
        var dms: DataModelStruct = match (dataModel) {
            case data: DataModelStruct => data
            case _ => throw Exception("UpdateItemContentCommand: not a DataModelStruct")
        }
        let obj = UpdateItemContentCommand()

        try {
            obj.id = Int64.deserialize(dms.get("id"))
            obj.listId = Int64.deserialize(dms.get("listId"))
        } catch (e: DataModelException) {
            let dm = dms.get("id")
            let dm2 = dms.get("listId")
            if (dm.isNull()) {
                throw JsonFieldNotExist("UpdateItemContentCommand", "id")
            } else {
                throw JsonTypeMismatch("UpdateItemContentCommand", "id", "String", dm.toJsonType())
            }
            if (dm2.isNull()) {
                throw JsonFieldNotExist("UpdateItemContentCommand", "listId")
            } else {
                throw JsonTypeMismatch("UpdateItemContentCommand", "listId", "String", dm2.toJsonType())
            }
        }

        obj.contribJson = match (dms.get("contribJson")) {
            case data: DataModelStruct => data
            case _ => throw Exception("UpdateItemContentCommand#contribJson: not a DataModelStruct")
        }

        return obj
    }

    public func serialize(): DataModel {
        let dms = DataModelStruct()

        dms.add(field("id", id)).add(field("listId", listId)).add(Field("contribJson", contribJson))
        return dms
    }

    public static func fromJson(str: String): UpdateItemContentCommand {
        return str |> JsonValue.fromStr |> DataModel.fromJson |> UpdateItemContentCommand.deserialize
    }

    public func toJson(): String {
        return this.serialize().toJson().toString()
    }
}
