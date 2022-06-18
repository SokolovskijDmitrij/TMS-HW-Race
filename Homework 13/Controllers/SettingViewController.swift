////
////  SettingViewController.swift
////  Homework 13
////
////  Created by Дмитрий Соколовский on 14.06.22.
////
//
//import UIKit
//
//class SettingViewController: UIViewController {
//    
//    //MARK: IBOutlet
//    
//    
//    
//    
//    
//    //MARK: Propeties
//    
//    private let carColors = ["Red", "Yellow", "Green"]
//    private let hindranceForMoving = ["Tree", "Pit", "Stones"]
//    private var carColorValue: String?
//    private var hindranceValue: String?
//    
//    
//    //MARK: ViewDidLoad
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        carColorPickerView.delegate = self
//        carColorPickerView.dataSource = self
//        hindrancePickerView.delegate = self
//        hindrancePickerView.dataSource = self
//        
//        carSpeed.keyboardType = .numberPad
//        
//        addDoneButtonOnKeyboard()
//        
//        setupSettings()
//        
//        let color = UIColor.fromString(SaveUserSetting.shared.carColor)
//        
//    }
//    
//    //MARK: Methods
//    
//    func setupSetting() {
//        let saveData = SaveUserSetting.shared
//        userNameTextField.text = saveData.userName
//        carSpeed.text = savedData.speed
//        if let carValueInt = carColors.firstIndex(where: {$0 == saveData.carColor}){
//            carColorPickerView.selectRow(carValueInt, inComponent: 0 animated: false)
//        }
//        
//        if let hindranceValue = hindranceForMoving.firstIndex(where: {$0 == saveData.hindrance}) {
//            hindrancePickerView.selectRow(hindranceValue, inComponent: 0, animated: false)
//            
//        }
//    }
//    
//    private func addDoneButtonOnKeyboard() {
//        let doneToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//        doneToolbar.barStyle = default
//        
//        let flexSpace = UIButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(self.doneButtonAction))
//        
//        let items = [flexSpace, done]
//        doneToolbar.items = items
//        doneToolbar.sizeToFit()
//        
//        carSpeed.inputAccessoryView = doneToolbar
//        userNameTextField.inputAccessoryView = doneToolbar
//        
//    }
//    
//    @objc private func doneButtonAction() {
//        carSpeed.resignFirstResponder()
//        userNameTextField.resignFirstResponder()
//    }
//    
//    //MARK: IBAction
//    
//    saveButton
//    SaveUserSetting.shared.userName = userNameTextField.text?.isEmpty == true
//    ? nil : userNameTextField.text
//    SaveUserSettings.shared.speed = carSpeed.text ?? ""
//    SaveUserSetting.shared.carColor = carColorValue ?? carColor[0]
//    SaveUserSetting.shared.hindrance = hindranceValue ?? hindranceForMoving[0]
//    
//    self.navigationController?.popViewController(animated: true)
//    
//    
//    //MARK: UIPickerViewDelegate, UIPickerViewDataSource
//    
//    extension SettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//        func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
//        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            if pickerView.restorationIdentifier == "car" {
//                return carColors.count
//            } else pickerView.restorationIdentifier == "hindrance" {
//                return hindranceForMoving.count
//            }
//            return 1
//        }
//        
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponet component: Int) -> String? {
//            if pickerView.restorationIdentifier == "car" {
//                return carColors[row]
//            } else if pickerView.restorationIdentifier == "hindrance" {
//                return hindranceForMoving[row]
//            }
//            return nil
//        }
//    }
//}
//
