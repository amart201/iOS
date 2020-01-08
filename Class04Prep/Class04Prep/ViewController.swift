//
//  ViewController.swift
//  Class04Prep
//
//  Created by Aaron Martin on 9/23/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var newName: String?
    
    @IBOutlet weak var nameOutput: UILabel!
    
    @IBOutlet weak var nameInput: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.name = self.nameInput.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toSecondViewController" {
            if nameInput.text != "" {
                return true
            } else {
                let alert = UIAlertController(title: "Error", message: "No Input Entered", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        
        return true
    }
    
    @IBAction func myUnwindFunction(unwindSegue: UIStoryboardSegue) {
        if newName != "" {
            nameOutput.text = newName
        }
    }
}

