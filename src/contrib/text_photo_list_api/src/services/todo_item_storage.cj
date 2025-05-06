package text_photo_list_api.services

import text_photo_list_api.models.*

// naivesqlbuilder
import naivesqlbuilder.builder.*
import naivesqlbuilder.macros.*
import naivesqlbuilder.orm.*
import std.collection.*

import mysqlclient4cj.cdbc.*
import std.database.sql.*
//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

@NIService
public class ToDoItemStorage <:IToDoItemStorage{
    public ToDoItemStorage(
private let connectionProvider:IDatabaseConnectionProvider
    ){}
   public func add(title:String,content:String) :String{
    let(sql,params)= @NSInsertInto(ToDoItem){
        p=> [p.title << title,p.content << content,p.userIdentityGuid<<""]
    }.toSQLWithParams()
    print(sql)
    
   try( connection=connectionProvider.getConnection()){
   let statement= connection.prepareStatement(sql)
   let updateResult=statement.update(params)
  return updateResult.lastInsertId.toString();
   }
    throw Exception("Not Implemented ")
    }
}