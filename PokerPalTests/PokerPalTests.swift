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
    func testHandChecker(){
        var high_card = Hand(cards: [Card(2,2), Card(10,0), Card(4,1), Card(5,2), Card(12,2), Card(6,0), Card(9,1)])
        var pair = Hand(cards: [Card(2,2), Card(2,0), Card(4,1), Card(5,2), Card(12,2), Card(6,0), Card(9,1)])
        var two_pair = Hand(cards: [Card(10,2), Card(10,0), Card(4,1), Card(4,2), Card(12,2), Card(6,0), Card(9,1)])
        var three_of_kind = Hand(cards: [Card(2,2), Card(2,0), Card(2,1), Card(5,2), Card(12,2), Card(6,0), Card(9,1)])
        var straight = Hand(cards: [Card(2,2), Card(3,0), Card(4,1), Card(5,2), Card(12,2), Card(6,0), Card(9,1)])
        var flush = Hand(cards: [Card(2,2), Card(10,2), Card(4,1), Card(5,2), Card(12,2), Card(6,0), Card(9,2)])
        var full_house = Hand(cards: [Card(2,2), Card(2,0), Card(2,1), Card(6,2), Card(12,2), Card(6,0), Card(9,1)])
        var four_of_kind = Hand(cards: [Card(2,2), Card(2,0), Card(2,1), Card(2,3), Card(12,2), Card(6,0), Card(9,1)])
        var straight_flush = Hand(cards: [Card(2,2), Card(3,2), Card(4,2), Card(5,2), Card(12,2), Card(6,2), Card(9,1)])
        
        let hc = HandChecker()
        
        assert(hc.checkHand(hand: high_card) == Hands.high_card)
        assert(hc.checkHand(hand: pair) == Hands.pair)
        assert(hc.checkHand(hand: two_pair) == Hands.two_pair)
        assert(hc.checkHand(hand: three_of_kind) == Hands.three_of_kind)
        assert(hc.checkHand(hand: straight) == Hands.straight)
        assert(hc.checkHand(hand: flush) == Hands.flush)
        assert(hc.checkHand(hand: full_house) == Hands.full_house)
        assert(hc.checkHand(hand: four_of_kind) == Hands.four_of_kind)
        assert(hc.checkHand(hand: straight_flush) == Hands.straight_flush)
    }
    func testCountRanker(){
        var high_card = Hand(cards: [Card(2,0)])
        var pair = Hand(cards: [Card(2,2), Card(2,3)])
        var two_pair = Hand(cards: [Card(2,2), Card(2,3), Card(3,1), Card(3,2)])
        var three_of_kind = Hand(cards: [Card(2,2), Card(2,3), Card(2,1)])
        var full_house = Hand(cards: [Card(2,2), Card(2,3), Card(3,1), Card(3,2), Card(3,3)])
        var four_of_kind = Hand(cards: [Card(2,2), Card(2,3), Card(2,1), Card(2,0)])
        
        let hc = HandChecker()
        
        assert(hc.countRanker(hand: high_card) == Hands.high_card)
        assert(hc.countRanker(hand: pair) == Hands.pair)
        assert(hc.countRanker(hand: two_pair) == Hands.two_pair)
        assert(hc.countRanker(hand: three_of_kind) == Hands.three_of_kind)
        assert(hc.countRanker(hand: full_house) == Hands.full_house)
        assert(hc.countRanker(hand: four_of_kind) == Hands.four_of_kind)
        
    }
    func testStraightAndFlushRanker(){
        let straight = Hand(cards: [Card(2,2), Card(3,3), Card(4,1), Card(5,2), Card(6,3)])
        let flush = Hand(cards: [Card(2,2), Card(10,2), Card(4,2), Card(5,2), Card(6,2), Card(6,0), Card(6,1)])
        let straight_flush = Hand(cards: [Card(2,2), Card(3,2), Card(4,2), Card(5,2), Card(6,2)])
        
        let hc = HandChecker()
        
        assert(hc.straight_and_flush_ranker(hand: straight) == Hands.straight)
        assert(hc.straight_and_flush_ranker(hand: flush) == Hands.flush)
        assert(hc.straight_and_flush_ranker(hand: straight_flush) == Hands.straight_flush)
    }
    func testIsStraight(){
        var simple_straight = Hand(cards: [Card(2,2), Card(3,3), Card(4,1), Card(5,2), Card(6,3)])
        var simple_pair = Hand(cards: [Card(2,2), Card(3,3), Card(5,1), Card(5,2), Card(6,3)])
        var ace_low_straight = Hand(cards: [Card(14,2), Card(2,3), Card(3,1), Card(4,2), Card(5,3)])
        var ace_high_straight = Hand(cards: [Card(14,2), Card(11,3), Card(10,1), Card(13,2), Card(12,3)])
        
        let hc = HandChecker()
        
        assert(hc.is_straight(hand: simple_straight))
        assert(!hc.is_straight(hand: simple_pair))
        assert(hc.is_straight(hand: ace_low_straight))
        assert(hc.is_straight(hand: ace_high_straight))
    }
    func testIsFlush(){
        // Unsure if the suits match up, but shouldn't matter either way
        // since this is only testing that it works for every suit
        var hearts_flush = Hand(cards: [Card(2,0), Card(3,0), Card(4,0), Card(5,0), Card(6,0)])
        var diamonds_flush = Hand(cards: [Card(2,1), Card(3,1), Card(4,1), Card(5,1), Card(6,1)])
        var spades_flush = Hand(cards: [Card(2,2), Card(3,2), Card(4,2), Card(5,2), Card(6,2)])
        var clubs_flush = Hand(cards: [Card(2,3), Card(3,3), Card(4,3), Card(5,3), Card(6,3)])
        var not_flush = Hand(cards: [Card(2,2), Card(3,0), Card(4,1), Card(5,3), Card(6,2)])
        
        
        
        let hc = HandChecker()
        
        assert(hc.is_flush(hand: hearts_flush))
        assert(hc.is_flush(hand: diamonds_flush))
        assert(hc.is_flush(hand: spades_flush))
        assert(hc.is_flush(hand: clubs_flush))
        assert(!hc.is_flush(hand: not_flush))
    }
    func testIsStraightFlush(){
        let straight_flush = Hand(cards: [Card(2,2), Card(3,2), Card(4,2), Card(5,2), Card(6,2)])
        let ace_low_straight_flush = Hand(cards: [Card(2,2), Card(3,2), Card(4,2), Card(5,2), Card(14,2)])
        
        let not_straight_flush = Hand(cards: [Card(2,1), Card(3,2), Card(4,1), Card(5,3), Card(6,2)])
        var ace_low_straight = Hand(cards: [Card(14,2), Card(2,3), Card(3,1), Card(4,2), Card(5,3)])
        
        let hc = HandChecker()
        
        assert(hc.is_straight_flush(hand: straight_flush))
        assert(hc.is_straight_flush(hand: ace_low_straight_flush))
        assert(!hc.is_straight_flush(hand: not_straight_flush))
        assert(!hc.is_straight_flush(hand: ace_low_straight))
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
