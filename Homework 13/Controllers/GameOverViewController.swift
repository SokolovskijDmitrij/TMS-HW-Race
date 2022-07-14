//
//  GameOverViewController.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 6.07.22.
//

import Foundation
import UIKit

class GameOverViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
    }
    
    //MARK: Method
    @objc private func back (sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
