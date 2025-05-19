package list_api.utils

import encoding.json.*
import net.http.*
import serialization.serialization.*
import std.io.*

public class RequestUtil {
    public static func getRequest(contribUrl: String, contribJson: String): DataModel {
        let httpClient = ClientBuilder().build()
        let httpRequest = HttpRequestBuilder().method("POST").url(contribUrl).body(contribJson).build()
        let httpResponse = httpClient.send(httpRequest)
        let responseStream = httpResponse.body
        let responseStreamReader = StringReader(responseStream)
        let json = responseStreamReader.readToEnd()
        let jsonValue = JsonValue.fromStr(json)
        let dataModel = DataModel.fromJson(jsonValue)
        return dataModel
    }
}
