// Assignment #: In Class 02
// File Name: BMI
// Student Name: Aaron Martin
//
//  ViewController.swift
//  BMI
//
//  Created by Aaron Martin on 9/10/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var heightFtInput: UITextField!
    @IBOutlet weak var heightInInput: UITextField!
    
    @IBOutlet weak var figure: UIImageView!
    @IBOutlet weak var bmiCategory: UILabel!
    @IBOutlet weak var bmiCalculation: UILabel!
    
    var weight = 0.00
    var height = 0.00
    var bmi = 0.00
    var category = ""
    
    @IBAction func calculate(_ sender: UIButton) {
        if let wInput = Double(weightInput.text!), let ftInput = Double(heightFtInput.text!), let inInput = Double(heightInInput.text!){
            weight = wInput
            height = (ftInput * 12 + inInput)
            
            if height > 0 && weight > 0 {
                bmi = calculateBMI(weight: weight, height: height)
                category = decideBMICat(bmi: bmi)
                
                bmiCalculation.text = "BMI: \(bmi)"
                bmiCategory.text = category
            }else {
                showZeroAlert()
            }
        } else {
            showInputAlert()
        }
    }
    
    func calculateBMI(weight: Double, height: Double) -> Double {
            bmi = (703 * (weight / (height * height)))
        return bmi
    }
    
    func decideBMICat(bmi: Double) -> String {
        
        if bmi < 18.5 {
            category = "Underweight"
            figure.image = UIImage(named: "underweight")
        }
        if bmi >= 18.5 && bmi < 25 {
            category = "Healthy Weight"
            figure.image = UIImage(named: "normal")
        }
        if bmi >= 25 && bmi < 30 {
            category = "Overweight"
            figure.image = UIImage(named: "overweight")
        }
        if bmi > 29 {
            category = "Obese"
            figure.image = UIImage(named: "obese")
        }
        return category
    }
    
    @IBAction func clear(_ sender: UIButton) {
        weight = 0.00
        height = 0.00
        bmi = 0.00
        category = ""
        
        bmiCalculation.text = "BMI: 0.00"
        bmiCategory.text = "BMI Category"
        weightInput.text = ""
        heightFtInput.text = ""
        heightInInput.text = ""
        figure.image = nil
    }
    
    @IBAction func showInputAlert() {
        let alert = UIAlertController(title: "Input Error", message: "Weight and Height must be entered as whole numbers or decimal numbers.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Input Error Alert", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showZeroAlert() {
        let alert = UIAlertController(title: "Input Error", message: "Weight and Height must be greater than zero.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Input Error Alert", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

