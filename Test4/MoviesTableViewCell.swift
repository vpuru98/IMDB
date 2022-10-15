//
//  MoviesTableViewCell.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import UIKit

final class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    
    var imageFetcher: ImageFetcher?
    var viewModel: MovieListItemViewModel?
    
    private func setupForViewModel(viewModel: MovieListItemViewModel) {
        // setup
        
        let imageUrl = viewModel.imageURL
        imageFetcher?.fetchImage(forURLString: imageUrl) { [weak self] result in
            guard let weakSelf = self, let image = try? result.get() else { return }
            guard weakSelf.viewModel?.imageURL == imageUrl else { return } // dirty write
            weakSelf.posterImageView.image = image
        }
    }
    
}
