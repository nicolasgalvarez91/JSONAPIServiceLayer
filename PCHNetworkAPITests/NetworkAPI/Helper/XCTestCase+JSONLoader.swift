//
//  XCTestCase+JSONLoader.swift
//
//
//  Created by Nahuel Zapata on 01/06/2018.
//

import Foundation
import XCTest

protocol JSONLoader {
    func loadJson(with fileName: String) -> [[String: Any]]
}

extension JSONLoader {
    func loadJson(with fileName: String) -> [[String: Any]] {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)

                let serialized = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

                guard let json = serialized as? [[String: Any]] else {
                    return [[String: Any]]()
                }

                return json
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }

        return [[String: Any]]()
    }
}

extension XCTestCase: JSONLoader { }
