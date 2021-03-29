//
//  DatabaseServiceProtocol.swift
//  Alakine
//
//  Created by Vladislav Erchik on 10/2/20.
//

import Foundation
import RealmSwift
import RxRealm
import Combine
import RxCocoa
import RxSwift

protocol DatabaseServiceProtocol {
    func deleteObjects<T: Object>(type: T.Type) -> Future<Void, Never>
    
    func modifyObject<T: Object>(newObject: T, primaryKey: Any) -> Future<Void, Error>
    
    func object<T: Object>() -> AnyPublisher<T?, Error>
    func objects<T: Object>() -> AnyPublisher<[T], Never>
    func observeObject<T: Object>() -> AnyPublisher<T?, Error>
    func observeObjects<T: Object>() -> AnyPublisher<Changes<T>, Never>
    
    func addObject<T: Object>(_ object: T) -> Future<Void, Error>
    func addObjects<T: Object>(_ objects: [T]) -> Future<Void, Error>
}

protocol HasDatabaseService {
    var databaseService: DatabaseServiceProtocol { get }
}
