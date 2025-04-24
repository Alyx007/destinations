//
//  DestinationsApp.swift
//  Destinations
//
//  Created by Alumno on 23/04/25.
//

import SwiftUI

@main
struct DestinationsApp: App {
    @State var destinationVM = DestinationViewModel()
    var body: some Scene {
        WindowGroup {
            ListDestinationsView()
                .environment(destinationVM)
        }
    }
}
