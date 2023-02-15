//
//  MockMVP_ExampleTests.swift
//  MVP_ExampleTests
//
//  Created by mobile on 2023/02/15.
//

import Foundation

@testable import MVP_Example

final class MockReViewListViewController: ReviewListProtocol {
    var isCalledSetUpNaivigationBar = false
    var isCalledSetUpViews = false
    var isCallUpdateUIAfterResponse = false
    
    // viewDidLoad
    func setUpNaivigationBar() {
        isCalledSetUpNaivigationBar = true
    }

    func setUpViews() {
        isCalledSetUpViews = true
    }
    
    // didAPICallButtonTapped
    func updateUIAfterResponse(_ lat: Double, _ lon: Double, _ temp: Double) {
        isCallUpdateUIAfterResponse = true
    }
}
