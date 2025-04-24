//
//  PostService.swift
//  Destinations
//
//  Created by Alumno on 23/04/25.
//

import Foundation

class PostService {
    private let baseURL = "http://0.0.0.0:0000/destinations/"
    
    func fetchDestinations() async throws -> [Destination] {
        guard let url = URL(string: baseURL+"/") else {
            throw PostError.requestError(description: "Bad URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw PostError.requestError(description: "Bad response")
        }
        
        guard response.statusCode == 200 else {
            throw PostError.badStatusCode(code: response.statusCode)
        }
        
        do{
            let destinations = try JSONDecoder().decode(RespAPI.self, from: data)
            
            return destinations.destis
            
        } catch {
            throw PostError.unknownError(error: error)
            
        }
        
    }
    
    func addDestination(destination : Destination) async throws {
        guard let url = URL(string: baseURL+"/add") else {
            throw PostError.requestError(description: "Bad URL")
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        print(destination)
        let jsonData = try JSONEncoder().encode(destination)
        request.httpBody = jsonData
        
        print(String(data: jsonData, encoding: .utf8)!)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        
        guard let response = response as? HTTPURLResponse else {
            throw PostError.requestError(description: "Bad response")
        }
        
        guard response.statusCode == 200 else {
            throw PostError.badStatusCode(code: response.statusCode)
        }
        
        
    }
    
    func updateDestination(destination : Destination) async throws {
        guard let url = URL(string: baseURL+"/update/\(destination.id)") else {
            throw PostError.requestError(description: "Bad URL")
        }
        
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
        let jsonData = try JSONEncoder().encode(destination)
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        guard let response = response as? HTTPURLResponse else {
            throw PostError.requestError(description: "Bad response")
        }
        
        guard response.statusCode == 200 else {
            throw PostError.badStatusCode(code: response.statusCode)
        }
        
        
    }
    
    func deleteDestination(id: Int) async throws {
        guard let url = URL(string: baseURL+"/delete/\(id)") else {
            throw PostError.requestError(description: "Bad URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw PostError.requestError(description: "Bad response")
        }
        
        guard response.statusCode == 200 else {
            throw PostError.badStatusCode(code: response.statusCode)
        }
    }
    
    func fetchDestinationSpecific(id: Int) async throws -> Destination {
        guard let url = URL(string: baseURL+"/\(id)") else {
            throw PostError.requestError(description: "Bad URL")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw PostError.requestError(description: "Bad response")
        }
        
        guard response.statusCode == 200 else {
            throw PostError.badStatusCode(code: response.statusCode)
        }
        
        do{
            let resp_destination = try JSONDecoder().decode(RespAPI_DestinationSpecific.self, from: data)
            
            return resp_destination.desti[0]
            
        } catch {
            throw PostError.unknownError(error: error)
            
        }
        
    }
}
