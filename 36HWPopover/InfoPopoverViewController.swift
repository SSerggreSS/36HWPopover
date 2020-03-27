//
//  InfoPopoverViewController.swift
//  36HWPopover
//
//  Created by Сергей on 19.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import UIKit

class InfoPopoverViewController: UIViewController {

    //MARK: IBOutlet

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelAboutApp: UILabel!
    @IBOutlet weak var labelRequirements: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "ListForFilling")
        labelAboutApp.textColor = .orange
        labelAboutApp.text = "This page to fill out a resume"
        
        labelRequirements.numberOfLines = 2
        labelRequirements.textColor = .red
        labelRequirements.text = "Please fill in all five fields \n for a successful..."
        
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
