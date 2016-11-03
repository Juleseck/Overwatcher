//
//  PlayersViewController.swift
//  Overwatcher
//
//  Created by Fhict on 03/11/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    
    @IBOutlet weak var b1: UILabel!
    @IBOutlet weak var r1: UILabel!
    @IBOutlet weak var rr1: UILabel!
    @IBOutlet weak var b2: UILabel!
    @IBOutlet weak var r2: UILabel!
    @IBOutlet weak var rr2: UILabel!
    @IBOutlet weak var b3: UILabel!
    @IBOutlet weak var r3: UILabel!
    @IBOutlet weak var rr3: UILabel!
    @IBOutlet weak var b4: UILabel!
    @IBOutlet weak var r4: UILabel!
    @IBOutlet weak var rr4: UILabel!
    @IBOutlet weak var b5: UILabel!
    @IBOutlet weak var r5: UILabel!
    @IBOutlet weak var rr5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var players = SharedData.sharedInstance.foundPlayers
        
        b1.text = players[0].battleTag
        r1.text = String(players[0].rating)
        rr1.text = players[0].role
        b2.text = players[1].battleTag
        r2.text = String(players[1].rating)
        rr2.text = players[1].role
        b3.text = players[2].battleTag
        r3.text = String(players[2].rating)
        rr3.text = players[2].role
        b4.text = players[3].battleTag
        r4.text = String(players[3].rating)
        rr4.text = players[3].role
        b5.text = players[4].battleTag
        r5.text = String(players[4].rating)
        rr5.text = players[4].role
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func BackClick(_ sender: UIButton) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
