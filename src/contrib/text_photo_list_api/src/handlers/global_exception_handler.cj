package text_photo_list_api.handlers

// naiveserviceresult
import naiveserviceresult.*

// tea
import tea.*

public func globalExceptionHandler(p: TeaContext): Unit {
    try {
        //执行下一个拦截器
        p.next()
    } catch (e: Exception) {
        e.printStackTrace()
        p.json(200, ServiceResult.exception(e).toViewModel())
    }
}
