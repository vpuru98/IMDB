//
//  MoviesListTableViewController.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import UIKit

final class MoviesListTableViewController: UITableViewController {
    private let viewModel: MoviesListViewModel
    private let imageFetcher: ImageFetcher
    
    init(viewModel: MoviesListViewModel, imageFetcher: ImageFetcher) {
        self.viewModel = viewModel
        self.imageFetcher = imageFetcher
        super.init(nibName: "MoviesListTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(nibName: "MoviesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MoviesTableViewCell"
        )
        viewModel.updateMoviesList { [weak self] isSuccess in
            if isSuccess {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func launchDetail(froMovie movie: Movie) {
        let vc = MoviesDetailViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Table view data source
extension MoviesListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel.getMovieAtIndex(indexPath.row) else { return }
        launchDetail(froMovie: movie)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "MoviesTableViewCell",
            for: indexPath
            ) as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.imageFetcher = imageFetcher
        cell.viewModel = viewModel.getMovieAtIndex(indexPath.row)
        return cell
    }
    
}
