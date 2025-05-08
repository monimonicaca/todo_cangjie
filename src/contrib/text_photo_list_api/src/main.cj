package text_photo_list_api

import text_photo_list_api.handlers.*
import text_photo_list_api.services.*
import tea.*
import naiveteaset.*
//将dapr放入依赖注入容器中
import naiveteaset.dapr_cangjie_sdk.*

main(): Int64 {
    let tea = Tea.default()
    tea.useNaiveIoc {
        services => services |> useDaprClient |> addCustomApplicationServices |> addCustomMediator
    }

    tea |> mapHandlers

    tea.run(8080)
    return 0
}
