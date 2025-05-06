package text_photo_list_api.services

//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

import std.database.sql.*

@NIService
public class DatabaseConnectionProvider <:IDatabaseConnectionProvider{
private let datasource:Datasource
public DatabaseConnectionProvider(){
    //打开数据库连接，执行SQL语句
    let driver=DriverManager.getDriver("mysql")??throw Exception("no mysql driver")
    //使用dapr调用密钥服务器获取密钥
    let connectionString="mysql://root:Pass%40word@todoCj-sqldata"
    datasource=driver.open(connectionString,[("database","todoListDb"),("prepare.mode","server")])
}
public func getConnection():Connection{
datasource.connect()
throw Exception("not implemented")
}
}