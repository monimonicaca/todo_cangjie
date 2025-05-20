package todo_list_api.services

//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*
import std.database.sql.*

//dapr
import dapr_cangjie_sdk.client.*

@NIService
public class DatabaseConnectionProvider <: IDatabaseConnectionProvider {
    private let datasource: Datasource
    public DatabaseConnectionProvider(daprClient: DaprClient) {
        //打开数据库连接，执行SQL语句
        let driver = DriverManager.getDriver("mysql") ?? throw Exception("no mysql driver")
        //使用dapr调用密钥服务器获取密钥
        let connectionString = daprClient.getSecret("todo-secretStore", "ConnectionStrings:TodoListDb")["ConnectionStrings:TodoListDb"]
        //let connectionString="mysql://root:Pass%40word@todoCj-sqldata"
        datasource = driver.open(connectionString, [("database", "todoListDb"), ("prepare.mode", "server")])
    }
    public func getConnection(): Connection {
        return datasource.connect()
    }
}
