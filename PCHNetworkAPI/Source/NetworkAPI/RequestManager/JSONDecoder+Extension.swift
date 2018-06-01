//
//  JSONDecoder+Extension.swift
//  PCHNetworkAPI
//
//  Created by Nicolas Alvarez on 5/31/18.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type,
                              withJSONObject object: Any,
                              options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
