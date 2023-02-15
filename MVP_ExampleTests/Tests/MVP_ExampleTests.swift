//
//  MVP_ExampleTests.swift
//  MVP_ExampleTests
//
//  Created by mobile on 2023/02/13.
//

import XCTest
import RxSwift
import RxCocoa

@testable import MVP_Example

final class MVP_ExampleTests: XCTestCase {
    var sut: ReviewListPresenter!
    var viewController:MockReViewListViewController!
    var sut_2: NetworkService!

    override func setUp() {
        super.setUp()
        print(#function)
        viewController = MockReViewListViewController()
        sut = ReviewListPresenter(viewController: viewController) // 테스트 대상
    }

    // 테스트 마무리 후 종료
    override func tearDown() {
        print(#function)
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetUpViews)
        XCTAssertTrue(viewController.isCalledSetUpNaivigationBar)
    }
    
    func test_afterEmition가_호출될_때() {
        sut.openWeatherTest = OpenWeatherTest(lat: 0.023, lon: 127.05424, temp: 2.3535)
        
        sut.afterEmition((sut.openWeatherTest?.lat)!, (sut.openWeatherTest?.lon)!, (sut.openWeatherTest?.temp)!)
        XCTAssertTrue(viewController.isCallUpdateUIAfterResponse)
    }
}
