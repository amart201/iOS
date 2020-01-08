//
//  DepartmentViewController.swift
//  InClass04
//
//  Created by Martin, Aaron on 9/23/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController {

    var selectedDepartment: Int?
    
    @IBOutlet weak var departmentSegmentation: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedDepartment != nil {
            departmentSegmentation.selectedSegmentIndex = selectedDepartment!
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateButton(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("DepartmentUpdate"), object: self.departmentSegmentation.titleForSegment(at: departmentSegmentation.selectedSegmentIndex))
        navigationController?.popViewController(animated: true)
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
