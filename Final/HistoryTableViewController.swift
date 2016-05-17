//
//  HistoryTableViewController.swift
//  Final
//
//  Created by Matt on 5/14/16.
//  Copyright © 2016 Robillard, Matt. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var resultsArray = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "history_detail_VC")
        
        if NSUserDefaults.standardUserDefaults().integerForKey("counter") != -1
        {
            if NSUserDefaults.standardUserDefaults().boolForKey("resultsExist") == true
            {
                resultsArray = ArchiveResults().retrieveResults() as! [Result]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultsArray.count
//        let r = NSUserDefaults.standardUserDefaults().integerForKey("counter")
//        if r < 10
//        {
//            return r
//        }
//        
//        else
//        {
//            return 10
//        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let result = self.resultsArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("history_detail_VC") as! HistoryTableViewCell
        cell.initResult(result)
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let navVC = self.storyboard!.instantiateViewControllerWithIdentifier("history_detail_VC") as! UINavigationController
        
        let detailVC = navVC.viewControllers[0] as! HistoryDetailViewController
        detailVC.r = self.resultsArray[indexPath.row]
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
