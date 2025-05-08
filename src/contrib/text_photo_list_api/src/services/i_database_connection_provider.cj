package text_photo_list_api.services

import std.database.sql.*

public interface IDatabaseConnectionProvider {
    func getConnection(): Connection
}
