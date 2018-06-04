//
//  ViewController.swift
//  PCHNetworkAPI
//
//  Created by User on 5/30/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import PromiseKit
import Swinject
import UIKit

class ViewController: UIViewController, NetworkContainerResolver {

    var container: Container! = Container()
    var requestHandler: RequestHandeable!

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        inject()
        fetchPromiseStuff()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func fetchPromiseStuff() {
        let request = HTTPRequest(endpoint: UserEndpoint.fetch,
                                  httpMethod: .get,
                                  parameters: [:],
                                  headers: [:])
        do {
            let promise: Promise<[User]> = try requestHandler.execute(request: request, expectedModel: [User].self)

            promise.done { users in
                print(users)
            }.catch { error in
                print(error)
            }
        } catch {
            // Handle custom error
        }
    }

    func inject() {
        self.requestHandler = container.resolve(RequestHandeable.self)
    }
}

enum UserEndpoint: Endpoint {
    case fetch

    var path: String {
        switch self {
        case .fetch:
            return "/users"
        }
    }
}

protocol NetworkContainerResolver {
    var container: Container! { get set }

    var requestHandler: RequestHandeable! { get set }

    func build()

    func inject()
}

extension NetworkContainerResolver {
    func build() {
        container.register(ResponseParseable.self) { _ in
            AlamofireResponseParser()
        }

        container.register(RequestExecutable.self) { r in
            AlamofireRequestExecutor(responseHandler: r.resolve(ResponseParseable.self)!)
        }

        container.register(RequestCommandable.self) { r in
            RequestCommand(executor: r.resolve(RequestExecutable.self)!)
        }

        container.register(RequestHandeable.self) { r in
            PromiseRequestHandler(command: r.resolve(RequestCommandable.self)!)
        }
    }
}
