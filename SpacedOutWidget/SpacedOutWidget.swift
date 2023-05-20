//
//  SpacedOutWidget.swift
//  SpacedOutWidget
//
//  Created by Michael Rowe on 5/20/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    static var dataController = DataController()  // basically a singleton
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: .now, text: "Example Card")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let cards = loadCards()
        let text = cards.first ?? "Example Card"
        let entry = SimpleEntry(date: .now, text: text)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries =  [SimpleEntry]()
        let cards  = loadCards()

        if cards.isEmpty {
            let entry = SimpleEntry(date: .now, text: "No Active Categories")
            entries.append(entry)
        } else {
            let currentDate = Date.now
            var minuteOffset = 0
            
            for card in cards {
                let date = Calendar.current.date(byAdding: .second, value: minuteOffset * 3, to: currentDate) ?? .now
                let entry = SimpleEntry(date: date, text: card)
                entries.append(entry)
                minuteOffset += 1
                
            }
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func loadCards() -> [String] {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "active = true")
        
        let categories = (try? Self.dataController.container.viewContext.fetch(request)) ?? []
        
        let items = categories.reduce(into: [String]()) { array, category in
            for card in category.categoryCards {
                array.append(card.cardFront)
                array.append(card.cardBack)
            }
        }
        
        return items.shuffled()
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var text: String
}

struct SpacedOutWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.text)
            .multilineTextAlignment(.center)
    }
}

struct SpacedOutWidget: Widget {
    let kind: String = "SpacedOutWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SpacedOutWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Learn Cards")
        .description("Shows random front and back text from cards in your active categories.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryRectangular])  // accessoryRectangular means you support a lockscreen widget
    }
}

//struct SpacedOutWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        SpacedOutWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
