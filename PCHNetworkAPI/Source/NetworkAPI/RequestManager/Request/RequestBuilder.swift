//
//  RequestBuilder.swift
//  PCHNetworkAPI
//
//  Created by Nicolas Alvarez on 6/8/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestBuildeable {
    func build() -> HTTPRequest
    func consume(endpoint: Endpoint) -> RequestBuildeable
    func withMethod(_ httpMethod: HTTPMethod) -> RequestBuildeable
    func filterBy(params: [String: Any]) -> RequestBuildeable
    func withHeaders(_ headers: [String: String]) -> RequestBuildeable
    func withEncoding(_ encoding: JSONEncoding) -> RequestBuildeable
    
}

class RequestBuilder: RequestBuildeable {
    
    private var endpoint :  Endpoint!
    
    private var method : HTTPMethod!
    
    private var params = [String: Any]()
    
    private var encoding = JSONEncoding()
    
    private var headers = [String: String]()
    
    init() {
    }
    
    @discardableResult
    func build() -> HTTPRequest {
        return HTTPRequest(endpoint: endpoint,
                           httpMethod: method,
                           parameters: params,
                           encoding: encoding,
                           headers: headers)
    }
    
    @discardableResult
    func consume(endpoint: Endpoint) -> RequestBuildeable {
        self.endpoint = endpoint
        return self
    }
    
    @discardableResult
    func withMethod(_ httpMethod: HTTPMethod) -> RequestBuildeable {
        self.method = httpMethod
        return self
    }
    
    @discardableResult
    func filterBy(params: [String : Any]) -> RequestBuildeable {
        self.params = params
        return self
    }
    
    @discardableResult
    func withHeaders(_ headers: [String : String]) -> RequestBuildeable {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func withEncoding(_ encoding: JSONEncoding) -> RequestBuildeable {
        self.encoding = encoding
        return self
    }
}
