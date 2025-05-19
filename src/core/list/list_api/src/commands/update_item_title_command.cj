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
public class UpdateItemTitleCommand <: Hashable & Equatable<UpdateItemTitleCommand> & IJsonAdapter<UpdateItemTitleCommand> {
    public var id: Int64 = 0

    //处理任一类型的数据
    public var contribJson: DataModelStruct = DataModelStruct()

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write("UpdateItemTitleCommand")
        hasher.write(id.hashCode())
        hasher.write(contribJson.toJson().toJsonString().hashCode())
        hasher.finish()
    }

    public operator func ==(that: UpdateItemTitleCommand): Bool {
        this.hashCode() == that.hashCode()
    }

    public operator func !=(that: UpdateItemTitleCommand): Bool {
        this.hashCode() != that.hashCode()
    }

    public static func deserialize(dataModel: DataModel): UpdateItemTitleCommand {
        var dms: DataModelStruct = match (dataModel) {
            case data: DataModelStruct => data
            case _ => throw Exception("UpdateItemTitleCommand: not a DataModelStruct")
        }
        let obj = UpdateItemTitleCommand()

        try {
            obj.id = Int64.deserialize(dms.get("id"))
        } catch (e: DataModelException) {
            let dm = dms.get("id")

            if (dm.isNull()) {
                throw JsonFieldNotExist("UpdateItemTitleCommand", "id")
            } else {
                throw JsonTypeMismatch("UpdateItemTitleCommand", "id", "String", dm.toJsonType())
            }
        }
        obj.contribJson = match (dms.get("contribJson")) {
            case data: DataModelStruct => data
            case _ => throw Exception("UpdateItemTitleCommand#contribJson: not a DataModelStruct")
        }

        return obj
    }

    public func serialize(): DataModel {
        let dms = DataModelStruct()

        dms.add(field("id", id)).add(Field("contribJson", contribJson))
        return dms
    }

    public static func fromJson(str: String): UpdateItemTitleCommand {
        return str |> JsonValue.fromStr |> DataModel.fromJson |> UpdateItemTitleCommand.deserialize
    }

    public func toJson(): String {
        return this.serialize().toJson().toString()
    }
}
