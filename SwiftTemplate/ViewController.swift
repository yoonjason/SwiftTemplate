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
        imageView.contentMode = .center
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setImage()
    }
    
    func bindViewModel() {
        viewModel.movies.drive()
            .disposed(by: disposeBag)
    }
    
    

    func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setImage(){
//        NetworkManager.shared.requestDownload(URL(string: "http://etoland.co.kr/data/daumeditor10/220415/thumbnail3/43069616499769165.jpg")!)
//            .bind(to: self.imageView.rx.image)
//            .disposed(by: disposeBag)

        
//        api.fetch(date: "20220418", type: MovieData.self)
//            .subscribe(onNext: {
//                print($0?.boxOfficeResult.dailyBoxOfficeList)
//            })
//            .disposed(by: disposeBag)
        
        
            
    }


}

