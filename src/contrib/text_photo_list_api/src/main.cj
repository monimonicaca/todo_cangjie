package text_photo_list_api

import text_photo_list_api.handlers.*
import text_photo_list_api.services.*
import tea.*
import naiveteaset.*
//将dapr放入依赖注入容器中
import naiveteaset.dapr_cangjie_sdk.*

main(): Int64 {
    let tea = Tea.default()
    //使用全局拦截器
    tea.use(globalExceptionHandler)
    //useNaiveIoc也是一个拦截器
    tea.useNaiveIoc {
        services => services |> useDaprClient |> addCustomLogger |> addCustomApplicationServices |> addCustomMediator
    }

    tea |> mapHandlers

    tea.run(8080)
    return 0
}
