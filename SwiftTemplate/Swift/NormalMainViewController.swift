//
//  NormalMainViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit

class NormalMainViewController: UIViewController {

    private var viewModel = NormalMainViewModel()
    private var movieList = [Movie]()

    private lazy var tableView: UITableView = {
        let tblView = UITableView()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(MovieListCell.self, forCellReuseIdentifier: "MovieListCell")
        tblView.translatesAutoresizingMaskIntoConstraints = false
        return tblView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchDailyMovies { movies in
            DispatchQueue.main.async {
                self.movieList.append(contentsOf: movies)
                self.tableView.reloadData()
            }
        }
    }

    func setupViews() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    func requestDailyMovie() {
        let queryItems = [
            URLQueryItem(name: "targetDt", value: "20220424")
        ]
        let request = composeUrlRequest(queryItems: queryItems, endPoint: EndPoint.dailyMovieListURL)
        URLSession.shared.request(request, type: MovieData.self) { [self] (result) in
            switch result {
            case .success(let movieData):
                DispatchQueue.main.async {
                    self.movieList.append(contentsOf: movieData.boxOfficeResult.dailyBoxOfficeList.map {
                        Movie(movieNm: $0.movieNm, rank: $0.rank, openDate: $0.openDt, audiCnt: $0.audiCnt, accAudi: $0.audiAcc, movieCd: $0.movieCd)
                    })
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension NormalMainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        let movieData = movieList[indexPath.row]
        cell.setData(movieData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieData = movieList[indexPath.row]
        print(movieData.movieName, movieData.movieCode)
    }


}
