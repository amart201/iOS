//
//  ViewController.swift
//  UITableViewPreLab
//
//  Created by Aaron Martin on 9/30/19.
//  Copyright © 2019 Aaron Martin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var carModels = ["Honda": ["Civic", "Accord", "Ridgeline"], "Toyota": ["Corolla", "Camry", "Matrix"], "Nissan": ["Altima", "Maxima", "Titan"]]
    var carMakes = [String]()
    
    @IBOutlet weak var textFieldOutput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let carMake = carMakes[section]
        
        return (carModels[carMake]?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
        
        let carMake = carMakes[indexPath.section]
        let modelsInMake = carModels[carMake]
        let carModel = modelsInMake![indexPath.row]
        
        cell.textLabel?.text = carModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //colors.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return carMakes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let carMake = carMakes[section]
        return carMake
    }

    @IBOutlet weak var uiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carMakes.append(contentsOf: carModels.keys)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

