//
//  ExtensionDate.swift
//  36HWPopover
//
//  Created by Сергей on 24.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import Foundation

extension Date {
  
    func stringFromDateWithString(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from: self)
        
        return dateStr
    }
    
}
