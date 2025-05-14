package list_api.services

import list_infrastructure.*

// naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

// dapr_cangjie_sdk
import dapr_cangjie_sdk.client.*
import std.database.sql.*
import mysqlclient4cj.cdbc.*

@NIService
public class DatabaseConnectionProvider <: IDatabaseConnectionProvider & Resource {
    private let datasource: Datasource

    public DatabaseConnectionProvider(daprClient: DaprClient) {
        //打开数据库连接，执行SQL语句
        let driver = DriverManager.getDriver("mysql") ?? throw Exception("no mysql driver")
        //使用dapr调用密钥服务器获取密钥
        let connectionString = daprClient.getSecret("todo-secretStore", "ConnectionStrings:ListDb")["ConnectionStrings:ListDb"]
        //let connectionString="mysql://root:Pass%40word@todoCj-sqldata"
        datasource = driver.open(connectionString, [("database", "listDb"), ("prepare.mode", "server")])
    }

    public func getConnection(): Connection {
        return datasource.connect()
    }

    public func isClosed(): Bool {
        return datasource.isClosed()
    }

    public func close(): Unit {
        datasource.close()
    }
}
