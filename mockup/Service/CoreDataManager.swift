//
//  CoreDataManager.swift
//  Mockup
//
//  Created by Vladislav Erchik on 9.12.20.
//

import Foundation
import CoreData
import Combine
import UIKit

class CoreDataManager {
    static var shared = CoreDataManager()
    private init() {}
    
    func writeObject<T: NSManagedObject>(entity: T) -> Future<T, Error> {
        .init { (promise: @escaping Future<T, Error>.Promise) in
            guard let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.viewContext else { return }
            viewContext.insert(entity)
            
            do {
                try viewContext.save()
                promise(.success(entity))
            } catch {
                promise(.failure(error))
            }
        }
    }
    
    func writeObjects<T: NSManagedObject>(entities: [T]) -> Future<[T], Error> {
        .init { (promise: @escaping Future<[T], Error>.Promise) in
            guard let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.viewContext else { return }
            entities.forEach { viewContext.insert($0) }
            
            do {
                try viewContext.save()
                promise(.success(entities))
            } catch {
                promise(.failure(error))
            }
        }
    }
    
    func fetchObject<T: NSManagedObject>(id: Any)  -> Future<T?, Error> {
        .init { (promise: @escaping Future<T?, Error>.Promise) in
            guard let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.viewContext else { return }
            let fetchRequest = T.fetchRequest()
            let predicate = NSPredicate(format: "id == \(id)")
            fetchRequest.predicate = predicate
            
            do {
                let fetchResult = try viewContext.fetch(fetchRequest)
                promise(.success(fetchResult.first as? T))
            } catch {
                promise(.failure(error))
            }
        }
    }
    
    func fetchObjects<T: NSManagedObject>()  -> Future<[T], Error> {
        .init { (promise: @escaping Future<[T], Error>.Promise) in
            guard let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.viewContext else { return }
            let fetchRequest = T.fetchRequest()
            
            do {
                let fetchResult = try viewContext.fetch(fetchRequest) as? [T]
                promise(.success(fetchResult ?? []))
            } catch {
                promise(.failure(error))
            }
        }
    }
}
