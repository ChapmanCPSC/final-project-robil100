//
//  ViewController.swift
//  Final
//
//  Created by Robillard, Matt on 5/9/16.
//  Copyright © 2016 Robillard, Matt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!

    @IBOutlet weak var genderSwitch: UISegmentedControl!
    
    var gender : String = "temp2"
    let userDefaults = NSUserDefaults()
    var counter = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userDefaults.removeObjectForKey("genderSwitchValue")
        
        if userDefaults.integerForKey("counter") > 0
        {
            historyButton.enabled = true
            
        }
        else
        {
            historyButton.enabled = false
            historyButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButton(sender: AnyObject) {
        counter = userDefaults.integerForKey("counter")
        counter += 1
        userDefaults.setInteger(counter, forKey: "counter")
        historyButton.enabled = true
        historyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    @IBAction func maleFemaleSwitch(sender: AnyObject) {
        userDefaults.removeObjectForKey("genderSwitchValue")
        userDefaults.setInteger(genderSwitch.selectedSegmentIndex, forKey: "genderSwitchValue")
        userDefaults.synchronize()
    }
    
    @IBAction func historyButton(sender: AnyObject) {
    }
    
    @IBAction func setEmailButton(sender: AnyObject) {
    }
    
}

