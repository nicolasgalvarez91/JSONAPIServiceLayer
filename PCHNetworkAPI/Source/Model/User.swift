//
//  User.swift
//  PCHNetworkAPI
//
//  Created by Nahuel Zapata on 01/06/2018.
//  Copyright © 2018 PCH. All rights reserved.
//

import Foundation

class User: Codable {
    var id: Int!
    var name: String!
    var username: String!
    var email: String!
    var address: Address!
    var phone: String!
    var website: String!
    var company: Company!
}

class Address: Codable {
    var street: String!
    var suite: String!
    var city: String!
    var zipCode: String!
    var geo: Location!
}

class Location: Codable {
    var lat: String!
    var lng: String!
}

class Company: Codable {
    var name: String!
    var catchPhrase: String!
    var bs: String!
}
