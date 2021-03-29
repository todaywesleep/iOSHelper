//
//  PaginationViewModel.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation
import Combine

class PaginationViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let paginationManager = PaginationManager<SaleItem>(
        networkService: NetworkService.shared,
        page: 0,
        limit: 25,
        url: Endpoint.news.string
    )
    
    @Published var listItems = [SaleItem]()
    
    func requestItems() {
        loadNextPage()
        CoreDataManager.shared.fetchObjects()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("[PAGINATION] Error when fetching: \(error)")
                default: break
                }
            } receiveValue: { (items: [SaleItem]) in
                print("[PAGINATION] Items fetched: \(items)")
            }
            .store(in: &self.cancellables)
        
        paginationManager.items.receive(on: DispatchQueue.main).sink { _ in
            
        } receiveValue: { [weak self] (items: [SaleItem]) in
            guard let self = self else { return }
            CoreDataManager.shared.writeObjects(entities: items)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print("[PAGINATION] Error: \(error)")
                    default: break
                    }
                } receiveValue: { items in
                    print("[PAGINATION] Items wrote: \(items)")
                }
                .store(in: &self.cancellables)

            self.listItems.append(contentsOf: items)
        }
        .store(in: &cancellables)
    }
    
    func fetchMoreIfNeeded(index: Int) {
        if !paginationManager.isAllDataFetched && !paginationManager.isFetchInProgress
            && index >= listItems.count - 5 {
            loadNextPage()
        }
    }
    
    private func loadNextPage() {
        Future { (observer: @escaping Future<Void, Never>.Promise) in
            self.paginationManager.loadNextPage()
        }
        .receive(on: DispatchQueue.main)
        .sink { _ in }
        .store(in: &cancellables)
    }
}
