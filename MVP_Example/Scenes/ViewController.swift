//
//  ViewController.swift
//  MVP_Example
//
//  Created by mobile on 2023/02/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class ReviewListViewController: UIViewController {
    private lazy var presenter = ReviewListPresenter(viewController: self)
    var latitude = UILabel()
    var longitude = UILabel()
    var temperature = UILabel()
//    var openWeather = BehaviorSubject<[OpenWeather]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension ReviewListViewController {
    @objc func didAPICallButtonTapped() {
        presenter.didAPICallButtonTapped()
    }
}

extension ReviewListViewController: ReviewListProtocol {

    func updateUIAfterResponse(_ lat: Double, _ lon: Double, _ temp: Double) {

        print(#function)
        // 요청 값
        latitude.text = "위도: " + String(lat)
        longitude.text = "경도: " + String(lon)

        // 응답 값
        temperature.text = "온도: " + String(temp)
    }

    func setUpNaivigationBar() {
        title = "MVP"
        view.backgroundColor = .systemBackground

        let rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "antenna.radiowaves.left.and.right"), target: self, action: #selector(didAPICallButtonTapped))

        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

//    func callAPI(_ openWeather: [OpenWeather]) {
//        // 방출받은거 출력
////        self.openWeather.onNext(openWeather)
//
//        //
////        presenter.test()
//    }

    func setUpViews() {
        [
            latitude, longitude, temperature
        ].forEach {
            view.addSubview($0)
        }

        latitude.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }

        longitude.snp.makeConstraints { make in
            make.top.equalTo(latitude.snp.bottom).offset(20)
            make.leading.equalTo(latitude.snp.leading)
        }

        temperature.snp.makeConstraints { make in
            make.top.equalTo(longitude.snp.bottom).offset(20)
            make.leading.equalTo(longitude.snp.leading)
        }
    }
}

