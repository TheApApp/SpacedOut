//
//  CardView.swift
//  SpacedOut
//
//  Created by Michael Rowe on 5/20/23.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var card: Card
    
    var body: some View {
        Form {
            TextField("Front of card", text: $card.cardFront)
            TextField("Back of card", text: $card.cardBack)
        }
        .navigationTitle("Edit Card")
        .navigationBarTitleDisplayMode(.inline)
        .onSubmit {
            card.category?.objectWillChange.send() // this will update related views
            dataController.save()
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
