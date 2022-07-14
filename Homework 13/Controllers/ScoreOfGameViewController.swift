//
//  ScoreOfGameViewController.swift
//  Homework 13
//
//  Created by Дмитрий Соколовский on 6.07.22.
//

import UIKit

class ScoreOfGameViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var scoreTableView: UITableView!
    
    //MARK:  Properties
    let usersScoresArray: [RecordGame] = SaveUserSettings.shared.usersScores.sorted(by: >)
    
    //MARK:  ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTableView.dataSource = self
    }
}

    //MARK: UITableViewDataSource
extension ScoreOfGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersScoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.red
        }
        let user = usersScoresArray[indexPath.row]
        let stringDate = user.stringDate
        
        cell.isUserInteractionEnabled = false
        cell.textLabel?.text =
        """
        User name: \(user.userName)
        User score: \(String(user.userScore))
        Date: \(stringDate)
        """
        return cell
    }
}
