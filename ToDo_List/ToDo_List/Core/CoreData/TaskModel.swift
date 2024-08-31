//
//  TaskModel.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 27.08.24.
//
//

import Foundation
import CoreData

public class TaskModel: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskModel> {
        return NSFetchRequest<TaskModel>(entityName: "TaskModel")
    }
    
    @NSManaged public var createdAt: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var taskDescription: String?
    @NSManaged public var title: String?
    
}

extension TaskModel : Identifiable {
    
}

