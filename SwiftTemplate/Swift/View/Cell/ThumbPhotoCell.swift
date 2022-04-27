//
//  ThumbPhotoCell.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/26.
//

import UIKit

class ThumbPhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = nil
        imageView.alpha = 0.2
        super.prepareForReuse()
    }
    
    func setImage(_ imageUrl: String) {
        NormalNetworkManager.shared.getImage(imageUrl) { [weak self] image in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.imageView.contentMode = .scaleAspectFill
                UIView.animate(withDuration: 0.2, delay: 0) {
                    weakSelf.imageView.image = image
                    weakSelf.imageView.alpha = 1
                } completion: { _ in
                }
            }
        }
    }

}
