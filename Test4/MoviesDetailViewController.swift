//
//  MoviesDetailViewController.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: "MoviesDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup UI for movie
    }

}
