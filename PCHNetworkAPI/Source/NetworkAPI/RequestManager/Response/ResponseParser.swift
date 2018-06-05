//
//  ResponseParser.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Alamofire
import Foundation
import PromiseKit

protocol HttpResponsable { }

extension Promise: HttpResponsable { }

protocol JsonResponse { }

extension DataResponse: JsonResponse { }

protocol ResponseParseable {

    init(decoder: JSONDecoder)

    func handleResponse<T: Decodable>(response: JsonResponse, expectedType: T.Type) throws -> T
}

class AlamofireResponseParser: ResponseParseable {
    let decoder: JSONDecoder

    required init(decoder: JSONDecoder = JSONDecoder()) {
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
