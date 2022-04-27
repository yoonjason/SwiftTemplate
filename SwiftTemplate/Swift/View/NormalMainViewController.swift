//
//  NormalMainViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit
import RxDataSources

enum Section: CaseIterable {
    case main
}

class NormalMainViewController: UIViewController {

    private var currentIndex = 0
    private var viewModel = NormalMainViewModel()
    var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.photoList.shuffle()
        setupViews()
        self.setupDataSource()
    }

    func setupViews() {
        collectionView.delegate = self
        let size = UIScreen.main.bounds.size.width / 3
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size),
                                              heightDimension: .absolute(size))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(size))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }

    func setupDataSource() {
        viewModel.dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView) { (collectionView, indexPath, photo) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbPhotoCell", for: indexPath) as? ThumbPhotoCell else { return UICollectionViewCell() }
            cell.setImage(photo.photoURL)
            return cell
        }
        viewModel.fetchPhotos()
    }
    
}

extension NormalMainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let yOffset = scrollView.contentOffset.y
        let heightRemainFromBottom = contentHeight - yOffset

        let frameHeight = scrollView.frame.size.height
        if heightRemainFromBottom < frameHeight * 2.0 {
            viewModel.fetchPhotos()
        }
    }
}

