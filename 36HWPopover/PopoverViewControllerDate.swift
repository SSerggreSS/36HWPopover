//
//  PopoverViewControllerWithDP.swift
//  36HWPopover
//
//  Created by Сергей on 21.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import UIKit

protocol PopoverViewControllerDateDelegate {
    
    func editing(_ datePicker: UIDatePicker)
    
}

class PopoverViewControllerDate: UIViewController {
    
    var delegate: PopoverViewControllerDateDelegate?

    var date = Date()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func loadView() {
        super.loadView()
     
        let date = UserDefaults.standard.object(forKey: "Date") as? Date
        datePicker.setDate(date ?? Date(), animated: false)
        delegate?.editing(datePicker)
        self.date = datePicker.date
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        datePicker.backgroundColor = .orange
        
    }

    //MARK: Actions
    
    @IBAction func actionDatePicker(_ sender: UIDatePicker) {
    
        delegate?.editing(sender)
        UserDefaults.standard.set(sender.date, forKey: "Date")
        
    }
    
    deinit {
        print("PopoverViewControllerDate is deinit🤯")
    }

}
