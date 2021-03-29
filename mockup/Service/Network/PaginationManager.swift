//
//  PaginationManager.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation
import Combine

class PaginationManager<T: Decodable> {
    private let networkService: NetworkService
    private var page: Int
    private let limit: Int
    // Provide here url without offset & page keywords
    private let url: String
    private let pageParamName: String
    private let limitParamName: String
    
    private var cancellables = Set<AnyCancellable>()
    var isAllDataFetched = false
    var isFetchInProgress = false
    var items = PassthroughSubject<[T], Never>()
    
    init(
        networkService: NetworkService = .shared,
        page: Int = 0,
        limit: Int = 25,
        url: String,
        pageParamName: String = "pageNumber",
        limitParamName: String = "pageSize"
    ) {
        self.networkService = networkService
        self.page = page
        self.limit = limit
        self.url = url
        self.pageParamName = pageParamName
        self.limitParamName = limitParamName
    }
    
    func loadNextPage() {
        guard let url = URL(string: "\(self.url)") else {
            return
        }
        isFetchInProgress = true
        
        networkService.request(
            url: url,
            parameters: [pageParamName: page.description, limitParamName: limit.description]
        ).sink { completion in
            switch completion {
            case .failure(let error):
                print("[PAGINATION] Error on loading: \(error)")
            default: break
            }
            self.isFetchInProgress = false
        } receiveValue: { (result: [T]) in
            print("[PAGINATION] Received items from page \(self.page): \(result)")
            self.page += 1
            self.isAllDataFetched = result.count < self.limit
            self.items.send(result)
        }
        .store(in: &cancellables)
    }
}
