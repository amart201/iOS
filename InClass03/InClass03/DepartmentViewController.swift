//
//  DepartmentViewController.swift
//  InClass03
//
//  Created by Martin, Aaron on 9/16/19.
//  Copyright © 2019 Martin, Aaron. All rights reserved.
//

import UIKit

class DepartmentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectDepartment != nil {
            departmentSegmentation.selectedSegmentIndex = selectDepartment!
        }
        
        // Do any additional setup after loading the view.
    }
    
    var selectDepartment: Int?
    
    @IBOutlet weak var departmentSegmentation: UISegmentedControl!
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindDepartment" {
            let profileVC = segue.destination as! ProfileViewController
            profileVC.department = self.departmentSegmentation.titleForSegment(at: departmentSegmentation.selectedSegmentIndex)
            profileVC.departmentSelected = self.departmentSegmentation.selectedSegmentIndex
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
