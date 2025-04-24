//
//  DestinationViewModel.swift
//  Destinations
//
//  Created by Alumno on 23/04/25.
//

import SwiftUI

@MainActor
@Observable
class DestinationViewModel {
    var arrUDestination: [Destination] = []
    var errorMessage: String?
    
    let service = PostService()
    
    init(){
        Task{
            await fetchDestinations()
        }
    }
    
    func fetchDestinations() async {
        do {
            
            self.arrUDestination = try await service.fetchDestinations()
            
        } catch {
            guard error is PostError else {
                print("DEBUG: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            
        }
    }
    
    func addDestination(destination : Destination) async {
        do {
            
            try await service.addDestination(destination: destination)
            
        } catch {
            guard error is PostError else {
                print("DEBUG: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            
        }
    }
 
    func updateDestination(destination : Destination) async {
        do {
            
            try await service.updateDestination(destination: destination)
            
        } catch {
            guard error is PostError else {
                print("DEBUG: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            
        }
    }
    
    func deleteDestination(id : Int) async {
        do {
            
            try await service.deleteDestination(id: id)
            
        } catch {
            guard error is PostError else {
                print("DEBUG: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            
        }
    }
    
    func fetchDestinationSpecific(id : Int) async -> Destination{
        var resp_destination = Destination(id: 0, name: "", country: "", description: "")
        
        do {
            
            resp_destination = try await service.fetchDestinationSpecific(id: id)
            return resp_destination
            
        } catch {
            guard error is PostError else {
                print("DEBUG: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return resp_destination
            }
            
        }
        
        return resp_destination
    }
}
