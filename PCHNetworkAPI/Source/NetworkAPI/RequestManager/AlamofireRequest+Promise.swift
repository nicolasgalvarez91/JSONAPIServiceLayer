//
//  AlamofireRequest+Promise.swift
//  PCHNetworkAPI
//
//  Created by User on 5/31/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

extension DataResponse: JsonResponse { }

extension Promise: HTTPResponse { }

class AlamofireRequest: RequestExecute {
    let responseHandler: ResponseParse
    
    init(responseHandler: ResponseParse = AlamofireResponse()) {
        self.responseHandler = responseHandler
    }
    
    func execute<T: Decodable>(request: HttpRequestable, with expectedType: T.Type) -> HTTPResponse {
        return Promise<T> { seal in
            Alamofire.request(request.endpoint.buildURL(),
                              method: request.method,
                              parameters: request.params,
                              encoding: JSONEncoding.default,
                              headers: request.headers)
                .validate()
                .responseJSON { response in
                    do {
                        let parsedResponse = try self.responseHandler.handleResponse(response: response, expectedType: T.self)
                        seal.fulfill(parsedResponse)
                    } catch {
                        NSLog(error.localizedDescription)
                        seal.reject(error)
                    }
                    
                    
            }
        }
        
    }
}

class AlamofireResponse: ResponseParse {
    var decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func handleResponse<T: Decodable>(response: JsonResponse, expectedType: T.Type) throws -> T {
        guard let responseData = response as? DataResponse<Any> else { throw CustomError.common }
        switch responseData.result {
        case .success(let value):
            do {
                let decodedValue = try decoder.decode(T.self, withJSONObject: value)
                return decodedValue
            } catch {
                throw CustomError.invalidJSONParsing
            }
        case .failure:
            guard let errorData = try JSONSerialization.jsonObject(with: responseData.data!) as? [String: Any] else {
                throw CustomError.parsingError
            }
            throw CustomError.apiError(body: errorData)
        }
    }
}
