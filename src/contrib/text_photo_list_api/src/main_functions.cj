package text_photo_list_api
import text_photo_list_api.handlers.*
import text_photo_list_api.services.*
import tea.*

//naiveioc
import naiveioc.*
import naiveioc.abstractions.*
import naiveioc.macros.*

func mapHandlers(tea:Tea):Tea{
tea.post("/add",addHandler)
return tea
}
func addCustomApplicationServices(serviceCollection:INaiveServiceCollection):INaiveServiceCollection{
    //Scoped请求内存活
    @NIAddScoped[serviceCollection](IToDoItemStorage,ToDoItemStorage)
    //全局一个shili
    @NIAddSingleton[serviceCollection](IDatabaseConnectionProvider,DatabaseConnectionProvider)

return serviceCollection
}