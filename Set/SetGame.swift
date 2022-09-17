//
//  SetGame.swift
//  Set
//
//  Created by Filip Cecelja on 8/27/22.
//

import Foundation

class SetGame {
    
    //Complete List of Cards
    private(set) var deck = [Card]()
    
    //List of cards that are being played
    private(set) var playingCards = [Card]()
    
    //List of cards that are matched and out of the game
    private(set) var matchedCards = [Card]()
    
    //We need an array of cards that tracks if they are selected or not
    private(set) var selectedCards = [Card]()
    
    //We start with 12 playing cards
    //The Deck has 81 - playing cards - matched cards, cards in itself
    init() {
        for symbol in Card.symbolSet {
            for color in Card.colorSet {
                for shading in Card.shadingSet {
                    for number in Card.allNumberOfSymbols {
                        deck.append(Card(symbol, color, shading, number))
                    }
                }
            }
        }
        deck.shuffle()
        //Initially setup 12 playing cards
        for _ in 0...11 {
            playingCards.append(deck[0])
            //The cards that we deal at the beginning must be removed from the deck
            deck.remove(at: 0)
        }
    }
    //A method that gets executed when we select a card at the proposed index in the deck
    func selectCard(at index: Int) {
        //When we select a card we add it to the selectedCards array
        //However we keep track of the array count
        //Since if the array count is 3 before we add the new card, than we need to remove all the card
        //in the selected cards array and add the new one
        if (selectedCards.count < 3) {
            if (selectedCards.contains(playingCards[index])) {
                let i = selectedCards.firstIndex(of: playingCards[index])
                selectedCards.remove(at: i!)
            } else {
                selectedCards.append(playingCards[index])
            }
            //We first check if we have a match
            if (selectedCards.count == 3) {
                if isAMatch(first: selectedCards[0], second: selectedCards[1], third: selectedCards[2]) {
                    //If we have a match we mark all the cards true
                    for i in 0...2 {
                        matchedCards.append(selectedCards[i])
                    }
                    print("Number of matched cards: \(matchedCards.count)")
                }
            }
        } else if (selectedCards.count == 3) {
            //We remove the previously selected cards
            selectedCards.removeAll()
            matchedCards.removeAll()
            //We add the newly selected card at position 0
            selectedCards.append(playingCards[index])
        }
    }
    
    func isAMatch(first: Card, second: Card, third: Card) -> Bool {
        let numArr: Set<Int> = [first.numberOfSymbols, second.numberOfSymbols, third.numberOfSymbols]
        let symArr: Set<String> = [first.symbol, second.symbol, third.symbol]
        let shadArr: Set<String> = [first.shading, second.shading, third.shading]
        let colArr: Set<String> = [first.color, second.color, third.color]
        
        if (numArr == Card.allNumberOfSymbols && colArr == Card.colorSet &&
            shadArr == Card.shadingSet && symArr == Card.symbolSet) {
            print("It is a match!")
            return true
        } else {
            print("Not a match!")
            return false
        }
    }
    
    //This function manages the deck of cards by adding or removing the cards
    //depending on the action
    func replaceOrDeal(){
        //If we have 3 cards that match
        if (matchedCards.count == 3) {
            print("Deck: \(deck.count)")
            //The matchedCards are also present in the playingCards
                for card in matchedCards {
                    print("Replacing the matched cards with new ones from the deck: \(deck.count)")
                    //We find the index of the matched card
                    let i = playingCards.firstIndex(of: card)
                    //This is needed when we want
                    //to remove the matched cards on the screen
                    //but our deck is empty
                    if (deck.count != 0) {
                        //We remove it from the playing field
                        playingCards.remove(at: i!)
                        //We replace it with another card from the top of the deck
                        playingCards.insert(deck[0], at: i!)
                        deck.remove(at: 0)
                    } else {
                        playingCards.remove(at: i!)
                        playingCards.insert(Card("", "", "", 1), at: i!)
                    }

                }
        } else {
            //If we are not replacing the matched cards then
            //we are adding them on top of the already playing cards
            for _ in 0...2 {
                playingCards.append(deck[0])
                deck.remove(at: 0)
            }
        }
    }
}
