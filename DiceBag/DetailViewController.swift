//
//  DetailViewController.swift
//  DiceBag
//
//  Created by Jared Caldwell on 12/3/17.
//  Copyright © 2017 JC Inc. All rights reserved.
//

import UIKit
import AVFoundation
var targetSound: AVAudioPlayer!

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var diceImg: UIImageView!
    @IBOutlet weak var diceNum: UILabel!
    
    
    @IBAction func tchRollDice(_ sender: Any) {
        rollDice()
    }
    
    @IBAction func btnInfo(_ sender: Any) {
        let app = UIApplication.shared
        let urlAddress = "https://en.wikipedia.org/wiki/D20_System"
        let urlw = URL(string: urlAddress)
        app.openURL(urlw!)
    }
    
    func rollDice(){
        //text animation
        diceNum.alpha = 0
        let die = detailItem
        let random = arc4random_uniform(UInt32(UInt((die!.dieNums.count))))+1
        
        UIView.animate(withDuration: 3.0,animations: {
            self.diceNum.alpha = 1.0
        })
        
        diceNum.text = String(random)
        targetSound.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        targetSound = try?
            AVAudioPlayer(contentsOf: URL(fileURLWithPath:Bundle.main.path(forResource: "Roll_Dice", ofType: "wav")! ))
        targetSound.play()
        rollDice()
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        diceNum.alpha = 0
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        rollDice()
    }
    

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.dieName
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Die? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

