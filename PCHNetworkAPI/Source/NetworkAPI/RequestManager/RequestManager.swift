//
//  RequestManager.swift
//  PCHNetworkAPI
//
//  Created by Nicolas Alvarez on 5/30/18.
//  Copyright © 2018 PCH. All rights reserved.
//
import Alamofire

enum CustomError: Error {
    case common
    case parsingError
    case invalidJSONParsing
    case apiError(body: [String: Any])
}
