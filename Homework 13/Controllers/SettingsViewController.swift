//
//  SettingViewController.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 14.06.22.
//

import UIKit

class SettingsViewController: UIViewController {

      //MARK: IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var carColorControl: UISegmentedControl!
    @IBOutlet weak var hindranceControl: UISegmentedControl!
    @IBOutlet weak var carSpeed: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Propeties
    private let carColors = ["Red", "Yellow", "Green"]
    private let hindrance = ["repair", "brick", "cone"]

    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        carColorControl.selectedSegmentIndex = carColors.firstIndex(of: SaveUserSettings.shared.carColor) ?? 0
        hindranceControl.selectedSegmentIndex = hindrance.firstIndex(of: SaveUserSettings.shared.hindrance) ?? 0

        carSpeed.keyboardType = .numberPad

        addDoneButtonOnKeyboard()

        setupSettings()
        
        registerForKeyboardNotifications()
    }

    //MARK: Methods
    func setupSettings() {
        let savedData = SaveUserSettings.shared
        userNameTextField.text = savedData.userName
        carSpeed.text = savedData.speed
    }

    private func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        carSpeed.inputAccessoryView = doneToolbar
        userNameTextField.inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction() {
        carSpeed.resignFirstResponder()
        userNameTextField.resignFirstResponder()
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func onKeyboardAppear(_ notification: NSNotification) {
        guard let info = notification.userInfo,
              let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return }

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)

        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        guard let info = notification.userInfo,
              let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }


    //MARK: IBAction
    @IBAction func saveButton(_ sender: Any) {
    SaveUserSettings.shared.userName = userNameTextField.text?.isEmpty == true
    ? nil : userNameTextField.text
    SaveUserSettings.shared.speed = carSpeed.text ?? ""
    SaveUserSettings.shared.carColor = carColors[carColorControl.selectedSegmentIndex]
    SaveUserSettings.shared.hindrance = hindrance[hindranceControl.selectedSegmentIndex]

        self.navigationController?.popViewController(animated: true)
    }
}




