//
//  PopoverEducationTableVC.swift
//  36HWPopover
//
//  Created by Сергей on 22.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import UIKit

protocol PopoverEducationTableVCDelegate {
    
    var selectedCellTag: Int? { get set }
    
    func didUserSelect(cell: UITableViewCell)
    func didUserSelect(tag: Int)
    func fromSelectedCell(string: String)
    
}

class PopoverEducationTableVC: UITableViewController {
    
    var delegate: PopoverEducationTableVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
     let savedCellTag = UserDefaults.standard.integer(forKey: "selectedCellTag")
     
       // delegate?.selectedCellTag = savedCellTag
        delegate?.didUserSelect(tag: savedCellTag)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let savedSelectedCellTag = UserDefaults.standard.integer(forKey: "selectedCellTag")
        let savedSelectedCellAccessoryType = UserDefaults.standard.integer(forKey: "selectedCellAccessoryType")

            for cell in tableView.visibleCells {

                if cell.tag == savedSelectedCellTag {
                    cell.accessoryType = UITableViewCell.AccessoryType(rawValue:
                                                         savedSelectedCellAccessoryType) ?? .none
                    let text = cell.accessoryType == .checkmark ? cell.textLabel?.text ?? "" : ""
                    delegate?.fromSelectedCell(string: text)
                }

            }
       
    }

    //MARK: TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = tableView.cellForRow(at: indexPath) ?? UITableViewCell()
        
        let cells = tableView.visibleCells
        
        for cell in cells {

            if selectedCell.isEqual(cell) && (cell.accessoryType == .checkmark)  {
                continue
            } else {
                cell.accessoryType = .none
            }

        }
        
        selectedCell.accessoryType = selectedCell.accessoryType == .checkmark ? .none : .checkmark
        //delegate?.selectedCellTag = selectedCell.tag
        delegate?.didUserSelect(cell: selectedCell)
        
        UserDefaults.standard.set(selectedCell.tag, forKey: "selectedCellTag")
        UserDefaults.standard.set(selectedCell.accessoryType.rawValue, forKey: "selectedCellAccessoryType")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    deinit {
        print("PopoverEducationTableVC - deinit!🤯")
    }

}
