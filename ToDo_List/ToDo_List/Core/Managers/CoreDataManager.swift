//
//  CoreDataManager.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 31.08.24.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Tasks CRUD
    func fetchTasks(completion: @escaping (Result<[TaskModel], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
        
        do {
            let tasks = try context.fetch(fetchRequest)
            completion(.success(tasks))
        } catch {
            completion(.failure(error))
        }
    }
    
    func addTask(title: String, description: String?) {
        let task = TaskModel(context: context)
        task.title = title
        task.taskDescription = description
        task.createdAt = Date()
        task.isCompleted = false
        saveContext()
    }
    
    func updateTask(task: TaskModel) {
        saveContext()
    }
    
    func deleteTask(task: TaskModel) {
        context.delete(task)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}

// MARK: - Fetch tasks from API on FirstLaunch
extension CoreDataManager {
    func fetchTasksFromAPI(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(false)
                return
            }
            
            guard let data = data else {
                completion(false)
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let todosArray = jsonResponse["todos"] as? [[String: Any]] {
                    self.saveTasksToCoreData(jsonArray: todosArray)
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                completion(false)
            }
        }
        task.resume()
    }
    
    private func saveTasksToCoreData(jsonArray: [[String: Any]]) {
        for jsonTask in jsonArray {
            let task = TaskModel(context: context)
            task.title = jsonTask["todo"] as? String ?? ""
            task.taskDescription = jsonTask["todo"] as? String ?? ""
            task.isCompleted = jsonTask["completed"] as? Bool ?? false
            task.createdAt = Date()
            
            saveContext()
        }
    }
}
