//
//  Hand.swift
//  PokerPal
//
//  Created by Eric Tyrrell on 11/16/18.
//  Copyright © 2018 Eric Tyrrell. All rights reserved.
//

import Foundation


class Hand{
    var cards: [Card]!
    
    var rankDictionary: [Int: Int] = [:]
    
    init(cards: [Card]) {
        self.cards = cards
        updateRankDict()
    }
    
    private func updateRankDict(){
        // Precondition:
        // cards is nonempty
        // Postcondition:
        // dict of the format [Rank: Count]
        
        rankDictionary = [:]
        
        for card in cards{
            rankDictionary[card.rank] = (rankDictionary[card.rank] ?? 0) + 1
        }
    }
    public func getCardsSortedByRank() -> [Card]{
        return cards.sorted(by: {$0.rank < $1.rank})
    }
    public func getRankCounts() -> [Int: Int]{
        return rankDictionary;
    }
    public func getSuitCounts() -> [Int: Int] {
        var suitDictionary: [Int: Int] = [0 : 0, 1: 0, 2: 0, 3: 0]
        for card in cards{
            // Should never have to use a default value
            suitDictionary[card.suit] = (suitDictionary[card.suit] ?? 0) + 1
        }
        return suitDictionary
    }
}
