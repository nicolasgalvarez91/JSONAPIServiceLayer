//
//  RequestManager.swift
//  PCHNetworkAPI
//
//  Created by Nicolas Alvarez on 5/30/18.
//  Copyright © 2018 PCH. All rights reserved.
//
import Alamofire

protocol RequestExecute {
    func execute<T: Decodable>(request: HttpRequestable, with expectedType: T.Type) -> HTTPResponse
}

protocol HttpRequestable {
    var endpoint: Endpoint { get set }
    var params: [String: Any] { get set }
    var headers: [String: String] { get set }
    var method: HTTPMethod { get set }
}

protocol HTTPResponse { }

enum CustomError: Error {
    case common
    case parsingError
    case invalidJSONParsing
    case apiError(body: [String: Any])
}

protocol ResponseParse {

    var decoder: JSONDecoder { get set }

    func handleResponse<T: Decodable>(response: JsonResponse, expectedType: T.Type) throws -> T
}

protocol JsonResponse { }

