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
        ["Hearts", "Spades", "Clubs", "Diamonds"]
    ]
    var lastCardTapped = 0
    
    let cardPicker = UIPickerView()
    let cardPickerToolBar = UIToolbar(frame: CGRect.zero)
    let cardsDoneButton = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: self,
        action: #selector(HandCheckerViewController.cardPickerDone(_:))
    )
    
    
    @IBOutlet var tableCards: [ImageButton]!
    
    
    
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
        
        cardPicker.dataSource = self
        cardPicker.delegate = self
        cardPicker.setNeedsLayout()
        cardPicker.isOpaque = true
        
        cardPickerToolBar.barStyle = .default
        cardPickerToolBar.items = [cardsDoneButton]
        cardPickerToolBar.sizeToFit()
        for card in tableCards{
            card.inputView = cardPicker
            card.inputAccessoryView = cardPickerToolBar
        }
        // setting up toolbar for picker view

        
        // Do any additional setup after loading the view.
    }
    @objc func cardPickerDone(_ sender: UIBarButtonItem ){
        tableCards[lastCardTapped].resignFirstResponder()
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
    
    var pickerDataSource = [["2","3","4","5","6","7","8","9","10","J","Q","K","A"], // Ranks
        ["Spades","Clubs","Hearts","Diamonds"]] //Suits
    
    
    
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

