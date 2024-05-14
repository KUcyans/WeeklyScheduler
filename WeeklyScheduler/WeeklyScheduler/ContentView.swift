//
//  ContentView.swift
//  WeeklyScheduler
//
//  Created by Cyan on 14/05/2024.
//

import SwiftUI

// Sample data
var initialData: [Day] = [
    Day(name: "Monday", tasks: [Task(name: "Meeting with Bob"), Task(name: "Gym")]),
    Day(name: "Tuesday", tasks: [Task(name: "Buy groceries"), Task(name: "Doctor appointment")]),
    Day(name: "Wednesday", tasks: [Task(name: "Work on project"), Task(name: "Dinner with Alice")]),
    Day(name: "Thursday", tasks: [Task(name: "Call mom"), Task(name: "Team meeting")]),
    Day(name: "Friday", tasks: [Task(name: "Submit report"), Task(name: "Movie night")]),
    Day(name: "Saturday", tasks: [Task(name: "Clean house"), Task(name: "Read book")]),
    Day(name: "Sunday", tasks: [Task(name: "Relax"), Task(name: "Plan next week")])
]

struct ContentView: View {
    @State private var data: [Day] = initialData // Use @State for dynamic data
    @State private var newTaskName: String = ""
    @State private var isEditing: Bool = false
    @State private var taskToEdit: Task? = nil
    @State private var editedTaskName: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(data) { day in
                    Section(header: Text(day.name).font(.headline)) {
                        ForEach(day.tasks) { task in
                            HStack {
                                Text(task.name)
                                Spacer()
                                if task.done {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.red)
                                }
                                Button(action: {
                                    startEditing(task)
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.blue)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                markTaskAsDone(day: day, task: task)
                            }
                        }
                        .onDelete { indexSet in
                            removeTask(from: day, at: indexSet)
                        }
                        HStack {
                            TextField("New task", text: $newTaskName)
                            Button(action: {
                                addTask(to: day)
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Weekly Scheduler")
            .sheet(isPresented: $isEditing) {
                if let task = taskToEdit {
                    VStack {
                        TextField("Edit task", text: $editedTaskName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button("Save") {
                            editTask(task)
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }

    // Functions to modify the tasks
    func markTaskAsDone(day: Day, task: Task) {
        if let dayIndex = data.firstIndex(where: { $0.id == day.id }) {
            if let taskIndex = data[dayIndex].tasks.firstIndex(where: { $0.id == task.id }) {
                data[dayIndex].tasks[taskIndex].done.toggle()
            }
        }
    }

    func removeTask(from day: Day, at offsets: IndexSet) {
        if let dayIndex = data.firstIndex(where: { $0.id == day.id }) {
            data[dayIndex].tasks.remove(atOffsets: offsets)
        }
    }

    func addTask(to day: Day) {
        if let dayIndex = data.firstIndex(where: { $0.id == day.id }), !newTaskName.isEmpty {
            data[dayIndex].tasks.append(Task(name: newTaskName))
            newTaskName = ""
        }
    }

    func startEditing(_ task: Task) {
        taskToEdit = task
        editedTaskName = task.name
        isEditing = true
    }

    func editTask(_ task: Task) {
        if let dayIndex = data.firstIndex(where: { $0.tasks.contains(where: { $0.id == task.id }) }) {
            if let taskIndex = data[dayIndex].tasks.firstIndex(where: { $0.id == task.id }) {
                data[dayIndex].tasks[taskIndex].name = editedTaskName
                isEditing = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
