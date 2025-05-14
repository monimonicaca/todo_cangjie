package list_domain.exceptions

import naiveseedwork.*

public class ListDomainException <: DomainException {
    public init() {
        this("")
    }

    public init(message: String) {
        this(message, None)
    }

    public init(message: String, innerException: ?Exception) {
        super(message, innerException)
    }
}
