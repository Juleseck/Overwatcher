//
//  TableViewController.swift
//  Overwatcher
//
//  Created by Fhict on 02/11/16.
//  Copyright © 2016 Jules. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var heroes = [Hero]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadJsonData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }

    func parseJsonData(_ jsonObject: Array<AnyObject>) {
        for item in jsonObject {
            let hero = Hero(name: item.name, eliminations: item["Eliminations"] as! String, damageDone: item["DamageDone"] as! String, healingDone: item["HealingDone"] as! String, timePlayed: item["TimePlayed"] as! String, winPercentage: item["WinPercentage"] as! String, gamesWon: item["GamesWon"] as! String, gamesPlayed: item["gamesPlayed"] as! String, meleeKills: item["MeleeKills"] as! String, damageBlocked: item["DamageBlocked"] as! String)
            heroes.append(hero)
        }
        self.tableView.reloadData()
    }
    
    func loadJsonData(){
        let url = URL(string: "https://api.lootbox.eu/pc/eu/BloddyHarry-2844/competitive-play/hero/Winston%2CLucio%2CSoldier76/")
        let dataTask = URLSession.shared.dataTask(with: url!)
        {
            (data, response, error)
            in
            if(error != nil){
                print(error)
            } else {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self.parseJsonData(jsonObject as! Array<AnyObject>)
                }
                catch let error as NSError {print("error parsing JSON: \(error)")}
            }
        }
        dataTask.resume()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let currentRow = indexPath.row
        let currentHero = self.heroes[currentRow]
        cell.textLabel?.text = currentHero.name
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedRow = self.tableView.indexPathForSelectedRow
        let selectedHero = self.heroes[selectedRow!.row]
        let controller = segue.destination as! DetailsViewController
        controller.selectedHero = selectedHero;
    }

}
