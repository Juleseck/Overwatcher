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
    
    var battleUser: BattleUser!
    var failed = false
    
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
        loadJsonData()
        
        if(failed){
            showMessage()
        }
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
        
        addToDB()
    }
    
    func addToDB(){
        let realm = try! Realm()
        let user = realm.objects(BattleUser.self).filter("battleTag = '\(battleID.text!)'")
        
        if(user.count == 0){
            try! realm.write {
                realm.add(battleUser!)
            }
        } else {
            try! realm.write {
                user.first?.rating = battleUser.rating
            }
        }
        //switchScreen()
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
                            self.failed = true
                            return
                        }
                    }
                    catch let error as NSError {print("error parsing JSON: \(error)")}
                }
            }
            dataTask.resume()
        } else {
            failed = true
        }
    }
    
    func showMessage(){
        let alertController = UIAlertController(title: "Failed", message: "Battle.net ID is incorrect. Please try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        failed = false
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

