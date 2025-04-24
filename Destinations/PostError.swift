//
//  PostError.swift
//  Destinations
//
//  Created by Alumno on 23/04/25.
//

import Foundation

enum PostError: Error {
    case invalidData
    case requestError(description: String)
    case badStatusCode(code:Int)
    case failedParsing
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Datos invalidos"
        case .requestError(let description):
            return "Request fallida \(description)"
        case .badStatusCode(let code):
            return "Request fallida con status \(code)"
        case .failedParsing:
            return "Error al parseo del JSON"
        case .unknownError(let error):
            return "Error desconocido \(error.localizedDescription)"
        }
    }
}
