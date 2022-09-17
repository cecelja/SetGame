//
//  ViewController.swift
//  Set
//
//  Created by Filip Cecelja on 8/26/22.
//

import UIKit

class ViewController: UIViewController {
    
    //Initializing a new array with no values
    private var cardButtons: [UIButton] = []
    //We need an instance of our SetGame
    private var setGame = SetGame()
    
    lazy var width = view.bounds.width/6
    var xOffset = 5.0
    var yOffset = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        initializeButtons()
        updateViewFromModel()
        setupDealThreeButton()
        cardButtons.forEach{ btn in
            view.addSubview(btn)
        }
    }
    
    //This is the first method that gets executed when we click on a button
    //Here we need to implement the functionality of selecting a cardfirstIndex
    @objc func selectedCardIndex(on button: UIButton) -> Int {
        if let cardNumber = cardButtons.firstIndex(of: button) {
            setGame.selectCard(at: cardNumber)
            updateViewFromModel()
        }
        return 0
    }
    
    //The function deals with dealing and managing the deck
    @objc func dealThree() {
        if setGame.deck.count == 0 {
            self.showToast(message: "The deck is empty", font: .systemFont(ofSize: 24.0))
            if setGame.matchedCards.count == 3 {
                setGame.replaceOrDeal()
                updateViewFromModel()
            }
        } else {
            if setGame.matchedCards.count == 3 {
                //I need to locate the matched cards index in playedCards
                //Delete the labels of those cards and replace them with new ones from the deck
                setGame.replaceOrDeal()
                updateViewFromModel()
            } else if (cardButtons.count <= 27){
                setGame.replaceOrDeal()
                for _ in setGame.playingCards.count-3..<setGame.playingCards.count {
                        let newButton = createButton(x: xOffset, y: yOffset, width: width - 5)
                        cardButtons.append(newButton)
                        view.addSubview(newButton)
                        xOffset += width
                    if (xOffset >= view.bounds.width) {
                        xOffset = 5.0
                        yOffset += 105
                    }
                }
                print("\(cardButtons.count)")
                cardButtons.forEach{ (card: UIButton) in
                    view.addSubview(card)
                }
                updateViewFromModel()
            } else {
                self.showToast(message: "Congratulations!", font: .systemFont(ofSize: 24.0))
            }
        }
         
    }
    
    func setupDealThreeButton() {
        let ycoord = view.bounds.height-50
        let margins = view.layoutMarginsGuide
        let dealThreeBtn = UIButton(frame: CGRect(x: 0, y: ycoord, width: 150, height: 50))
        dealThreeBtn.setTitle("Deal 3 cards", for: .normal)
        dealThreeBtn.backgroundColor = .brown
        dealThreeBtn.addTarget(self, action: #selector(dealThree), for: .touchUpInside)
        view.addSubview(dealThreeBtn)
        dealThreeBtn.layer.cornerRadius = dealThreeBtn.frame.width/10
        dealThreeBtn.translatesAutoresizingMaskIntoConstraints = false
        dealThreeBtn.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        dealThreeBtn.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        dealThreeBtn.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        dealThreeBtn.heightAnchor.constraint(equalTo: dealThreeBtn.widthAnchor, multiplier: 1.0/5.0).isActive = true
    }
    
    func initializeButtons() {
        setGame.playingCards.forEach{ cardBtn in
            cardButtons.append(createButton(x: xOffset, y: yOffset, width: width - 5))
            xOffset += width
            if (xOffset >= view.bounds.width) {
                xOffset = 5.0
                yOffset += 105
            }
        }
    }
    
    //This method is called everytime we update something in the model
    func updateViewFromModel(){
        for index in 0..<cardButtons.count {
            let button = cardButtons[index]
            let card = setGame.playingCards[index]
            //we need to match the buttons and their respective UI visuals
            setButtonVisuals(button: button, symbol: card.symbol, color: card.color, shading: card.shading, number: card.numberOfSymbols)
            if (setGame.selectedCards.contains(card) && !(setGame.matchedCards.count == 3) ) {
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.black.cgColor
            } else if (setGame.selectedCards.contains(card) && setGame.matchedCards.count == 3) {
                button.layer.borderColor = UIColor.green.cgColor
                button.layer.borderWidth = 3.0
                self.showToast(message: "There are too many cards on the field", font: .systemFont(ofSize: 24.0))
                
            } else {
                button.backgroundColor = .white
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.brown.cgColor
            }
        }
    }

    //While creating the buttons here we should assign their properties
    //as they look in a set
    func createButton(x offset: Double, y: Double, width: Double) -> UIButton {
        let button = UIButton(frame: CGRect(x: offset, y: y, width: width, height: 100))
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.layer.cornerRadius = button.frame.width/10
        button.addTarget(self, action: #selector(selectedCardIndex), for: .touchUpInside)
        
        return button
    }
    
    //Maps the Visuals according to button features
    func setButtonVisuals(button: UIButton, symbol: String, color: String, shading: String, number: Int) {
        let btn = button
        var attributedString = NSAttributedString(string: "")
        var modifiedSymbol: String = ""
        var givenColor: UIColor? = nil
        var attributes = [NSAttributedString.Key: Any]().self
        
        switch color {
            case "red":
                switch shading{
                    case "HighAlpha": givenColor = UIColor(255, 0, 0, 1)
                    case "MediumAlpha": givenColor = UIColor(255, 0, 0, 0.6)
                    case "LowAlpha": givenColor = UIColor(255, 0, 0, 0.3)
                default: givenColor = view.backgroundColor
                }
            case "green":
                switch shading{
                    case "HighAlpha": givenColor = UIColor(2, 105, 29, 1)
                    case "MediumAlpha": givenColor = UIColor(2, 105, 29, 0.6)
                    case "LowAlpha": givenColor = UIColor(2, 105, 29, 0.3)
                default: givenColor = view.backgroundColor
                }
            case "blue":
                switch shading{
                    case "HighAlpha": givenColor = UIColor(0, 0, 255, 1)
                    case "MediumAlpha": givenColor = UIColor(0, 0, 255, 0.6)
                    case "LowAlpha": givenColor = UIColor(0, 0, 255, 0.3)
                default: givenColor = view.backgroundColor
                }
        default: givenColor = view.backgroundColor
        }
        
        attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: givenColor ?? .black]
        
        switch symbol {
            case "triangle": modifiedSymbol = "▲"
            case "circle": modifiedSymbol =  "●"
            case "rectangle": modifiedSymbol = "◼︎"
            default: attributedString = NSAttributedString(string: "")
        }
        
        switch number {
            case 1: break
            case 2: modifiedSymbol = modifiedSymbol + "\n\(modifiedSymbol)"
            case 3: modifiedSymbol = modifiedSymbol + "\n\(modifiedSymbol)" + "\n\(modifiedSymbol)"
            default: break
        }
        attributedString = NSAttributedString(string: modifiedSymbol, attributes: attributes)
        btn.setAttributedTitle(attributedString, for: .normal)
    }
    
}
