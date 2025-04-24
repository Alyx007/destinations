//
//  Destination.swift
//  Destinations
//
//  Created by Alumno on 23/04/25.
//

import Foundation


struct RespAPI : Codable {
    var destis: [Destination]
}

struct RespAPI_DestinationSpecific : Codable {
    var desti: [Destination]
}

struct Destination: Codable, Identifiable {
    var id: Int
    var name : String
    var country : String
    var description : String
}

extension Destination {
    static var dummy = Destination(id: 1, name: "Dummy", country: "Dummy_Country", description: "Dummy Description")
}
