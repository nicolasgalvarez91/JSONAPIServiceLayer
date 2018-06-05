//
//  RequestFetcher.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation
import PromiseKit

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

protocol RequestHandeable {
    init(command: RequestCommandable)

    func execute<Output: HttpResponsable, Model: Decodable>(request: HttpRequestable, expectedModel: Model.Type)
    throws -> Output
}

struct PromiseRequestHandler: RequestHandeable {
    let requestCommand: RequestCommandable

    init(command: RequestCommandable) {
        self.requestCommand = command
    }

    func execute<Output: HttpResponsable, Model: Decodable>(request: HttpRequestable, expectedModel: Model.Type)
    throws -> Output {
        guard let promise = requestCommand.execute(request: request, with: Model.self) as? Output else {
            throw CustomError.parsingError
        }

        return promise
    }
}
