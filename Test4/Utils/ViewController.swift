//
//  ViewController.swift
//  Test4
//
//  Created by Purusharth Verma on 15/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Move this to scene delegate, remove this file
        
        let vc = MoviesListTableViewController(
            viewModel: MoviesListViewModelImp(
                dataLoader: MoviesJSONDataLoaderImp(modelFetcher: JSONFileFetcher<[Movie]>(
                    fileName: "movies", // Move this to constants
                    modelJSONDataDecoder: ModelJSONDataDecoder(jsonDecoder: JSONDecoder())
                )
            )),
            imageFetcher: ImageFetcherImp(
                networkAPIDataFetcher: NetworkAPIDataFetcherImp(urlSession: .shared)
            )
        )
        navigationController?.pushViewController(vc, animated: true)
    }

}

