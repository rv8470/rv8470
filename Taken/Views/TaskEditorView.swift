import SwiftUI
import SwiftData

/// Formulier om een taak toe te voegen (`task == nil`) of te bewerken.
struct TaskEditorView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let task: TaskItem?

    @State private var title = ""
    @State private var notes = ""
    @State private var hasDueDate = false
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now
    @State private var priority: Priority = .medium
    @FocusState private var titleFocused: Bool

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Titel", text: $title)
                        .focused($titleFocused)
                        .submitLabel(.done)
                        .onSubmit(save)
                    TextField("Notities", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section {
                    Toggle("Deadline", systemImage: "calendar", isOn: $hasDueDate.animation())
                    if hasDueDate {
                        DatePicker("Datum", selection: $dueDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                }

                Section("Prioriteit") {
                    Picker("Prioriteit", selection: $priority) {
                        ForEach(Priority.allCases) { Text($0.label).tag($0) }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }

                if let task {
                    Section {
                        Button(task.isDone ? "Markeer als open" : "Markeer als klaar") {
                            task.toggle()
                            dismiss()
                        }
                        Button("Verwijder taak", role: .destructive) {
                            context.delete(task)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle(task == nil ? "Nieuwe taak" : "Bewerk taak")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuleer", role: .cancel) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Bewaar", action: save)
                        .disabled(trimmedTitle.isEmpty)
                }
            }
            .onAppear(perform: load)
        }
        .presentationDetents([.large])
    }

    private func load() {
        guard let task else {
            titleFocused = true
            return
        }
        title = task.title
        notes = task.notes
        hasDueDate = task.dueDate != nil
        if let date = task.dueDate { dueDate = date }
        priority = task.priority
    }

    private func save() {
        guard !trimmedTitle.isEmpty else { return }
        let due = hasDueDate ? dueDate : nil
        if let task {
            task.title = trimmedTitle
            task.notes = notes
            task.dueDate = due
            task.priority = priority
        } else {
            context.insert(TaskItem(title: trimmedTitle, notes: notes, dueDate: due, priority: priority))
        }
        dismiss()
    }
}

#Preview("Nieuw") {
    TaskEditorView(task: nil)
        .modelContainer(PreviewData.container)
}
