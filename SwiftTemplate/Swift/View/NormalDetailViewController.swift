//
//  NormalDetailViewController.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/25.
//

import UIKit

class NormalDetailViewController: UIViewController {

    var viewModel: NormalMainViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        Debug.print("#######")
        self.dismiss(animated: true)
    }
    
}
