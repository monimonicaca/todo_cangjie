package list_domain.aggregate_models

// naiveseedwork
import naiveseedwork.*

//枚举类
public class ListType <: TypedEnumeration<ListType> & GetAll<ListType> {
    public static const TextImageId: Int64 = 1

    public static let TextImage: ListType = ListType(TextImageId, "TEXT_IMAGE".toAsciiLower(), "TextImageId")

    public init() {}

    public init(id: Int64, name: String, displayName: String) {
        super(id, name, displayName)
    }

    private static let listTypes: Array<ListType> = [TextImage]

    public static func getAll(): Array<ListType> {
        return listTypes
    }
}
