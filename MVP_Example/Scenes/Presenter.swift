//
//  Presenter.swift
//  MVP_Example
//
//  Created by mobile on 2023/02/13.
//

import UIKit
import RxSwift
import RxCocoa

protocol ReviewListProtocol {
    // View에서 구현할 메소드
    func setUpNaivigationBar()
    func setUpViews()
//    func callAPI(_ openWeather: [OpenWeather])
    func updateUIAfterResponse(_ lat: Double, _ lon: Double, _ temp: Double)
}

final class ReviewListPresenter: NSObject {

    private let viewController: ReviewListProtocol

    private let disposeBag = DisposeBag()

    private let networkService = NetworkService()

    private var openWeather = BehaviorSubject<[OpenWeather]>(value: [])

    var lat: Double?
    var lon: Double?
    var temp: Double?

    var openWeatherTest: OpenWeatherTest?

    init(viewController: ReviewListProtocol) {
        self.viewController = viewController
    }

    func viewDidLoad() {
        viewController.setUpNaivigationBar()
        viewController.setUpViews()
    }

    func didAPICallButtonTapped() {
        networkService.getWeatherInfo(lat: 37.6215, lon: 127.0598)
            .subscribe(on: ConcurrentDispatchQueueScheduler(queue: .global()))
            .observe(on: MainScheduler.instance)
            .subscribe { event in
            switch event {
            case .next(let (openWeather)):
                self.openWeather.onNext(openWeather)

                self.lat = try? self.openWeather.value().first?.lat
                self.lon = try? self.openWeather.value().first?.lon
                self.temp = try? self.openWeather.value().first?.current.temp

                OpenWeatherTest(lat: self.lat, lon: self.lon, temp: self.temp)

                self.afterEmition(self.lat!, self.lon!, self.temp!)
//                self.viewController.callAPI(openWeather)
            case .error(let error):
                print("error: \(error), thread: \(Thread.isMainThread)")
            case .completed:
                print("completed")
            }
        }.disposed(by: disposeBag)
    }

    func afterEmition(_ lat: Double, _ lon: Double, _ temp: Double) {
        viewController.updateUIAfterResponse(lat, lon, temp)
    }
}
