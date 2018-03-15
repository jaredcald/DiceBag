//
//  MasterViewController.swift
//  DiceBag
//
//  Created by Jared Caldwell on 12/3/17.
//  Copyright © 2017 JC Inc. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    var DiceBag = [Die]()
    
    func PopulateDiceBag() {
        let urlString = "https://api.myjson.com/bins/1e4gbf"
        //JSONInformation
        let jsURL:URL = URL(string: urlString)!
        let jsonUrlData = try? Data (contentsOf: jsURL)
        print(jsonUrlData ?? "ERROR: No Data To Print. JSONURLData is Nil")
        
        if(jsonUrlData != nil){
            let dictionary:NSDictionary =
                (try! JSONSerialization.jsonObject(with: jsonUrlData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            print(dictionary)
            
            let dieDetails =
                dictionary["DiceBag"]! as! [[String:AnyObject]]
            
            for index in 0...dieDetails.count - 1
                
            {
                let single = dieDetails[index]
                let die = Die()
                //die = Dice()
                die.dieName = single["dieName"] as! String
                die.dieNums = single["dieNums"] as! [Int]
                die.dieImage = single["dieImage"] as! String
                die.dieURL = single["dieURL"] as! String
                //Dice loading information
                DiceBag.append(die)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopulateDiceBag()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDie" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = DiceBag[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DiceBag.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = DiceBag[indexPath.row]
        cell.textLabel!.text = object.dieName
        //hardcode images
        //        if object.dieName == "d4" {
        //            object.dieImage = "d4.jpeg"
        //        }
        //        else if  object.dieName == "d6"{
        //            object.dieImage = "d6.jpeg"
        //        }
        //        else if  object.dieName == "d8"{
        //            object.dieImage = "d8.jpeg"
        //        }
        //        else if  object.dieName == "d10"{
        //            object.dieImage = "d10.jpeg"
        //        }
        //        else if  object.dieName == "d12"{
        //            object.dieImage = "d12.jpeg"
        //        }
        //        else object.dieImage = "d20.jpeg"}
        //
        //I can add image URL to Dice in JSON
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


}

