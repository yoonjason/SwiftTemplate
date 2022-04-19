//
//  ApiType.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation
import RxSwift

protocol ApiType {
    
    @discardableResult
    func fetch<T: Codable>(date: String, type: T.Type) -> Observable<T?> 
}
