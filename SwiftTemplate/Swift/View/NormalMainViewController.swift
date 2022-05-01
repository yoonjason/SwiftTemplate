//
//  NormalMainViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit


enum Section: CaseIterable {
    case main
}

class NormalMainViewController: BaseViewController {

    private var currentIndex = 0
    var viewModel = NormalMainViewModel()
    var dataSource: UICollectionViewDiffableDataSource<Section, Photo>!
    let searchController = UISearchController(searchResultsController: nil)
    
    override var selectedIndexPath: IndexPath {
        didSet {
            self.collectionView.scrollToItem(at: selectedIndexPath, at: .centeredVertically, animated: true)
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.photoList.shuffle()
        setupViews()
        setupDataSource()
        setupSearchController()
    }

    private func setupViews() {
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

    private func setupDataSource() {
        viewModel.dataSource = UICollectionViewDiffableDataSource<Section, Photo>(collectionView: collectionView) { [weak self] (collectionView, indexPath, photo) -> UICollectionViewCell? in
            guard let weakSelf = self else { return UICollectionViewCell() }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbPhotoCell", for: indexPath) as? ThumbPhotoCell else { return UICollectionViewCell() }
            weakSelf.viewModel.downloadImage(photo) {
                cell.bind($0)
            }
            
            return cell
        }
        viewModel.fetchPhotos(.list)
    }

    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search Photos, Journaling, growing ..."
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension NormalMainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let yOffset = scrollView.contentOffset.y
        let heightRemainFromBottom = contentHeight - yOffset

        let frameHeight = scrollView.frame.size.height
        if heightRemainFromBottom < frameHeight * 2.0 {
            viewModel.fetchPhotos(.list)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ImageIndexPathManager.shared.selectedIndexPath = indexPath
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NormalDetail") as! NormalDetailViewController
        vc.viewModel.photoList = viewModel.photoList
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension NormalMainViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

    }
}


extension NormalMainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(animationType: .present)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(animationType: .dismiss)
    }
}
