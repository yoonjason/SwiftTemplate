import Foundation
import UIKit

class ImageIndexPathManager {
    static let shared = ImageIndexPathManager()
    
    var selectedIndexPath = IndexPath()
    
}


class BaseViewController: UIViewController {
    var selectedIndexPath = IndexPath()
}
