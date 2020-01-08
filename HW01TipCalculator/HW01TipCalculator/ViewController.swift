//  Assignment #: HW 01
//  File Name: HW01TipCalculator.swift
//  Student Name: Aaron Martin
//
//  ViewController.swift
//  HW01TipCalculator
//
//  Created by Aaron Martin on 9/13/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billValue.delegate = self
    }

    @IBOutlet weak var billValue: UITextField!
    @IBOutlet weak var tipSliderValue: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var billTotalLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    @IBAction func tipSegmentChoice(_ sender: Any) {
        calculateTip(tipPercentage: segmentCheck())
    }
    
    @IBAction func tipSliderChoice(_ sender: Any) {
        tipPercentLabel.text = "\(Int(tipSliderValue.value * 100))%"
        
        if tipSegment.selectedSegmentIndex == 3 {
            calculateTip(tipPercentage: (sender as AnyObject).value)
        }
    }
    
    @IBAction func billInput(_ sender: UITextField) {
        calculateTip(tipPercentage: segmentCheck())
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "1234567890."
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    func segmentCheck() -> Float {
        
        var tipPercentage: Float = 0.00
        
        if tipSegment.selectedSegmentIndex == 0 {
            tipPercentage = 0.1
        }
        else if tipSegment.selectedSegmentIndex == 1 {
            tipPercentage = 0.15
        }
        else if tipSegment.selectedSegmentIndex == 2 {
            tipPercentage = 0.18
        }
        else if tipSegment.selectedSegmentIndex == 3 {
            tipPercentage = tipSliderValue.value
        }
        
        return tipPercentage
    }
    
    func calculateTip(tipPercentage: Float) {
        var tip: Double = 0
        var total: Double = 0
        
        if let bill = Double(billValue.text!), bill > 0 {
            tip = bill * Double(tipPercentage)
            total = tip + bill
        }
        
        tipAmountLabel.text = String(format: "%.2f", tip)
        billTotalLabel.text = String(format: "%.2f", total)
    }
    
    @IBAction func clearAllButton(_ sender: Any) {
        billValue.text = ""
        tipSegment.selectedSegmentIndex = 0
        tipSliderValue.setValue(0.25, animated: false)
        tipPercentLabel.text = "25%"
        tipAmountLabel.text = "0.00"
        billTotalLabel.text = "0.00"
    }
}

