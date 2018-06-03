//
//  RequestFetcher.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation
import PromiseKit
import ReactiveSwift

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

protocol RequestHandeable {
    func execute<Model: Decodable>(request: HttpRequestable, expectedModel: Model.Type) -> Promise<Model>
}

struct RequestHandler: RequestHandeable {
    let requestCommand: RequestCommandable

    init(command: RequestCommandable = RequestCommand()) {
        self.requestCommand = command
    }

    func execute<Model: Decodable>(request: HttpRequestable, expectedModel: Model.Type) -> Promise<Model> {
        guard let promise = requestCommand.execute(request: request, with: Model.self) as? Promise<Model> else {
            return Promise { seal in
                seal.reject(CustomError.parsingError)
            }
        }

        return promise
    }
}

extension SignalProducer: HttpResponsable { }

extension Signal: HttpResponsable { }

protocol RequestHandable {

    init(command: RequestCommandable)

    func execute<Model: Decodable>(request: HttpRequestable, expectedModel: Model.Type) -> HttpResponsable
}

class ReactiveRequestHandler: RequestHandable {
    private let requestCommand: RequestCommandable

    required init(command: RequestCommandable = RequestCommand()) {
        self.requestCommand = command
    }

    func execute<Model: Decodable>(request: HttpRequestable, expectedModel: Model.Type) -> HttpResponsable {
        guard let signalProducer = requestCommand.execute(request: request, with: Model.self)
        as? SignalProducer<Model, CustomError> else {
            return SignalProducer<Model, CustomError>(error: CustomError.common)
        }

        return signalProducer
    }

    func execute<Output, Model: Decodable>(request: HttpRequestable, expectedModel: Model.Type) -> Output where Output: HttpResponsable {

        guard let signalProducer = requestCommand.execute(request: request, with: Model.self)
        as? Output else {
            return SignalProducer<Model, CustomError>(error: CustomError.common) as! Output
        }

        return signalProducer
    }
}
