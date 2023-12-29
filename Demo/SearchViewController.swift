//
//  SearchViewController.swift
//  Demo
//
//  Created by Seher Aytekin on 12/28/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: ViewModeling
    var searchWorkItem: DispatchWorkItem?
    init() {
        viewModel = SearchViewModel()
        super.init(nibName: "SearchViewController", bundle: nil)
        viewModel.viewUpdater = self
        title = "Search"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.rowHeight = 40
        searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count >= 3 else {
            searchWorkItem?.cancel()
            return
        }
        
        searchWorkItem?.cancel()
        
        searchWorkItem = DispatchWorkItem(block: { [weak self] in
            self?.viewModel.search(for: searchText)
        })
        
        guard let searchWorkItem = searchWorkItem else { return }
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: searchWorkItem)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModel.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
}

extension SearchViewController: ViewUpdating {
    func didSearchFinished() {
        tableView.reloadData()
    }
    
}
