//
//  NormalDetailViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit

class NormalDetailViewController: UIViewController {

    var viewModel = NormalDetatilViewModel()
    private var selectedIndexPath = IndexPath()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupDataSource()
    }

    private func setupViews() {
        collectionView.delegate = self
        let size = UIScreen.main.bounds.size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        let layout = UICollectionViewCompositionalLayout(section: section)
        collectionView.collectionViewLayout = layout
    }

    private func setupDataSource() {
        viewModel.dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView) { [weak self] (collectionView, indexPath, photo) in
            guard let weakSelf = self,
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoViewerCell", for: indexPath) as? PhotoViewerCell else { return UICollectionViewCell() }
            weakSelf.viewModel.downloadImage(photo) {
                cell.bind($0)
            }
            
            return cell
        }
        viewModel.fetchPhotos(.list)
        collectionView.scrollToItem(at: ImageIndexPathManager.shared.selectedIndexPath, at: .centeredVertically, animated: true)
    }



    @IBAction func didTapClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    deinit {
        print("deinit \(#file)")
    }

}

extension NormalDetailViewController: UICollectionViewDelegate {

}
