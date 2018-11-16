//
//  TestViewController.swift
//  PokerPal
//
//  Created by Eric Tyrrell on 11/15/18.
//  Copyright © 2018 Eric Tyrrell. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    let data = [
        ["2","3","4","5","6","7","8","9","10","J","Q","K","A"],
        ["Hearts", "Spades", "Clubs", "Diamonds"]
    ]
    @IBOutlet weak var cardPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cardPicker.delegate = self
        cardPicker.dataSource = self
        // Do any additional setup after loading the view.
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
extension TestViewController: UIPickerViewDelegate{
    
}
extension TestViewController: UIPickerViewDataSource{
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
