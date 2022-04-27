//
//  NormalMainViewModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import Foundation
import UIKit


enum ViewState {
    case idle
    case isLoading
}

class NormalMainViewModel {

    var page: Int = 0
//    var photoList: Array<Photo> = [Photo]()
    var photoList: [Photo] = [
        Photo(photoURL: "http://etoland.co.kr/data/file0207/star01/2001421739_qVpjhB5b_127436022_396662458444780_2783407302669307213_n.jpg", likes: 0),
        Photo(photoURL: "http://etoland.co.kr/data/file0207/star01/2001421739_uap5c9iv_127664591_130535678623832_9029373054149166485_n.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/file0207/star01/thumbnail3/2001421739_az4hlATF_129449071_710743713183302_2373024085692417318_n.jpg", likes: 2),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220426/thumbnail3/39992216509447370.jpeg", likes: 2),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220426/thumbnail3/39992216509447371.jpeg", likes: 3),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220426/thumbnail3/39992216509447372.jpeg", likes: 5),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220426/thumbnail3/39992216509447373.jpeg", likes: 3),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220425/thumbnail3/38123716508722030.png", likes: 4),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220425/thumbnail3/38123716508722033.jpg", likes: 2),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220425/thumbnail3/38123716508722045.jpg", likes: 11),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220420/thumbnail3/31634216504539460.jpg", likes: 10),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220420/thumbnail3/31634216504539461.jpg", likes: 9),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220420/thumbnail3/31634216504539472.jpg", likes: 7),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220420/thumbnail3/31634216504539473.jpg", likes: 2),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220420/thumbnail3/31634216504539474.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220414/89289416499272255.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220410/thumbnail3/65704516495713201.jpg", likes: 2),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220410/thumbnail3/65704516495713235.jpg", likes: 3),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220418/thumbnail3/43930916502739716.jpg", likes: 5),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220411/80390516496703260.jpg", likes: 6),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220421/thumbnail3/50337316505174710.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220421/thumbnail3/50337316505174711.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220421/thumbnail3/50337316505174713.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220421/thumbnail3/50337316505174715.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220401/thumbnail3/55611616487971420.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220408/thumbnail3/83550716493752190.png", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220406/70846716492382853.jpeg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/file0207/star01/thumbnail3/2001421367_NzRWcJ0p_120334618_125542465678603_7489495780053210961_n.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220405/thumbnail3/89843816491416092.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/daumeditor10/220405/thumbnail3/37891416491409712.jpeg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/file0207/star01/2001421875_Brg7mLRq_117952632_372604817058987_560112345390847879_n.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/file0207/star01/2001421875_k1HaelOg_117815410_435710664012319_3184872229464476881_n.jpg", likes: 1),
        Photo(photoURL: "http://etoland.co.kr/data/file0207/star01/2001421875_4yB1ErK0_119936385_1197076110657660_7839319653571534448_n.jpg", likes: 1),
    ]
    var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    var viewState = ViewState.idle

    func fetchPhotos(_ page: Int = 1, _ completion: @escaping ([Photo]) -> Void) {
        let queryItems = [
            URLQueryItem(name: "per_page", value: "30"),
            URLQueryItem(name: "page", value: "\(page)"),
        ]
        let request = composeUrlRequest(queryItems: queryItems, endPoint: EndPoint.getPhoto)
        NormalNetworkManager.shared.get(request, type: [PhotoModel].self) {
            completion($0.map { Photo(photoURL: $0.urls.thumb, likes: $0.likes) })
        }
    }

    func fetchPhotos() {
        guard viewState == .idle else { return }
        page += 1
        let queryItems = [
            URLQueryItem(name: "per_page", value: "30"),
            URLQueryItem(name: "page", value: "\(page)"),
        ]
        let request = composeUrlRequest(queryItems: queryItems, endPoint: EndPoint.getPhoto)
        viewState = .isLoading
        NormalNetworkManager.shared.get(request, type: [PhotoModel].self) {
            self.viewState = .idle
            self.photoList.append(contentsOf: $0.map{ Photo(photoURL: $0.urls.thumb, likes: $0.likes) })
            var snapShot = NSDiffableDataSourceSnapshot<Section, Photo>()
            if snapShot.sectionIdentifiers.isEmpty {
                snapShot.appendSections([.main])
            }
            snapShot.appendItems(self.photoList, toSection: .main)
            DispatchQueue.global().async {
                self.dataSource.apply(snapShot, animatingDifferences: true)
            }
        }
        
    }


}
