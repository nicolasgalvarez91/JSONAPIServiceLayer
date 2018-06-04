//
//  RequestCommand.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation

protocol RequestCommandable {
    init(executor: RequestExecutable)

    func execute<T: Decodable>(request: HttpRequestable, with expectedType: T.Type) -> HttpResponsable
}

class RequestCommand: RequestCommandable {
    let executor: RequestExecutable

    required init(executor: RequestExecutable = AlamofireRequestExecutor()) {
        self.executor = executor
    }

    func execute<T: Decodable>(request: HttpRequestable, with expectedType: T.Type) -> HttpResponsable {
        return executor.execute(request: request, with: expectedType)
    }
}
