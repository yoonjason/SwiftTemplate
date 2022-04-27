//
//  NormalDetailViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit

class NormalDetailViewController: UIViewController {

    private var viewModel = NormalDetatilViewModel()
    var movieCode: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    func binding() {
        viewModel.fetchMovieDetail(movieCode) { data in
            print("\(data)")
//            print(data.movieNmOg, data.actors)
        }
    }




}
