//
//  UIViewController+Alert.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 12.05.22.
//

import UIKit

//MARK: Extention

extension ViewController {
    func presentPinAlert() {
        let alert = UIAlertController(title: "Enter your pin",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = ""
            textField.keyboardType = .decimalPad
        }
        let successfullyAction = UIAlertAction(title: "OK",
                                               style: .default) { [weak self]
            action in
            guard let self = self, let text = alert.textFields?.first?.text else { return }
            if text == self.yourPin {
                let gameVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "gameVC") as! GameViewController
                self.navigationController?.pushViewController(gameVC, animated: true)
            } else {
                self.presentAlert(text: "Wrong password! Try again!")
            }
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        alert.addAction(successfullyAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func presentAlert(text: String){
        let alert = UIAlertController(title: "Result",
                                      message: text,
                                      preferredStyle: .alert)
        let successfullyAction = UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil)
        alert.addAction(successfullyAction)
        self.present(alert, animated: true)
    }
}


