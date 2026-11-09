import Foundation
import SwiftData

/// In-memory voorbeelddata voor SwiftUI-previews.
@MainActor
enum PreviewData {
    static let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: TaskItem.self, configurations: config)
        let calendar = Calendar.current
        let samples = [
            TaskItem(title: "Boodschappen doen", notes: "Melk, brood, appels",
                     dueDate: .now, priority: .high),
            TaskItem(title: "Tandarts bellen",
                     dueDate: calendar.date(byAdding: .day, value: 3, to: .now)),
            TaskItem(title: "Boek uitlezen", priority: .low),
        ]
        for sample in samples {
            container.mainContext.insert(sample)
        }
        let done = TaskItem(title: "Fiets laten maken")
        done.toggle()
        container.mainContext.insert(done)
        return container
    }()
}
