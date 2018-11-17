//
//  Card.swift
//  PokerPal
//
//  Created by Eric Tyrrell on 11/16/18.
//  Copyright © 2018 Eric Tyrrell. All rights reserved.
//

import Foundation
class Card {
    
    var rank: Int
    var suit: Int
    
    init(_ rank: Int, _ suit: Int){
        // going to read up on failure checking to ensure I'm doing this right
        //precondition(rank >= 2 && rank <= 14)
        //precondition(suit >= 0 && suit <= 3)
        self.rank = rank
        self.suit = suit
    }
    

}
