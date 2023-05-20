//
//  CategoryRow.swift
//  SpacedOut
//
//  Created by Michael Rowe on 5/20/23.
//

import SwiftUI

struct CategoryRow: View {
    @ObservedObject var category: Category
    
    var body: some View {
        NavigationLink(value: category) {
            HStack {
                if category.active {
                    Image(systemName: "star")
                        .symbolVariant(.fill)
                }
                
                Text(category.categoryName)
            }
            .badge(category.categoryCards.count)
        }
    }
}

//struct CategoryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryRow()
//    }
//}
