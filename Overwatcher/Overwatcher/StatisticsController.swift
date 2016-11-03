//
//  StatisticsController.swift
//  Overwatcher
//
//  Created by Fhict on 30/10/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import UIKit

class StatisticsController: UIViewController {

    var battleUser = BattleUser()
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var cWinsLabel: UILabel!
    @IBOutlet weak var cLostLabel: UILabel!
    @IBOutlet weak var cTotalLabel: UILabel!
    @IBOutlet weak var cTimeLabel: UILabel!
    @IBOutlet weak var qWinsLabel: UILabel!
    @IBOutlet weak var qTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        battleUser = SharedData.sharedInstance.battleUser
        usernameLabel.text = battleUser.username
        ratingLabel.text = String(battleUser.rating)
        cWinsLabel.text = String(battleUser.compWins)
        cLostLabel.text = String(battleUser.compLost)
        cTotalLabel.text = String(battleUser.totalPlayed)
        cTimeLabel.text = battleUser.compTime.replacingOccurrences(of: "hours", with: "")
        qWinsLabel.text = String(battleUser.quickWins)
        qTimeLabel.text = battleUser.quickTime.replacingOccurrences(of: "hours", with: "")
        
        if let checkedUrl = URL(string: battleUser.rankImg) {
            ratingImage.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, name: "rating")
        }
        if let checkedUrl = URL(string: battleUser.avatar) {
            ratingImage.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, name: "avatar")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, name: String?) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                if(name == "avatar"){
                self.avatarImage.image = UIImage(data: data)
                } else {
                    self.ratingImage.image = UIImage(data: data)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
