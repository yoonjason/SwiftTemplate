//
//  ViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/18.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, ViewModelBindableType {

    var viewModel: MainViewModel!
    let disposeBag = DisposeBag()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .brown
//        imageView.contentMode = .center
        return imageView
    }()

    private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next Page", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ViewController.nextPage), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setImage()
    }


    func bindViewModel() {
//        viewModel.movies.drive()
//            .disposed(by: disposeBag)

    }



    func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        self.view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            nextButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    func setImage() {
        NetworkManager.shared.requestDownload(URL(string: "http://etoland.co.kr/data/daumeditor10/220413/68823716498483290.jpeg")!)
            .bind(to: self.imageView.rx.image)
            .disposed(by: disposeBag)

        let api = Api()
        let queryItems = [
            URLQueryItem(name: "per_page", value: "10"),
            URLQueryItem(name: "page", value: "\(1)"),
        ]
        api.fetch(queryItems: queryItems, type: PhotoData.self, endPoint: EndPoint.getPhoto)
            .subscribe(onNext:{
                $0?.results.forEach({
                    print($0.urls.thumb)
                })
            })
            .disposed(by: disposeBag)
        
        var req = URLRequest(url: URL(string: "https://api.unsplash.com/photos?client_id=AqzzK8Iv3d61GEwrMMurhBnVnN1MRMoRkjDJj8bNLf0&per_page=10&page=1")!, method: HttpMethod<PhotoData>.get)
        
//        api.fetch(date: "20220418", type: MovieData.self)
//            .subscribe(onNext: {
//                print($0?.boxOfficeResult.dailyBoxOfficeList)
//            })
//            .disposed(by: disposeBag)
         req = URLRequest(url: URL(string: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=3d81265c2b0975c6002f8e55d8a96606&targetDt=20220418")!, method: HttpMethod<MovieData>.get)
        URLSession.shared.request(req,type: MovieData.self) { (result) in
            switch result {
            case .success(let data):
                print(data.boxOfficeResult.dailyBoxOfficeList.count)
                data.boxOfficeResult.dailyBoxOfficeList.forEach {
                    print($0.movieNm)
                }
            case .failure(let error):
                print(error)
            }
        }


    }

    @objc func nextPage() {
        print("AAAAA")
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }

}

