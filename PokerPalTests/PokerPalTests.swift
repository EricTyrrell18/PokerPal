//
//  PokerPalTests.swift
//  PokerPalTests
//
//  Created by Eric Tyrrell on 11/13/18.
//  Copyright © 2018 Eric Tyrrell. All rights reserved.
//

import XCTest
@testable import PokerPal

class PokerPalTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCard(){
        var card1 = Card(2, 0)
        var card2 = Card(14, 3)

    }
    func testHand(){
        
        var hand: Hand = Hand(cards: [Card(2,2), Card(4,2), Card(9,2), Card(6,2), Card(5,2)])
        var preSortedHand: [Card] = [Card(2,2), Card(4,2), Card(5,2), Card(6,2) , Card(9,2)]
        var sortedByRank = hand.getCardsSortedByRank()
        // testing that it sorts correctly
        for (index, element) in preSortedHand.enumerated(){
            assert(element.rank == sortedByRank[index].rank)
            
        }
        
        
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
