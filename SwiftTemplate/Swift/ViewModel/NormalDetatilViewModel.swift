//
//  NormalDetatilViewModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import Foundation
import UIKit


class NormalDetatilViewModel: NormalBaseViewModel {

    var photoList: Array<Photo> = [Photo]()
    var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    var selectedIndexPath = IndexPath()

    func fetchPhotos(_ photoState: PhotoState) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Photo>()
        snapShot.appendSections([.main])
        snapShot.appendItems(photoList, toSection: .main)
        dataSource.apply(snapShot, animatingDifferences: true)
    }

    func downloadImage(_ photo: Photo, completion: @escaping (UIImage) -> Void) {
        Debug.print(#function, photo.photoURL)
        NormalNetworkManager.shared.getImage(photo.photoURL) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
