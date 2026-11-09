import SwiftUI
import SwiftData

enum TaskFilter: String, CaseIterable, Identifiable {
    case all = "Alles"
    case open = "Open"
    case done = "Afgerond"

    var id: String { rawValue }
}

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \TaskItem.createdAt, order: .reverse) private var tasks: [TaskItem]

    @State private var filter: TaskFilter = .all
    @State private var searchText = ""
    @State private var isAdding = false
    @State private var editingTask: TaskItem?

    private var visibleTasks: [TaskItem] {
        tasks.filter { task in
            let matchesFilter: Bool = switch filter {
            case .all: true
            case .open: !task.isDone
            case .done: task.isDone
            }
            let matchesSearch = searchText.isEmpty
                || task.title.localizedCaseInsensitiveContains(searchText)
                || task.notes.localizedCaseInsensitiveContains(searchText)
            return matchesFilter && matchesSearch
        }
    }

    private var openTasks: [TaskItem] {
        visibleTasks
            .filter { !$0.isDone }
            .sorted { lhs, rhs in
                if lhs.priorityRaw != rhs.priorityRaw { return lhs.priorityRaw > rhs.priorityRaw }
                switch (lhs.dueDate, rhs.dueDate) {
                case let (l?, r?): return l < r
                case (_?, nil): return true
                case (nil, _?): return false
                case (nil, nil): return lhs.createdAt > rhs.createdAt
                }
            }
    }

    private var doneTasks: [TaskItem] {
        visibleTasks
            .filter(\.isDone)
            .sorted { ($0.completedAt ?? .distantPast) > ($1.completedAt ?? .distantPast) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if visibleTasks.isEmpty {
                    emptyState
                } else {
                    taskList
                }
            }
            .navigationTitle("Taken")
            .searchable(text: $searchText, prompt: "Zoek taken")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Picker("Filter", selection: $filter) {
                            ForEach(TaskFilter.allCases) { Text($0.rawValue).tag($0) }
                        }
                        if !tasks.filter(\.isDone).isEmpty {
                            Divider()
                            Button("Wis afgeronde taken", systemImage: "trash", role: .destructive) {
                                clearCompleted()
                            }
                        }
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Nieuwe taak", systemImage: "plus") { isAdding = true }
                }
            }
            .sheet(isPresented: $isAdding) {
                TaskEditorView(task: nil)
            }
            .sheet(item: $editingTask) { task in
                TaskEditorView(task: task)
            }
        }
    }

    private var taskList: some View {
        List {
            if !openTasks.isEmpty {
                Section("Open (\(openTasks.count))") {
                    ForEach(openTasks) { row(for: $0) }
                }
            }
            if !doneTasks.isEmpty {
                Section("Afgerond (\(doneTasks.count))") {
                    ForEach(doneTasks) { row(for: $0) }
                }
            }
        }
        .animation(.default, value: tasks.map(\.isDone))
    }

    private func row(for task: TaskItem) -> some View {
        TaskRow(task: task)
            .contentShape(Rectangle())
            .onTapGesture { editingTask = task }
            .swipeActions(edge: .trailing) {
                Button("Verwijder", systemImage: "trash", role: .destructive) {
                    context.delete(task)
                }
            }
            .swipeActions(edge: .leading) {
                Button(task.isDone ? "Heropen" : "Klaar",
                       systemImage: task.isDone ? "arrow.uturn.backward" : "checkmark") {
                    withAnimation { task.toggle() }
                }
                .tint(task.isDone ? .orange : .green)
            }
    }

    @ViewBuilder
    private var emptyState: some View {
        if !searchText.isEmpty {
            ContentUnavailableView.search(text: searchText)
        } else if tasks.isEmpty {
            ContentUnavailableView {
                Label("Nog geen taken", systemImage: "checklist")
            } description: {
                Text("Tik op + om je eerste taak toe te voegen.")
            } actions: {
                Button("Nieuwe taak") { isAdding = true }
                    .buttonStyle(.borderedProminent)
            }
        } else {
            ContentUnavailableView(
                "Niets te zien",
                systemImage: "line.3.horizontal.decrease.circle",
                description: Text("Geen taken in ‘\(filter.rawValue)’.")
            )
        }
    }

    private func clearCompleted() {
        withAnimation {
            for task in tasks where task.isDone {
                context.delete(task)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewData.container)
}
