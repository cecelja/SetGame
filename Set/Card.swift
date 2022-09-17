//
//  Card.swift
//  Set
//
//  Created by Filip Cecelja on 8/26/22.
//

import Foundation
import UIKit

struct Card: Equatable, Hashable {
    
    private var identifier: Int = 0
    
    //Each of our cards has 4 features that make them unique
    private(set) var shading: String
    private(set) var numberOfSymbols: Int
    private(set) var symbol: String
    private(set) var color: String
    
    //Tracks what is the next possible identifier number
    private static var identifierFactory = 0
    
    
    static var shadingSet: Set<String> = ["HighAlpha", "MediumAlpha", "LowAlpha"]
    static var colorSet: Set<String> = ["red", "green", "blue"]
    
    static var allNumberOfSymbols: Set<Int> = [1, 2, 3]
    static var symbolSet: Set<String> = ["triangle", "circle", "rectangle"]
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    init(_ symbol: String,_ color: String,_ shading: String,_ number: Int) {
        self.identifier = Card.getUniqueIdentifier()
        self.symbol = symbol
        self.color = color
        self.shading = shading
        self.numberOfSymbols = number
    }

    //This method is required to implement the Equatable protocol
    static func == (lhs: Card, rhs: Card) -> Bool {
        if (lhs.symbol == rhs.symbol && lhs.numberOfSymbols == rhs.numberOfSymbols &&
            lhs.shading == rhs.shading && lhs.color == rhs.color) {
            return true
        } else {
            return false
        }
    }
    
    var hashValue: Int {
        return identifier
    }
    
}


