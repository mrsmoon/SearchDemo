//
//  SearchDependencyResolver.swift
//  Demo
//
//  Created by Seher Aytekin on 12/28/23.
//

import Foundation

final class SearchDependencyResolver {
    private var manager: SearchProtocol?
    
    init(_ manager: SearchProtocol? = nil) {
        self.manager = manager
    }
    
    func resolveSearchManager() -> SearchProtocol {
        return manager ?? SearchManager()
    }
    
    
}
