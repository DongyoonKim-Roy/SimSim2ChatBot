//
//  SimSIm2VM.swift
//  SimSim2ChatBot
//
//  Created by Roy's Saxy MacBook on 2/2/23.
//

import Foundation
import Alamofire
import Combine

struct BotResponse : Decodable{
    var status : Int?
    var statusMessage : String
    var atext : String?
    var lang : String
    let request : BotRequest?
}

struct BotRequest : Codable{
    var utext : String?
    var lang : String
}

struct MSG {
    enum MSGType{
        case user
        case bot
    }
    var message : String
    var type : MSGType
    
    init(_ message : String, _ type : MSGType){
        self.message = message
        self.type = type
    }
}

class SimSim2VM : ObservableObject{
    let baseURL : String = "https://wsapi.simsimi.com/190410/talk"
    
    func getResponse(_ message: String, completion : @escaping (String) -> Void){
        /*
                open func request(_ convertible: URLConvertible,
                              method: HTTPMethod = .get,
                              parameters: Parameters? = nil,
                              encoding: ParameterEncoding = URLEncoding.default,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil,
                              requestModifier: RequestModifier? = nil) -> DataRequest {
         */
        
        
        /*
         
         AF.request(baseURL,
                    method: .post,
                    parameters: ["utext" : content, "lang" : "ko"],
                    encoding: JSONEncoding.default
                    ,headers: ["x-api-key" : "QnO5uiqfCHGVa_Zf2PWY7hnDEKMIPRR78X0-WEhj"])
                 .responseDecodable(of: BotResponse.self,
                                    completionHandler: { response in
                     switch response.result {
                     case .success(let botResponse):
                         print(#fileID, #function, #line, "- botResponse: \(botResponse.atext)")
                         completion(botResponse.atext ?? "데이터 없음")
                     case .failure(let failure):
                         print(#fileID, #function, #line, "- failure: \(failure)")
                     }
                 })
         */
        
        AF.request(baseURL,
                   method: .post,
                   parameters: ["utext" : message, "lang" : "en"],
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type" : "application/json", "x-api-key" : "9BbKzVARv3veJvokF0wqlz_PdBqsfoCQr-sag0bS"])
        .responseDecodable(of: BotResponse.self,
        completionHandler: {
            response in
                switch response.result {
                case .success(let succ):
                    completion(succ.atext ?? "no Data")
                case .failure(let fail):
                    print(fail)
                }
        })
    }
}
