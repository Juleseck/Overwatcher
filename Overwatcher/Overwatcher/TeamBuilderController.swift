//
//  TeamBuilderController.swift
//  Overwatcher
//
//  Created by Fhict on 16/10/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import UIKit
import RealmSwift

class TeamBuilderController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var picker: UIPickerView!
    
    var battleUsers = [BattleUser]()
    var pickerData: [[String]] = [[String]]()
    var roles:[String] = [String]()
    
    @IBAction func onClick(_ sender: UIButton) {
        let myRole = pickerData[2][picker.selectedRow(inComponent: 2)]
        let myTag = SharedData.sharedInstance.battleUser.battleTag
        roles.append("Tank")
        roles.append("Damage")
        roles.append("Support")
        let minRating = SharedData.sharedInstance.battleUser.rating - 600
        let maxRating = SharedData.sharedInstance.battleUser.rating + 600
        //roles = roles.filter{$0 != myRole}
        
        let realm = try! Realm()
        
        for r in roles {
            let user = realm.objects(BattleUser.self).filter("rating >= \(minRating) AND rating <= \(maxRating) AND role = '\(r)' AND battleTag != '\(myTag)'")
            //let random = user.count - randomInt(min: 0, max: user.count)
            //print(random)
            //print(user.count)
            print(user.first?.battleTag, user.first?.role)

            
            self.battleUsers.append((user.last)!)
            
        }
        
        for r in roles {
            if(r != myRole){
            let user = realm.objects(BattleUser.self).filter("rating >= \(minRating) AND rating <= \(maxRating) AND role = '\(r)' AND battleTag != '\(myTag)'")
            //let random = user.count - randomInt(min: 0, max: user.count)
            //print(random)
            //print(user.count)
            //print(user.last?.battleTag, user.last?.role, user.count)
            
            self.battleUsers.append((user.last)!)
            }
        }
        SharedData.sharedInstance.foundPlayers = battleUsers
        self.performSegue(withIdentifier: "playerSegue", sender: nil)
        
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = [["EU", "US", "ASIA"],
                      ["PC", "XBOX", "PS"],
                      ["Tank", "Damage", "Support"]]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // The number of rows of data
    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }

    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        //print(pickerData[2][pickerView.selectedRow(inComponent: 2)])
        DispatchQueue.main.async() {
        if(component == 2){
            
            let realm = try! Realm()
            print(self.pickerData[2][pickerView.selectedRow(inComponent: 2)])
            let user = realm.objects(BattleUser.self).filter("battleTag = '\(SharedData.sharedInstance.battleUser.battleTag)'").first
            try! realm.write {
                user?.role = self.pickerData[2][pickerView.selectedRow(inComponent: 2)]
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
