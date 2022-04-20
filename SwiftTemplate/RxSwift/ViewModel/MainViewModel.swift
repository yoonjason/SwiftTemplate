//
//  MainViewModel.swift
//  SwiftTemplate
//
//  Created by yoon on 2022/04/19.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
import NSObject_Rx

class MainViewModel: CommonViewModel, HasDisposeBag {
    let api: Api
    let bag = DisposeBag()

    init(
        api: Api,
        sceneCoordinator: SceneCoordinator
    ) {
        self.api = api
        super.init(sceneCoordinator: sceneCoordinator)
    }

    var movies: Driver<MovieData?> {
        return api.fetch(date: "20220418", type: MovieData.self)
            .asDriver(onErrorJustReturn: nil)
    }
}
