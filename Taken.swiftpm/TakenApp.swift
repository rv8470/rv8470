import SwiftUI
import SwiftData

@main
struct TakenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskItem.self)
    }
}
