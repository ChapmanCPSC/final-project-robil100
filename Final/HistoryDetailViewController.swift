//
//  HistoryDetailViewController.swift
//  Final
//
//  Created by Matt on 5/14/16.
//  Copyright © 2016 Robillard, Matt. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var r : Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateLabel.text = r.date
        self.resultsLabel.text = r.results

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
