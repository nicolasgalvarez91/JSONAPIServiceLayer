//
//  ViewController.swift
//  PCHNetworkAPI
//
//  Created by User on 5/30/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import PromiseKit
import ReactiveSwift
import UIKit

class ViewController: UIViewController {

    var requestHandler: RequestHandeable = RequestHandler()
    let racRequestHandler = ReactiveRequestHandler()

    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchStuff()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func fetchStuff() {
        let request = HTTPRequest(endpoint: UserEndpoint.fetch,
                                  httpMethod: .get,
                                  parameters: [:],
                                  headers: [:])

        requestHandler.execute(request: request, expectedModel: [User].self)
            .done { users in
                print(users)
            }.catch { error in
                print(error)
        }
    }

    func fetchReactiveStuff() {
        let request = HTTPRequest(endpoint: UserEndpoint.fetch,
                                  httpMethod: .get,
                                  parameters: [:],
                                  headers: [:])
        let signal: Signal<[User], CustomError> = racRequestHandler.execute(request: request, expectedModel: [User].self)
        signal.observe { action in
            switch action.event {
            case .value(let users):
                self.users = users
            case .failed(let error):
                print(error)

            default:
                print("Sarasa")
                // Show specific error
//            case .completed:
//                // Dispose
//            case .interrupted:
            }
        }
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
