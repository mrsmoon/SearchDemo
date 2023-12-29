//
//  SearchViewModel.swift
//  Demo
//
//  Created by Seher Aytekin on 12/28/23.
//

import Foundation
protocol ViewUpdating: AnyObject {
    func didSearchFinished()
}

protocol ViewModeling {
    var dataSource: [Rental] {get}
    var viewUpdater: ViewUpdating? { get set }
    func search(for keyword: String)
}

final class SearchViewModel: ViewModeling {
    
    private var rentals: [Rental] = []
    
    var dataSource: [Rental] {
        rentals
    }
    
    weak var viewUpdater: ViewUpdating?
    
    let searchManager: SearchProtocol
    
    init(_ dependencyResolver: SearchDependencyResolver = SearchDependencyResolver()) {
        searchManager = dependencyResolver.resolveSearchManager() 
    }
    
    func search(for keyword: String) {
        searchManager.search(with: keyword) { [weak self] result in
            switch result {
            case .success(let rentals):
                self?.rentals = rentals
                DispatchQueue.main.async {
                    self?.viewUpdater?.didSearchFinished()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


