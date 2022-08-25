//
//  CoreDataModel.swift
//  Next ToDo
//
//  Created by Marco Mascorro on 6/4/22.
//
import UIKit
import CoreData

class CoreDataModel{
    
    var todoItems: [NSManagedObject] = []
    let model: NSManagedObjectModel = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.managedObjectModel
    let fetchAllRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
    
    static let shared = CoreDataModel()
    
    func fetchData(completion:@escaping([NSManagedObject])->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        do {
            todoItems = try managedContext.fetch(fetchAllRequest) as! [NSManagedObject]
            completion(todoItems)
           
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(title: String, titledesc: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDo", in: managedContext)!
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        task.setValue(title, forKeyPath: "title")
        task.setValue(titledesc, forKeyPath: "titleDesc")
        
        do {
            try managedContext.save()
            todoItems.append(task)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteItem(for item: NSManagedObject){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(item)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
}



