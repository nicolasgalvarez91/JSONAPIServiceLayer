//
//  ViewController.swift
//  PCHNetworkAPI
//
//  Created by User on 5/30/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import PromiseKit
import UIKit

class ViewController: UIViewController {

    var requestHandler: RequestHandeable = RequestHandler()

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
