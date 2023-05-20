//
//  CategoryView.swift
//  SpacedOut
//
//  Created by Michael Rowe on 5/20/23.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    @ObservedObject var category: Category
    
    var body: some View {
        List(category.categoryCards) { card in
            NavigationLink(value: card) {
                Text("\(card.cardFront) / \(card.cardBack)")
            }
        }
        .navigationDestination(for: Card.self) { card in
            CardView(card: card)
        }
        .navigationTitle(category.categoryName)
        .toolbar {
            Button(action: newCard){
                Label("Create new card", systemImage: "plus")
            }
            Button(action: toggleActive) {
                if category.active {
                    Label("Remove from Home Screen", systemImage: "star")
                        .symbolVariant(.fill)
                } else {
                    Label("Show on Home Screen", systemImage: "star")
                }
            }
        }
    }
    
    func newCard() {
        withAnimation {
            let card = Card(context: managedObjectContext)
            card.front = "Front of card"
            card.back = "Back of card"
            card.creationDate = .now
            card.category = category
            dataController.save()
        }
    }
    
    func toggleActive() {
        category.active.toggle()
        dataController.save()
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
