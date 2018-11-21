//
//  HandCheckerViewController.swift
//  PokerPal
//
//  Created by Eric Tyrrell on 11/13/18.
//  Copyright © 2018 Eric Tyrrell. All rights reserved.
//

import UIKit

class HandCheckerViewController: UIViewController {
    let data = [
        ["2","3","4","5","6","7","8","9","10","J","Q","K","A"],
        ["Hearts", "Diamonds", "Spades", "Clubs"]
    ]
    let suitPrefixes = ["H","D","S","C"]

    var lastCardTapped = 0
    
    var cards: [Card] = []
    
    let cardPicker = UIPickerView()
    let cardPickerToolBar = UIToolbar(frame: CGRect.zero)
    let cardsDoneButton = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: self,
        action: #selector(HandCheckerViewController.cardPickerDone(_:))
    )
    let cardsSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    
    @IBOutlet var tableCards: [ImageButton]!
    
    @IBAction func checkHand(_ sender: Any) {
        let hc = HandChecker()
        let hand = hc.checkHand(hand: Hand(cards: cards))
        switch hand{
        case .high_card:
            handLabel.text = "High Card"
        case .pair:
            handLabel.text = "Pair"
        case .two_pair:
            handLabel.text = "Two Pair"
        case .three_of_kind:
            handLabel.text = "Three of a Kind"
        case .straight:
            handLabel.text = "Straight"
        case .flush:
            handLabel.text = "Flush"
        case .full_house:
            handLabel.text = "Full House"
        case .four_of_kind:
            handLabel.text = "Four of a Kind!"
        case .straight_flush:
            handLabel.text = "Straight Flush!"
        default:
            break
        }
        handLabel.sizeToFit()
    }
    
    @IBOutlet weak var handLabel: UILabel!
    
    @IBAction func holeCard1(_ sender: Any) {
        lastCardTapped = 0
    }
    @IBAction func holeCard2(_ sender: Any) {
        lastCardTapped = 1
    }
    @IBAction func river(_ sender: Any) {
        lastCardTapped = 6
    }
    
    @IBAction func turn(_ sender: Any) {
        lastCardTapped = 5
    }
    @IBAction func flop1(_ sender: Any) {
        lastCardTapped = 2
    }
    
    @IBAction func flop2(_ sender: Any) {
        lastCardTapped = 3
    }
    @IBAction func flop3(_ sender: Any) {
        lastCardTapped = 4
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // gives the green felt behind the cards
        setBackgroundImage()
        // initializes the cards to predetermined cards
        //TODO: Add randomization to the cards
        init_cards()
        // creates and attaches the card picker to the card buttons
        initCardPicker()
        

        
        
        // Do any additional setup after loading the view.
    }
    @objc func cardPickerDone(_ sender: UIBarButtonItem ){
        changeCard(button: tableCards[lastCardTapped])
        tableCards[lastCardTapped].resignFirstResponder()
    }
    func initCardPicker(){
        cardPicker.dataSource = self
        cardPicker.delegate = self
        cardPicker.setNeedsLayout()
        cardPicker.isOpaque = true
        
        cardPickerToolBar.barStyle = .default
        cardPickerToolBar.items = [cardsSpacer, cardsDoneButton]
        cardPickerToolBar.sizeToFit()
        for card in tableCards{
            // becomes the first respnder and displays the picker when the button's tapped
            card.inputView = cardPicker
            card.inputAccessoryView = cardPickerToolBar
        }
    }
    func changeCard(button: ImageButton){
        
        var rank = data[0][cardPicker.selectedRow(inComponent: 0)]
        
        var suit = suitPrefixes[cardPicker.selectedRow(inComponent: 1)]
        // Add two to the suit because the indexes go from 0-12 not 2-14
        cards[lastCardTapped] = Card(cardPicker.selectedRow(inComponent: 0) + 2, cardPicker.selectedRow(inComponent: 1))
        for card in cards{
            print("rank: " + String(card.rank) + "  suit: " + String(card.suit))
        }
        let newCardImage = UIImage(named: rank + suit)
        button.setImage(newCardImage, for: UIControl.State.normal)
    }
    //
    func setBackgroundImage(){
        // Sets the background image for the view
        
        let background = UIImage(named: "green_felt")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    // gives the cards their images and sets up the internal cards array
    func init_cards(){
        cards.append(Card(10, 2))
        cards.append(Card(11,1))
        cards.append(Card(2,3))
        cards.append(Card(5,0))
        cards.append(Card(9,2))
        cards.append(Card(5,2))
        cards.append(Card(10,0))
        var i = 0
        
        while i < cards.count - 1{
        // contains the number ie 2,3,4 . . . ,10,11,12,13
        let raw_rank_string = String(cards[i].rank)
        let suit_string = suitPrefixes[cards[i].suit]
        var rank_string = raw_rank_string
        switch rank_string{
        case "11":
            rank_string = "J"
        case "12":
            rank_string = "Q"
        case "13":
            rank_string = "K"
        case "14":
            rank_string = "A"
        default:
            break
        }
        
        tableCards[i].setImage(UIImage(named: rank_string + suit_string), for: UIControl.State.normal)
            i = i + 1
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HandCheckerViewController: UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[component][row]
    }
    


    
}
extension HandCheckerViewController: UIPickerViewDelegate{

}


class ImageButton: UIButton{
    
    private var customInputView:UIView?
    
    private var customInputAccessoryView: UIView?
    
    override var inputAccessoryView: UIView?{
        get {
            return customInputAccessoryView
        }
        set(newValue){
            customInputAccessoryView = newValue
        }
    }
    // making the input view posible with button
    override var inputView: UIView?{
        get{
            return customInputView
        }
        set(newValue){
            customInputView = newValue
        }
    }
    //must be able to become first responder to view custominputView
    override var canBecomeFirstResponder: Bool{
        return true
    }
    // become first responder when tapped
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addTarget(self, action: #selector(ImageButton.tap), for: .touchDown)
    }
    // Respond when tapped
    @IBAction func tap(_ sender: UIButton){
        
        self.becomeFirstResponder()
        
    }
    
    
    
    
    
    
    
    
}


