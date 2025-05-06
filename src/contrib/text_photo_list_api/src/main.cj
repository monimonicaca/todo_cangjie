package text_photo_list_api
import text_photo_list_api.handlers.*
import text_photo_list_api.services.*

import tea.*

import naiveteaset.*


main(): Int64 {
    let tea=Tea.default()
    tea.useNaiveIoc{
        services => services |>addCustomApplicationServices
    }

    tea |>mapHandlers

    tea.run(8080)
return 0
}