//
//  SpacedOutApp.swift
//  SpacedOut
//
//  Created by Michael Rowe on 5/20/23.
//

import SwiftUI

@main
struct SpacedOutApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
