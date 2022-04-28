//
//  UINavigationBar+.swift
//  SwiftTemplate
//
//  Created by Bradley.yoon on 2022/04/28.
//

import Foundation
import UIKit

extension UINavigationBar {
    var largeTitleHeight: CGFloat {
        let maxSize = self.subviews
            .filter{ $0.frame.origin.y > 0}
            .max { $0.frame.origin.y < $1.frame.origin.y }
            .map { $0.frame.size }
        return maxSize?.height ?? 0
    }
}
