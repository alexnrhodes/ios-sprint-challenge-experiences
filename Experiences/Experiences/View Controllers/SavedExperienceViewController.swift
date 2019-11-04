//
//  SavedExperienceViewController.swift
//  Experiences
//
//  Created by Alex Rhodes on 11/1/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class SavedExperienceViewController: UIViewController {

    let experienceController = ExperienceController.shared
    
    @IBOutlet weak var experienceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        experienceTableView.delegate = self
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

extension SavedExperienceViewController: UITableViewDegelagte {

}
