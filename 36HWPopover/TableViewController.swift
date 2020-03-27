//
//  TableViewController.swift
//  36HWPopover
//
//  Created by Сергей on 19.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//
/*
//MARK: Tasks

Поповеры надо очень хорошо отпрактиковать! Так же я рекомендую разобраться с тем, как поповер убирается из памяти (было в видео).

Учтите, на айфоне поповеров нет, поэтому для айфона вместо поповеров используйте модальные контроллеры с разными транзишинами если надо.

✅Ученик

✅1. Создайте универсальное приложение (айпад / айфон)
✅2. Первый контроллер должен быть статической таблицей с навигейшн баром
✅3. В правом углу на навигейшине должна быть кнопка инфо, если на нее нажать, то вылазит поповер с объяснением, что это такое за приложение :)

Студент

✅4. В таблице создайте классические ячейки:
✅имя + текстфилд
✅фамилия + текстфилд
✅пол + сегментед контрол (мужской/женский)
✅Дата рождения + текстфилд
✅Образование + текстфилд

✅5. с первыми тремя ячейками все понятно, а вот дальше самое интересное

Мастер

✅6. При нажатии на текст филд с датой рождения текст филду должно быть запрещено входить в режим редактирования, а вместо этого из него должен появиться поповер с UIDatePicker. При изменении даты, содержимое текст филда должно меняться (то есть мы не мучаем юзера форматами ввода, мы просто даем ему барабан с датами и предлагаем выбрать самому)

✅7. Подсказка. Вам надо сделать контроллер с дейт пикером, а дейт пикер это наследник от UIControl, то есть у него есть акшин valueChanged или типо того. У контроллера нужно создать проперти делегат, по которому мы будем отправлять данные, полученные с барабана. То есть по простому: контроллер следит за барабаном и отправляет изменения своему делегату. Не забудьте установить делегат перед создания поповера.

✅Супермен

✅8. Тоже самое сделать с образованием. Образование это список типа, неполное среднее, среднее, неполное высшее, высшее и тд, то есть если делать в сегментед контролах, то не поместится.

✅9. Когда нажимаем на образование, появляется поповер с контроллером и таблицей. Причем, выбранное образование должно быть отмечено чекбоксом. (кстати выбранная дата рождения в мастере тоже должна стоять по умолчанию в новом поповере)

✅10. У этого контроллера тоже должен быть делегат. По нажатию на ячейку вы должны изменить текущий выбор на новый (поменять чекбокс) и передать сообщение делегату, после чего тот должен изменить содержимое текст филда

✅Вот такое вот задание, а что вы хотели, это вам не хиханьки хахоньки :) Работать надо, много причем, детский сад закончился :)

*/

//additional condition
//1 allow save data by button save
//2 allow delete data by button cancel




import UIKit

enum UserDefaultsKey: String {
    
    case name
    case surname
    case gender
    case dateOfBirth
    case education
    
    static func getKeys() -> [String] {
        
        var keys = [UserDefaultsKey.name.rawValue]
        keys.append(UserDefaultsKey.surname.rawValue)
        keys.append(UserDefaultsKey.gender.rawValue)
        keys.append(UserDefaultsKey.dateOfBirth.rawValue)
        keys.append(UserDefaultsKey.education.rawValue)
        
        return keys
    }
    
}

enum MaleOrFeMaleSCState: Int {
    
    case male
    case dontNo
    case female
    
}

class TableViewController: UITableViewController {
    
    @IBOutlet var textFieldsArray: [UITextField]!
    @IBOutlet var genderSegControl: UISegmentedControl!

    var userDefaults = UserDefaults.standard
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderSegControl.selectedSegmentIndex = MaleOrFeMaleSCState.dontNo.rawValue
        let tupleUserDefaults = getDataFromUserDefaults()
        genderSegControl.selectedSegmentIndex = tupleUserDefaults.gender

        for iTextField in 0..<textFieldsArray.count {
            textFieldsArray[iTextField].delegate = self
            textFieldsArray[iTextField].text = tupleUserDefaults.textsForFields[iTextField]
        }
        
        textFieldsArray.first?.becomeFirstResponder()
        
    }

    //MARK: Actions
    
    @IBAction func actionGenderSegControl(sender: UISegmentedControl) {
        
        tableView.endEditing(true)
        
    }
    
    @IBAction func actionSaveAllData(_ sender: UIBarButtonItem) {
        
        userDefaults.set(textFieldsArray[0].text,
                         forKey: UserDefaultsKey.name.rawValue)
        userDefaults.set(textFieldsArray[1].text,
                         forKey: UserDefaultsKey.surname.rawValue)
        userDefaults.set(genderSegControl.selectedSegmentIndex,
                         forKey: UserDefaultsKey.gender.rawValue)
        userDefaults.set(textFieldsArray[2].text,
                         forKey: UserDefaultsKey.dateOfBirth.rawValue)
        userDefaults.set(textFieldsArray[3].text,
                         forKey: UserDefaultsKey.education.rawValue)
        
    }
    
    @IBAction func actionDeleteAllData(_ sender: UIBarButtonItem) {
        
        for field in textFieldsArray {
            field.text = ""
        }
        
        genderSegControl.selectedSegmentIndex = 1
        
        let userDefaultsKeys = UserDefaultsKey.getKeys()
        
        for key in userDefaultsKeys {
            
            if key != UserDefaultsKey.gender.rawValue {
                userDefaults.removeObject(forKey: key)
            } else {
                userDefaults.set(1, forKey: key)
            }
            
        }
        
    }
    
    //MARK: PopoverEducationTableVCDelegate
    
    var selectedCellTag: Int?
    
    func didUserSelect(cell: UITableViewCell) {
        
        let textOfCell = cell.textLabel?.text ?? ""
        textFieldsArray[3].text = cell.accessoryType == .checkmark ? textOfCell : ""
        selectedCellTag = cell.tag
        
    }
    
    func didUserSelect(tag: Int) {
        selectedCellTag = tag
    }
    
    func fromSelectedCell(string: String) {
        textFieldsArray[3].text = string
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: UITextFieldDelegate

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        var beginEditing = true
        
        if textField.tag == 2 {
            
            let popoverTVCDate = storyboard?.instantiateViewController(identifier: "PopoverViewControllerDate") as! PopoverViewControllerDate
            popoverTVCDate.modalPresentationStyle = .popover
            popoverTVCDate.delegate = self
            
            let popover = popoverTVCDate.popoverPresentationController
            popover?.sourceView = textField
            popover?.delegate = self
            present(popoverTVCDate, animated: true, completion:nil)
            
            let date = popoverTVCDate.date
            textFieldsArray[2].text = date.stringFromDateWithString(format: "MM/dd/yyyy")
            
            tableView.endEditing(true)
            beginEditing = false
            
        } else if textField.tag == 3 {
            
            let popoverTableVCEducation = storyboard?.instantiateViewController(identifier: "PopoverEducationTableVC") as! PopoverEducationTableVC
            popoverTableVCEducation.delegate = self
            popoverTableVCEducation.modalPresentationStyle = .popover
            
            let popover = popoverTableVCEducation.popoverPresentationController
            popover?.delegate = self
            popover?.sourceView = textField
    
            present(popoverTableVCEducation, animated: true, completion: nil)
            
            tableView.endEditing(true)
            beginEditing = false
            
        }
        
        return beginEditing
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let text = NSString(string: textField.text ?? "")
        let newString = text.replacingCharacters(in: range, with: string)
        let maxLenghtStr = 20
        let checkSet = CharacterSet.decimalDigits.inverted
        let checkArray = string.components(separatedBy: checkSet)
        
        if newString.count > maxLenghtStr {
            return false
        }
        
        if checkArray.count == 2 || string == "" {
            return true
        } else {
            return false
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag != textFieldsArray.last?.tag {
            textFieldsArray[textField.tag + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    //MARK: UIDatePickerDelegate
    
    func editing(_ datePicker: UIDatePicker) {
        
        let dateStr = datePicker.date.stringFromDateWithString(format: "MM/dd/yyyy")
        textFieldsArray[2].text = dateStr
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PopoverViewControllerDate" {
            let pvc = segue.destination as! PopoverViewControllerDate
            pvc.delegate = self
        }
        
        if segue.identifier == "popoverViewController" {
            tableView.endEditing(true)
        }
        
    }
    
    //MARK: Help Functions
    
    private func getDataFromUserDefaults() -> (textsForFields: [String], gender: Int) {
        
        var strForFields = [String]()
        
        let name = userDefaults.string(forKey: UserDefaultsKey.name.rawValue) ?? ""
        let surname = userDefaults.string(forKey: UserDefaultsKey.surname.rawValue) ?? ""
        let gender = userDefaults.integer(forKey: UserDefaultsKey.gender.rawValue)
        let dateOfBirth = userDefaults.string(forKey: UserDefaultsKey.dateOfBirth.rawValue) ?? ""
        let education = userDefaults.string(forKey: UserDefaultsKey.education.rawValue) ?? ""
        
        strForFields.append(name)
        strForFields.append(surname)
        strForFields.append(dateOfBirth)
        strForFields.append(education)
        
        return (strForFields, gender)
    }

}
