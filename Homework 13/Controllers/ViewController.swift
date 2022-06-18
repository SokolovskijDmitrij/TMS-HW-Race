//
//  ViewController.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 12.05.22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlet
   
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    
    @IBOutlet weak var menuContainer: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    //MARK: Public Properties
    
    var isMenuShown = false
    
    let yourPin = "111"
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        menuWidth.constant = 0
        blurView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBlur))
        
        blurView.addGestureRecognizer(tapGesture)
        blurView.isUserInteractionEnabled = false
        
        let nothingGesture = UITapGestureRecognizer(target: self, action: #selector(doNothing))
        
        menuContainer.addGestureRecognizer(nothingGesture)
        menuContainer.isUserInteractionEnabled = true
        
    }
    
    //MARK: Methods
    
    @objc
    private func doNothing() {}
    
    @objc
    private func dismissBlur() {
        UIView.animate(withDuration: 1) {
            self.blurView.isHidden = true
            self.blurView.isUserInteractionEnabled = false
            self.menuWidth.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.blurView.isHidden = true
            self.blurView.isUserInteractionEnabled = false
        }
        isMenuShown = false
    }
    
    //MARK: IBAction
    
    @IBAction func startTheGameButton(_ sender: Any) {
        presentPinAlert()
    }
    
    @IBAction func showMenu(_ sender: Any) {
        if isMenuShown {
            dismissBlur()
            return
        }
        self.blurView.isHidden = false
        self.blurView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 1) {
            self.menuWidth.constant = 300
            self.view.layoutIfNeeded()
        }
        
        isMenuShown = true

    }
}



