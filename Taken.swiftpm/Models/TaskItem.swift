import Foundation
import SwiftData
import SwiftUI

enum Priority: Int, CaseIterable, Identifiable {
    case low = 0
    case medium = 1
    case high = 2

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .low: "Laag"
        case .medium: "Normaal"
        case .high: "Hoog"
        }
    }

    var color: Color {
        switch self {
        case .low: .gray
        case .medium: .blue
        case .high: .red
        }
    }
}

@Model
final class TaskItem {
    var title: String
    var notes: String
    var isDone: Bool
    var dueDate: Date?
    var priorityRaw: Int
    var createdAt: Date
    var completedAt: Date?

    init(
        title: String,
        notes: String = "",
        dueDate: Date? = nil,
        priority: Priority = .medium
    ) {
        self.title = title
        self.notes = notes
        self.isDone = false
        self.dueDate = dueDate
        self.priorityRaw = priority.rawValue
        self.createdAt = .now
        self.completedAt = nil
    }

    var priority: Priority {
        get { Priority(rawValue: priorityRaw) ?? .medium }
        set { priorityRaw = newValue.rawValue }
    }

    var isOverdue: Bool {
        guard !isDone, let dueDate else { return false }
        return dueDate < Calendar.current.startOfDay(for: .now)
    }

    func toggle() {
        isDone.toggle()
        completedAt = isDone ? .now : nil
    }
}
