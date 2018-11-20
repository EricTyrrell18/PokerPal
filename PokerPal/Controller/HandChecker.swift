//
//  HandChecker.swift
//  PokerPal
//
//  Created by Eric Tyrrell on 11/17/18.
//  Copyright © 2018 Eric Tyrrell. All rights reserved.
//

import Foundation

class HandChecker{

    func checkHand(hand: Hand) -> Hands{
        var pair_rank = countRanker(hand: hand)
        var straight_or_flush_rank = straight_and_flush_ranker(hand: hand)
        
        
        if straight_or_flush_rank == Hands.straight_flush{
            return straight_or_flush_rank
        }
        if pair_rank == Hands.four_of_kind || pair_rank == Hands.full_house{
            return pair_rank
        }
        if straight_or_flush_rank != Hands.high_card{
            return straight_or_flush_rank
        }
        
        return pair_rank
        // check for straight
        
        // check for flush
        
        // if straight & flush check for royal flush
    }
    
    func countRanker(hand: Hand) -> Hands{
        // Returns high_card, pair, two_pair, three_of_kind, full_house, or four_of_kind
        
        // something to keep in mind is relative occurences of each hand
        // checking rarer hands every time might be inefficient: break early on common hands like pair and high card
        var cards_count = hand.getRankCounts()
        var has_three_of_kind = false
        var has_pair = false
        var has_two_pair = false
        for count in cards_count.values{
            switch count{
            case 2:
                if (has_pair){
                    has_two_pair = true
                } else {
                    has_pair = true
                }
            case 3: has_three_of_kind = true
            // No point in checking anything else if there's a four of a kind
            case 4: return Hands.four_of_kind
            default: break
                
            }
        }
        // inefficient but gets the job done, hopefully.
        if has_three_of_kind && has_pair{
            return Hands.full_house
        }
        if has_three_of_kind{
            return Hands.three_of_kind
        }
        if has_two_pair{
            return Hands.two_pair
        }
        if has_pair{
            return Hands.pair
        }
        
        return Hands.high_card
    }
    func straight_and_flush_ranker(hand: Hand) -> Hands{
        let straight_flag = is_straight(hand: hand)
        let flush_flag = is_flush(hand: hand)
        
        
        if straight_flag && flush_flag{
            if is_straight_flush(hand: hand){
                return Hands.straight_flush
            }
            

        }

        if flush_flag{
            return Hands.flush
        }
        if straight_flag{
            return Hands.straight
        }
        // returns lowest possible hand so that it doesn't overwrite the other components hands
        return Hands.high_card

    }
    //TODO: Implement this function
    func is_royal_flush(hand: Hand) -> Bool{
        return false
    }
    func is_straight_flush(hand: Hand) -> Bool{
        // Violating DRY principle, but have to increment only if the suit's the same now too
        // slightly edited version of is_straight()
        var cards = hand.getCardsSortedByRank()

        // resets to 1 if the card's ranks don't increment by 1
        var incrementing_counter = 1
        var prev = Card(-1,0)
        // special case if it contains an Ace
        if cards.last!.rank == 14{
            prev = Card(1,cards.last!.suit)
        }else{
            prev = cards[0]
            cards.remove(at: 0)
        }
        
        
        for card in cards{
            
            if card.rank == prev.rank + 1 && card.suit == prev.suit{
                incrementing_counter += 1
                if incrementing_counter >= 5{
                    return true
                }
            }else{
                incrementing_counter = 1
            }
            prev = card
        }
        return false

    }
    func is_straight(hand: Hand) -> Bool{
        var cards = hand.getCardsSortedByRank()

        // resets to 1 if the card's ranks don't increment by 1
        var incrementing_counter = 1
        var prev = Card(-1,0)
        // special case if it contains an Ace
        if cards.last!.rank == 14{
            prev = Card(1,0)
        }else{
            prev = cards[0]
            cards.remove(at: 0)
        }
        

        for card in cards{
            
            if card.rank == prev.rank + 1{
                incrementing_counter += 1
                if incrementing_counter >= 5{
                    return true
                }
            }else{
                incrementing_counter = 1
            }
            prev = card
        }
        return false
    }
    func is_flush(hand: Hand) -> Bool{
        let suit_count = hand.getSuitCounts()
        
        for (_, value) in suit_count{
            if value >= 5{
                return true
            }
        }
        return false
    }
}
enum Hands{
    case high_card
    case pair
    case two_pair
    case three_of_kind
    case straight
    case flush
    case full_house
    case four_of_kind
    case straight_flush
    case royal_flush
}
