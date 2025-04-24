//
//  ListDestinationsView.swift
//  Destinations
//
//  Created by Alumno on 23/04/25.
//

import SwiftUI

struct ListDestinationsView: View {

    @Environment(DestinationViewModel.self) var destinationVM
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
                List(destinationVM.arrUDestination) { destination in
                    NavigationLink {
                        DestinationDetailView(destinationEdit: destination)
                    } label: {
                        Text(destination.name)
                    }

                    
                }
                .task {
                    await destinationVM.fetchDestinations()
                }
                .overlay{
                    if let error = destinationVM.errorMessage {
                        Text(error)
                    }
                }
            }
            .navigationTitle("Destinations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: DestinationDetailView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
    }
}

#Preview("Live Data Preview") {
    ListDestinationsView()
        .environment(DestinationViewModel()) // Uses real network call (if fetchDestinations() is implemented)
}

#Preview("Dummy Data Preview") {
    let mockVM = DestinationViewModel()
    mockVM.arrUDestination = [
        Destination.dummy,
        Destination(id: 2, name: "Paris", country: "France", description: "City of Lights"),
        Destination(id: 3, name: "Tokyo", country: "Japan", description: "Capital of Japan")
    ] // Inject various dummy data
    return ListDestinationsView()
        .environment(mockVM)
}
