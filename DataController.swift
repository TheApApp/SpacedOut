//
//  DataController.swift
//  SpacedOut
//
//  Created by Michael Rowe on 5/20/23.
//

import CoreData
import WidgetKit

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Model") // this is the data model
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        let groupID = "group.com.theapapp.spacedout2"
        
        if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupID) {
            container.persistentStoreDescriptions.first?.url = url.appending(path: "Model.sqlite")  // this is the live user data - the names don't have to match
        }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
            WidgetCenter.shared.reloadAllTimelines() // this will notify widges to update if there is change to the data
        }
    }
}
