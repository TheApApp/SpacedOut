//
//  ContentView.swift
//  SpacedOut
//
//  Created by Michael Rowe on 5/20/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(sortDescriptors: [SortDescriptor(\Category.name), SortDescriptor(\Category.creationDate)], predicate: NSPredicate(format: "active = true")) var activeCategories
    @FetchRequest(sortDescriptors: [SortDescriptor(\Category.name), SortDescriptor(\Category.creationDate)], predicate: NSPredicate(format: "active = false")) var inactiveCategories
    
    var body: some View {
        NavigationStack {
            List {
                if activeCategories.isEmpty == false {
                    Section("Active Categories") {
                        ForEach(activeCategories, content: CategoryRow.init)
                    }
                }
                
                Section("Inactive Categories") {
                    if inactiveCategories.isEmpty {
                        Text("None")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(inactiveCategories, content: CategoryRow.init)
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationDestination(for: Category.self) { category in
                CategoryView(category: category)
            }
            .toolbar {
                Button(action: newCategory) {
                    Label("Create new category", systemImage: "plus")
                }
            }
        }
    }
    
    func newCategory() {
        withAnimation {
            let category = Category(context: managedObjectContext)
            category.name = "New Category"
            category.creationDate = .now
            category.active = false
            dataController.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
