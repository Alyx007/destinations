//
//  DestinationDetailView.swift
//  Destinations
//
//  Created by Alumno on 23/04/25.
//

import SwiftUI

struct DestinationDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(DestinationViewModel.self) var destinationVM
    
    var destinationEdit : Destination?
    @State var name = ""
    @State var country = ""
    @State var description = ""

    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack{
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .keyboardType(.default)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                TextField("Country", text: $country)
                TextField("Description", text: $description)
                
                Button(destinationEdit == nil ? "Agregar" : "Actualizar") {
                    Task {
                        if let destination = destinationEdit {
                            let actualizado = Destination(id: destination.id, name: name, country: country, description: description)
                            print(actualizado)
                            await destinationVM.updateDestination(destination: actualizado)
                            alertMessage = destinationVM.errorMessage ?? "Destination actualizado correctamente."
                        } else {
                            let newDestination = Destination(id: 0, name: name, country: country, description: description)
                            print(newDestination)
                            await destinationVM.addDestination(destination: newDestination)
                            alertMessage = destinationVM.errorMessage ?? "Destination agregado correctamente."
                        }
                        showAlert = true
                    }
                }
            }
            .navigationTitle(destinationEdit == nil ? "New Destination" : "Edit Destination")
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK") {
                    if destinationVM.errorMessage == nil {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let destination = destinationEdit {
                    name = destination.name
                    country = destination.country
                    description = destination.description
                }
            }
        }
    }
}

#Preview {
    DestinationDetailView()
        .environment(DestinationViewModel()) // For testing "Add" mode
}

#Preview("Edit Mode") {
    DestinationDetailView(destinationEdit: Destination.dummy) // For testing "Edit" mode
        .environment(DestinationViewModel())
}
