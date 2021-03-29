//
//  RealmStorageService.swift
//  Alakine
//
//  Created by Vladislav Erchik on 10/2/20.
//

import RxRealm
import RealmSwift
import Combine
import RxSwift
import RxCocoa

public typealias Changeset = RealmChangeset
public typealias Changes<T: Object> = RealmCollectionChange<Results<T>>

final class RealmDatabaseService: DatabaseServiceProtocol {
    private static let schemaVersion: UInt64 = 0
    private lazy var configuration = Realm.Configuration(
        schemaVersion: RealmDatabaseService.schemaVersion,
        migrationBlock: { (migration, oldVersion) in
            self.migrate(config: migration, oldVersion: oldVersion)
        }
    )
    
    private var realm: Realm {
        try! Realm()
    }
    
    private func writeTransaction(_ block: @escaping (Realm) -> ()) {
        try! realm.write {
            block(realm)
        }
    }
    
    func observeObject<T: Object>() -> AnyPublisher<T?, Error> {
        realm.objects(T.self)
            .collectionPublisher
            .threadSafeReference()
            .map { $0.first }
            .eraseToAnyPublisher()
    }
    
    func observeObjects<T: Object>() -> AnyPublisher<Changes<T>, Never> {
        realm.objects(T.self)
            .changesetPublisher
            .threadSafeReference()
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func object<T: Object>() -> AnyPublisher<T?, Error> {
        realm.objects(T.self).collectionPublisher
            .threadSafeReference()
            .map { $0.last }
            .eraseToAnyPublisher()
    }
    
    func modifyObject<T: Object>(newObject: T, primaryKey: Any) -> Future<Void, Error> {
        .init { (promise: @escaping Future<Void, Error>.Promise) in
            self.realm.beginWrite()
            if self.realm.object(ofType: T.self, forPrimaryKey: primaryKey) != nil {
                self.realm.add(newObject, update: .all)
            } else {
                self.realm.create(T.self, value: newObject, update: .all)
            }

            do {
                try self.realm.commitWrite()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
    }
    
    func deleteObjects<T: Object>(type: T.Type) -> Future<Void, Never> {
        .init { (promise: @escaping Future<Void, Never>.Promise) in
            self.writeTransaction { realm in
                realm.delete(realm.objects(T.self))
            }
            
            promise(.success(()))
        }
    }
    
    func objects<T: Object>() -> AnyPublisher<[T], Never> {
        realm.objects(T.self)
            .collectionPublisher
            .threadSafeReference()
            .map { $0.toArray() }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    func addObject<T: Object>(_ object: T) -> Future<Void, Error> {
        addObjects([object])
    }
    
    func addObjects<T: Object>(_ objects: [T]) -> Future<Void, Error> {
        .init { (promise: @escaping Future<Void, Error>.Promise) in
            do {
                try self.realm.write { self.realm.add(objects) }
                promise(.success(()))
            } catch let error {
                promise(.failure(error))
            }
        }
    }
    
    private func migrate(config: Migration, oldVersion: UInt64) {
        switch oldVersion {
        case 1: break
        default: break
        }
    }
}
