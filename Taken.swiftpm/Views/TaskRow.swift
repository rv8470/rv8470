import SwiftUI
import SwiftData

struct TaskRow: View {
    let task: TaskItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button {
                withAnimation(.snappy) { task.toggle() }
            } label: {
                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(task.isDone ? Color.green : task.priority.color)
                    .contentTransition(.symbolEffect(.replace))
            }
            .buttonStyle(.plain)
            .accessibilityLabel(task.isDone ? "Markeer als open" : "Markeer als klaar")
            .sensoryFeedback(.success, trigger: task.isDone) { _, newValue in newValue }

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.body)
                    .strikethrough(task.isDone)
                    .foregroundStyle(task.isDone ? .secondary : .primary)

                if !task.notes.isEmpty {
                    Text(task.notes)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                if task.dueDate != nil || task.priority == .high {
                    HStack(spacing: 8) {
                        if let dueDate = task.dueDate {
                            Label(dueDate.formatted(.dateTime.day().month(.abbreviated)),
                                  systemImage: "calendar")
                                .foregroundStyle(task.isOverdue ? Color.red : Color.secondary)
                        }
                        if task.priority == .high && !task.isDone {
                            Label("Hoog", systemImage: "exclamationmark")
                                .foregroundStyle(.red)
                        }
                    }
                    .font(.caption)
                    .labelStyle(.titleAndIcon)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 2)
    }
}
