//
//  JSONEncoder+Extension.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T,
                                        options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)

        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}
