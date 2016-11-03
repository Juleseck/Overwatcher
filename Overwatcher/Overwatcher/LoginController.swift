//
//  ViewController.swift
//  Overwatcher
//
//  Created by Fhict on 13/10/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import UIKit
import RealmSwift

class LoginController: UIViewController {
    
    
    @IBOutlet weak var battleID: UITextField!
    
    @IBOutlet weak var incorrect: UILabel!
    
    @IBOutlet weak var lookUp: UIButton!
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    var battleUser: BattleUser!
    var failed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func onClick(_ sender: UIButton) {
        activityView.isHidden = false
        activityView.startAnimating()
        loadingLabel.isHidden = false
        lookUp.isEnabled = false
        
        loadJsonData()
        
        
    }
    
    func parseJsonData(data: [String:Any]) {
        battleUser = BattleUser()
        let games = data["games"] as! [String:Any]
        let quick = games["quick"] as! [String:Any]
        let compGames = games["competitive"] as! [String:Any]
        let comp = data["competitive"] as! [String:String]
        let time = data["playtime"] as! [String:String]
        
        battleUser.compWins = Int((compGames["wins"] as! String))!
        battleUser.compLost = compGames["lost"] as! Int
        battleUser.totalPlayed = Int((compGames["played"] as! String))!
        battleUser.quickWins = Int(quick["wins"] as! String)!
        battleUser.rating = Int(comp["rank"]!)!
        battleUser.rankImg = comp["rank_img"]!
        battleUser.quickTime = time["quick"]!
        battleUser.compTime = time["competitive"]!
        battleUser.avatar = data["avatar"] as! String
        battleUser.username = data["username"] as! String
        battleUser.level = data["level"] as! Int
        battleUser.battleTag = battleID.text!
        battleUser.role = "Tank"
        
        SharedData.sharedInstance.battleUser = battleUser
        addToDB()
    }
    
    func addToDB(){
        let realm = try! Realm()
        let user = realm.objects(BattleUser.self).filter("battleTag = '\(battleID.text!)'")
        let testUser = user.first
        
        if(user.count == 0){
            try! realm.write {
                realm.add(battleUser!)
            }
        } else {
            try! realm.write {
                user.first?.rating = battleUser.rating
            }
        }
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "mainAppSegue", sender: nil)
        }
    }
    
    
    func loadJsonData(){
        let link = URL(string: "https://api.lootbox.eu/pc/eu/\(battleID.text!)/profile")
        
        if(verifyUrl(url: link)){
            let dataTask = URLSession.shared.dataTask(with: link!)
            {
                (data, response, error)
                in
                if(error != nil){
                    print(error)
                } else {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        if(jsonObject["data"] != nil){
                            self.parseJsonData(data: jsonObject["data"] as! [String:Any])
                        } else {
                            self.showMessage()
                            return
                        }
                    }
                    catch let error as NSError {print("error parsing JSON: \(error)")}
                }
            }
            dataTask.resume()
        } else {
            failed = -1
        }
    }
    
    func showMessage(){
        DispatchQueue.main.async() {
            self.activityView.isHidden = true
            self.loadingLabel.isHidden = true
        let alertController = UIAlertController(title: "Failed", message: "Battle.net ID is incorrect. Please try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
            self.lookUp.isEnabled = true
        }
    }
    
    func verifyUrl (url: URL?) -> Bool {
        return UIApplication.shared.canOpenURL(url!)
    }
    
    func switchScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "TeamBuilderView") as! TeamBuilderController
        self.present(vc, animated: true, completion: nil)
    }
}

