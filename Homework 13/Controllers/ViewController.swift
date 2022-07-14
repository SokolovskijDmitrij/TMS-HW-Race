//
//  ViewController.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 12.05.22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    
    @IBOutlet weak var menuContainer: UIView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
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
        
        imageView.image = FileStorage.getImage(withName: "userAvatar")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameLabel.text = SaveUserSettings.shared.userName ?? "User name"
        
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
    
    //MARK: IBActions
    @IBAction func startTheGameButton(_ sender: Any) {
        //presentPinAlert()
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
    
    @IBAction func chooseAvatar(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gallary", style: .default) { [weak self]
            _ in
            self?.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Camera", style: .default) { [weak self]
            _ in
            self?.openCamera()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
        
    }
    
    @IBAction func showScoreOfGame(_ sender: Any) {
        let scoreOfGameViewController = self.storyboard?.instantiateViewController(withIdentifier: "scoreVC") as! ScoreOfGameViewController
        self.navigationController?.pushViewController(scoreOfGameViewController, animated: true)
    }
    
    //MARK: Open Gallary, Open Camera
        func openGallery() {
            if
                UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Warning", message: "You don't have permission to access gallary", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        func openCamera() {
            if
                UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Warning", message: "You don't have permission to access camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
}

    //MARK: Extension ImagePicker Delegate
    extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                imageView.image = pickedImage
                FileStorage.saveImage(pickedImage, withName: "userAvatar")
            }
            picker.dismiss(animated: true, completion: nil)
        }
}
