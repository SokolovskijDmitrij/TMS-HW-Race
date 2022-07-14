//
//  GameViewController.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 28.06.22.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var carLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerImageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageViewTopConstrainr: NSLayoutConstraint!
    @IBOutlet weak var viewForNavigationButtons: UIView!
    @IBOutlet weak var viewMainScreenRacing: UIView!
    @IBOutlet weak var leftSideHindranceImageView: UIImageView!
    @IBOutlet weak var centerSideHindranceImageView: UIImageView!
    @IBOutlet weak var rightSideHindranceImageView: UIImageView!
    @IBOutlet weak var carView: UIImageView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!

    //MARK: Properties
    private enum Place {
        case left
        case center
        case right
    }
    
    private var position: Place = .center
    private let userName: String = SaveUserSettings.shared.userName ?? "Unknown user"
    private var userScore = 0
    private var duration: TimeInterval = 35 / (Double(SaveUserSettings.shared.speed) ?? 60)

    //MARK:  Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        initViews()
        let carImageInAssets = selectColorToCarView()
        carView.image = UIImage(named: carImageInAssets)

        leftSideHindranceImageView.image = selectKindOfHindrance(hindrance: SaveUserSettings.shared.hindrance) ?? UIImage(named: "brick")
        rightSideHindranceImageView.image = selectKindOfHindrance(hindrance: SaveUserSettings.shared.hindrance) ?? UIImage(named: "cone")
        centerSideHindranceImageView.image = selectKindOfHindrance(hindrance: SaveUserSettings.shared.hindrance) ?? UIImage(named: "repair")

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.carView.frame.intersects(self.leftSideHindranceImageView.frame) {
                timer.invalidate()
                self.showGameOverVC()
            } else if self.carView.frame.intersects(self.centerSideHindranceImageView.frame) {
                timer.invalidate()
                self.showGameOverVC()
            } else if self.carView.frame.intersects(self.rightSideHindranceImageView.frame) {
                timer.invalidate()
                self.showGameOverVC()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveDownForHindrance()
        setCarViewPosition(to: .center)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK:  Methods
    func initViews() {
        viewForNavigationButtons.layer.cornerRadius = 20
        viewForNavigationButtons.layer.masksToBounds = true

        viewMainScreenRacing.layer.cornerRadius = 20
        viewMainScreenRacing.layer.masksToBounds = true
    }
    
    private func countUserScore() {
       userScore += 1
    }
    
    private func saveLastUserRecord() {
        let record = RecordGame(userName: userName, userScore: userScore, date: Date())
        SaveUserSettings.shared.record(recordGame: record)
    }

    func selectColorToCarView() -> String {
        let changedColor = SaveUserSettings.shared.carColor
        switch changedColor {
        case "Green":
            return "Green"
        case "Red":
            return "Red"
        case "Yellow":
            return "Yellow"
        default:
            return "White"
        }
    }
    
    func selectKindOfHindrance(hindrance: String) -> UIImage? {
      
       switch hindrance {
       case "brick":
           return UIImage(named: "brick")
       case "cone":
           return UIImage(named: "cone")
       case "repair":
           return UIImage(named: "repair")
       default:
           return UIImage(named: "cone")
       }
    }
    
    private func setCarViewPosition(to position: Place) {
        let width = carView.frame.width
        
        switch position {
        case .left:
            carLeadingConstraint.constant = width * 0.55
        case .center:
            carLeadingConstraint.constant = width * 2.1
        case .right:
            carLeadingConstraint.constant = width * 3.75
        }
        view.layoutIfNeeded()
    }
    
    private func moveToRight() {
        switch position {
        case .left:
            position = .center
        case .center:
            position = .right
        default:
           break
        }
        setCarViewPosition(to: position)
        updateButtons()
    }
    
    private func moveToLeft() {
        switch position {
        case .center:
            position = .left
        case .right:
            position = .center
        default:
           break
        }
        setCarViewPosition(to: position)
        updateButtons()
    }
    
    private func updateButtons() {
        leftButton.isEnabled = position != .left
        rightButton.isEnabled = position != .right
    }
    
    private func moveCarViewToRight() {
        switch position {
        case .left:
            setCarViewPosition(to: .center)
        case .center:
            setCarViewPosition(to: .right)
        default:
            break
        }
    }
    
    private func moveCarViewToLeft() {
        switch position {
        case .center:
            setCarViewPosition(to: .left)
        case .right:
            setCarViewPosition(to: .center)
        default:
            break
        }
    }
    
    func moveDownForHindrance() {
        guard self.viewMainScreenRacing.bounds.contains(self.leftSideHindranceImageView.frame) || self.leftImageViewTopConstraint.constant < 0 else {
            self.leftImageViewTopConstraint.constant = -150
            self.centerImageViewTopConstraint.constant = -150
            self.rightImageViewTopConstrainr.constant = -150
            self.countUserScore()
            self.view.layoutIfNeeded()
            duration = max(0.04, duration * 0.7)
            return self.repeatAnimation()
        }
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: { [weak self] in
            guard let self = self else { return }
            self.leftImageViewTopConstraint.constant += 40
            self.centerImageViewTopConstraint.constant += 60
            self.rightImageViewTopConstrainr.constant += 25
            self.view.layoutIfNeeded()
        }, completion: {[weak self] _ in
            self?.repeatAnimation()
        })
    }

    func repeatAnimation() {
        moveDownForHindrance()
    }

    func showGameOverVC() {
        saveLastUserRecord()
        let gameOverVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "gameOver") as! GameOverViewController
        self.navigationController?.pushViewController(gameOverVC, animated: true)
    }
    
    //MARK:  IBActions
    @IBAction func moveCarToTheLeft(_ sender: Any) {
        UIView.animate(withDuration: 1,  animations: { [weak self] in
            self?.moveCarViewToLeft()
        }) { [weak self] _ in
            self?.moveToLeft()
        }
    }
    
    @IBAction func moveCarToTheRight(_ sender: Any) {
        UIView.animate(withDuration: 1,  animations: { [weak self] in
            self?.moveCarViewToRight()
        }) { [weak self] _ in
            self?.moveToRight()
        }
    }
}


