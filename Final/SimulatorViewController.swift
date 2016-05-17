//
//  SimulatorViewController.swift
//  Final
//
//  Created by Robillard, Matt on 5/9/16.
//  Copyright © 2016 Robillard, Matt. All rights reserved.
//

import UIKit
import MessageUI

class SimulatorViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var friendImageView: UIImageView!
    
    var gender : String = "def"
    var promptCount = 1
    var promptValue = 1
    //1 = good, 2 = bad, 3 = ok
    var responseDict = [String: String]()
    var messageBody : String = ""
    let currentDate = NSDate()
    let dateFormatter = NSDateFormatter()
    let userDefaults = NSUserDefaults.standardUserDefaults()

    
    var results = [Result]()
    
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var sendEmailButton: UIButton!
    
    @IBOutlet weak var promptButton: UIButton!
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promptCount = 1
        endButton.hidden = true
        sendEmailButton.hidden = true
        
        responseDict["Prompt 1"] = "Incomplete"
        responseDict["Prompt 2"] = "Incomplete"
        responseDict["Prompt 3"] = "Incomplete"
        responseDict["Prompt 4"] = "Incomplete"
        responseDict["Prompt 5"] = "Incomplete"
        responseDict["End"] = "Incomplete"
        
        let resultsCounter = userDefaults.integerForKey("counter")
        
        if resultsCounter > 0
        {
            results = ArchiveResults().retrieveResults() as! [Result]
        }
        
        let genderValue = userDefaults.integerForKey("genderSwitchValue")
        if genderValue == 0
        {
            gender = "m"
        }
        if genderValue == 1
        {
            gender = "f"
        }
        
        promptButton.setTitle(String("Hey, how's it going?"), forState: .Normal)
        answerOneButton.setTitle("Good, how about you?", forState: .Normal)
        answerTwoButton.setTitle("Good.", forState: .Normal)
        answerThreeButton.setTitle("My day is going well.  How's yours?", forState: .Normal)
        answerFourButton.setTitle("I'm fine.", forState: .Normal)
        
        friendImageView.image = UIImage(named: "hello_img_\(gender)")
        
        // Do any additional setup after loading the view.
        
        if userDefaults.boolForKey("EmailExists") == true
        {
            sendEmailButton.enabled = true
            sendEmailButton.backgroundColor = UIColor.lightGrayColor()
            sendEmailButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }
        else
        {
            sendEmailButton.enabled = false
            sendEmailButton.backgroundColor = UIColor.darkGrayColor()
            sendEmailButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answerOneClick(sender: AnyObject) {
        if promptCount == 1
        {
            responseDict["Prompt 1"] = ("Good: \(answerOneButton.titleLabel!.text!)")
            
            promptButton.setTitle("Ehhh... My day is not going so well.", forState: .Normal)
            //set buttons
            //bad answer
            answerOneButton.setTitle("Oh I see.", forState: .Normal)
            //good answer
            answerTwoButton.setTitle("Oh no. What's wrong?", forState: .Normal)
            //ok answer
            answerThreeButton.setTitle("That's too bad.", forState: .Normal)
            //good answer
            answerFourButton.setTitle("Did something happen?", forState: .Normal)
            friendImageView.image = UIImage(named: "ok_img_\(gender)")
            
            promptCount += 1
            promptValue = 1
            
            messageBody = messageBody + ("Prompt 1: \(responseDict["Prompt 1"]!)") + "\r\n"
        }
        
        else if promptCount == 2
        {
            if promptValue == 1
            {
                responseDict["Prompt 2"] = ("Bad: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yea... I'm worried about my grade.", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("Why?", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Your grade from the test?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("Oh no. Why are you worried?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("Did something happen?", forState: .Normal)
                
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 2"] = ("Good: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I got my test back today, and let's just say it's not good.", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("So it's bad?", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("I'm sorry.  How bad is it?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("Oh... you didn't do well I presume?", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("That's not a good thing", forState: .Normal)
                
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 1
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 2: \(responseDict["Prompt 2"]!)") + "\r\n"
        }
        
        else if promptCount == 3
        {
            if promptValue == 1
            {
                responseDict["Prompt 3"] = ("Bad: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed the test.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("That's too bad.", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I'm so sorry.", forState: .Normal)
                //ok answer
                answerFourButton.setTitle("Oh no!", forState: .Normal)
                
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 3"] = ("Bad: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed the test.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("That's too bad", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I'm so sorry.", forState: .Normal)
                //ok answer
                answerFourButton.setTitle("Oh no!", forState: .Normal)
                
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            else if promptValue == 3
            {
                responseDict["Prompt 3"] = ("Good: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed.", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("That's not good.", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("That's too bad.", forState: .Normal)
                
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 1
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 3: \(responseDict["Prompt 3"]!)") + "\r\n"
        }
        
        else if promptCount == 4
        {
            if promptValue == 1
            {
                responseDict["Prompt 4"] = ("Good: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I don't know what happened.  I thought I studied enough...", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("Apparently, you didn't.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("Maybe next time you need to study more.", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I could help you study for the next test.", forState: .Normal)
                //good answer
                answerFourButton.setTitle("You could ask the teacher for help before the next test.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 1
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 4"] = ("Ok: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah, I know.  I thought I studied enough...", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("Hopefully, next you can study harder", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("You could ask the teacher for help before the next test.", forState: .Normal)
                //ok answer
                answerThreeButton.setTitle("Maybe next time you'll get it", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("It probably wasn't hard enough", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 3
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 4: \(responseDict["Prompt 4"]!)") + "\r\n"
        }
        
        else if promptCount == 5
        {
            if promptValue == 1
            {
                responseDict["Prompt 5"] = ("Bad: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess I just didn't do a good job this time. ", forState: .Normal)
                //set buttons
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "bad_end_\(gender)")
                
                promptValue = 2
                
                responseDict["End"] = "Bad Ending"
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 5"] = ("Ok: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess so.  I just don't want to fail another time.", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "ok_end_\(gender)")
                
                promptValue = 3
                
                responseDict["End"] = "Ok Ending"
            }
            
            else if promptValue == 3
            {
                responseDict["Prompt 5"] = ("Ok: \(answerOneButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess so.  I just don't want to fail another time", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "ok_end_\(gender)")
                
                promptValue = 3
                
                responseDict["End"] = "Ok Ending"
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 5: \(responseDict["Prompt 5"]!)") + "\r\n"
            messageBody = messageBody + ("Ending: \(responseDict["End"]!)") + "\r\n"
        }
    }
    @IBAction func answerTwoClick(sender: AnyObject) {
        if promptCount == 1
        {
            responseDict["Prompt 1"] = ("Bad: \(answerTwoButton.titleLabel!.text!)")
            
            promptButton.setTitle("Oh... I wish my day was going well", forState: .Normal)
            //set buttons
            //good answer
            answerOneButton.setTitle("Oh no.  What's wrong?", forState: .Normal)
            //ok answer
            answerTwoButton.setTitle("That's not good.", forState: .Normal)
            //ok answer
            answerThreeButton.setTitle("I'm sorry.", forState: .Normal)
            //bad answer
            answerFourButton.setTitle("Ah I see.", forState: .Normal)
            
            //set image
            friendImageView.image = UIImage(named: "sad_img_\(gender)")
            
            promptCount += 1
            promptValue = 2
            
            messageBody = messageBody + ("Prompt 1: \(responseDict["Prompt 1"]!)") + "\r\n"
        }
        
        else if promptCount == 2
        {
            if promptValue == 1
            {
                responseDict["Prompt 2"] = ("Good: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("I got my test back today, and let's just say it's not good.", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("So it's bad", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("I'm sorry. How bad is it?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("Oh... you didn't do well I presume?", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("That's not a good thing.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 1
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 2"] = ("Ok: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah... It kind of sucks.  I got my test back today, and I didn't do well.", forState: .Normal)
                //set buttons 
                //good answer
                answerOneButton.setTitle("I'm sorry.  How bad is it?", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("Oh... you didn't do well I presume", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("So it's bad?", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("that's not good", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                
                promptValue = 3
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 2: \(responseDict["Prompt 2"]!)") + "\r\n"
        }
        
        else if promptCount == 3
        {
            if promptValue == 1
            {
                responseDict["Prompt 3"] = ("Good: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed.", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("That's not good.", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("That's too bad.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 1
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 3"] = ("Bad: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed the test.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("That's too bad.", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I'm so sorry.", forState: .Normal)
                //ok answer
                answerFourButton.setTitle("Oh no!", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            else if promptValue == 3
            {
                responseDict["Prompt 3"] = ("Good: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("That's not good.", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("That's too bad.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 1
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 3: \(responseDict["Prompt 3"]!)") + "\r\n"
        }
        
        else if promptCount == 4
        {
            if promptValue == 1
            {
                responseDict["Prompt 4"] = ("Ok: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah, I know.  I thought I studied enough...", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("Maybe next time you'll get it.", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("You could ask the teacher for help before the next test.", forState: .Normal)
                //ok answer
                answerThreeButton.setTitle("Hopefully, next time you can study harder", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("It probably wasn't hard enough", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 3
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 4"] = ("Bad: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("I mean, I thought I studied pretty hard.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("Maybe next time you can do a better job studying.", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("Maybe you could ask the teacher for help next time", forState: .Normal)
                //ok answer
                answerThreeButton.setTitle("Hopefully next time you can study harder.", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("It probably wasn't hard enough", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 4: \(responseDict["Prompt 4"]!)") + "\r\n"
        }
        
        else if promptCount == 5
        {
            if promptValue == 1
            {
                responseDict["Prompt 5"] = ("Ok: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess so.  I just don't want to fail another time.", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "ok_end_\(gender)")
                
                promptValue = 3
                
                responseDict["End"] = "Ok Ending"
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 5"] = ("Good: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah! That's a good idea.  Thanks for your help!", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "happy_end_\(gender)")
                
                promptValue = 1
                
                responseDict["End"] = "Good Ending"
                
            }
            
            else if promptValue == 3
            {
                responseDict["Prompt 5"] = ("Good: \(answerTwoButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah! That's a good idea.  Thanks for your help!", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "happy_end_\(gender)")
                
                promptValue = 1
                
                responseDict["End"] = "Good Ending"
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 5: \(responseDict["Prompt 5"]!)") + "\r\n"
            messageBody = messageBody + ("Ending: \(responseDict["End"]!)") + "\r\n"
        }
    }
    
    @IBAction func answerThreeClick(sender: AnyObject) {
        if promptCount == 1
        {
            responseDict["Prompt 1"] = ("Good: \(answerThreeButton.titleLabel!.text!)")
            
            promptButton.setTitle("Ehhh... My day is not going so well.", forState: .Normal)
            //set buttons
            //bad answer
            answerOneButton.setTitle("Oh I see.", forState: .Normal)
            //good answer
            answerTwoButton.setTitle("Oh no. What's wrong?", forState: .Normal)
            //ok answer
            answerThreeButton.setTitle("That's too bad.", forState: .Normal)
            //good answer
            answerFourButton.setTitle("Did something happen?", forState: .Normal)
            
            //set image
            friendImageView.image = UIImage(named: "ok_img_\(gender)")
            
            promptCount += 1
            promptValue = 1
            
            messageBody = messageBody + ("Prompt 1: \(responseDict["Prompt 1"]!)") + "\r\n"
        }
        
        else if promptCount == 2
        {
            if promptValue == 1
            {
                responseDict["Prompt 2"] = ("Ok: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah... It kind of sucks.  I got my test back today, and I didn't do well.", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry. How bad is it?", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("Oh... you didn't do well I presume?", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("So it's bad?", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("That's not good.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 3
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 2"] = ("Ok: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah... It kind of sucks.  I got my test back today, and I didn't do well.", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry. How bad is it?", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("Oh... you didn't do well I presume?", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("So it's bad?", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("That's not good.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 3
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 2: \(responseDict["Prompt 2"]!)") + "\r\n"
        }
        
        else if promptCount == 3
        {
            if promptValue == 1
            {
                responseDict["Prompt 3"] = ("Good: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed.", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("That's not good.", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("That's too bad.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 1
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 3"] = ("Good: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed.", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("That's not good.", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("That's too bad.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 1
            }
            
            else if promptValue == 3
            {
                responseDict["Prompt 3"] = ("Bad: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed the test.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("That's too bad.", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I'm so sorry.", forState: .Normal)
                //ok answer
                answerFourButton.setTitle("Oh no!", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 3: \(responseDict["Prompt 3"]!)") + "\r\n"
        }
        
        else if promptCount == 4
        {
            if promptValue == 1
            {
                responseDict["Prompt 4"] = ("Bad: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("I mean, I thought I studied pretty hard.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("Maybe next time you can do a better job studying.", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("Maybe you could ask the teacher for help next time.", forState: .Normal)
                //ok answer
                answerThreeButton.setTitle("Hopefully next time you can study harder.", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("It probably wasn't hard enough", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 4"] = ("Good: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("I don't know what happened.  I thought I studied hard enough...", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("Apparently, you didn't.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("Maybe next time you need to study more.", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I could help you study for the next test.", forState: .Normal)
                //good answer
                answerFourButton.setTitle("You could ask the teacher for help before the next test.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 1
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 4: \(responseDict["Prompt 4"]!)") + "\r\n"
        }
        
        else if promptCount == 5
        {
            if promptValue == 1
            {
                responseDict["Prompt 5"] = ("Good: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah! That's a good idea.  Thanks for your help!", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "happy_end_\(gender)")
                
                promptValue = 1
                
                responseDict["End"] = "Good Ending"
            }
            
            else if promptValue == 2
            {
                responseDict["Prompt 5"] = ("Ok: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess so.  I just don't want to fail another time.", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "ok_end_\(gender)")
                
                promptValue = 3
                
                responseDict["End"] = "Ok Ending"
            }
            
            else if promptValue == 3
            {
                responseDict["Prompt 5"] = ("Ok: \(answerThreeButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess so.  I just don't want to fail another time.", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "ok_end_\(gender)")
                
                promptValue = 3
                
                responseDict["End"] = "Ok Ending"
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 5: \(responseDict["Prompt 5"]!)") + "\r\n"
            messageBody = messageBody + ("Ending: \(responseDict["End"]!)") + "\r\n"
        }

    }
    @IBAction func answerFourClick(sender: AnyObject) {
        if promptCount == 1
        {
            responseDict["Prompt 1"] = ("Bad: \(answerFourButton.titleLabel!.text!)")
            
            promptButton.setTitle("Oh... I wish my day was going well.", forState: .Normal)
            //set buttons
            //good answer
            answerOneButton.setTitle("Oh no. What's wrong?", forState: .Normal)
            //ok answer
            answerTwoButton.setTitle("That's not good.", forState: .Normal)
            //ok answer
            answerThreeButton.setTitle("I'm sorry.", forState: .Normal)
            //bad answer
            answerFourButton.setTitle("Ah, I see.", forState: .Normal)
            
            //set image
            friendImageView.image = UIImage(named: "sad_img_\(gender)")
            
            promptCount += 1
            promptValue = 2
            
            messageBody = messageBody + ("Prompt 1: \(responseDict["Prompt 1"]!)") + "\r\n"
        }
        
        else if promptCount == 2
        {
            if promptValue == 1
            {
                  responseDict["Prompt 2"] = ("Good: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("I got my test back today, and let's just say it's not good.", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("So it's bad?", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("I'm sorry. How bad is it?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("Oh... you didn't do well I presume?", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("That's not a good thing.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 1
            }
            
            else if promptValue == 2
            {
                  responseDict["Prompt 2"] = ("Bad: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah... I'm worried about my grade.", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("Why?", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Your grade from the test?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("Oh no. Why are you worried?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("Did something happen?", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 2: \(responseDict["Prompt 2"]!)") + "\r\n"
        }
        
        else if promptCount == 3
        {
            if promptValue == 1
            {
                  responseDict["Prompt 3"] = ("Bad: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed the test.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("That's too bad.", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I'm so sorry.", forState: .Normal)
                //ok answer
                answerFourButton.setTitle("Oh no!", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            else if promptValue == 2
            {
                  responseDict["Prompt 3"] = ("Good: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed.", forState: .Normal)
                //set buttons
                //good answer
                answerOneButton.setTitle("I'm sorry.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("That's not good.", forState: .Normal)
                //bad answer
                answerThreeButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerFourButton.setTitle("That's too bad.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 1
            }
            
            if promptValue == 3
            {
                  responseDict["Prompt 3"] = ("Bad: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("I failed the test.", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("That's too bad.", forState: .Normal)
                //bad answer
                answerTwoButton.setTitle("Did you not study?", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I'm so sorry.", forState: .Normal)
                //ok answer
                answerFourButton.setTitle("Oh no!", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "sad_img_\(gender)")
                
                promptValue = 2
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 3: \(responseDict["Prompt 3"]!)") + "\r\n"
        }
        
        else if promptCount == 4
        {
            if promptValue == 1
            {
                  responseDict["Prompt 4"] = ("Good: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("I don't know what happened.  I thought I studied enough... ", forState: .Normal)
                //set buttons
                //bad answer
                answerOneButton.setTitle("Apparently, you didn't.", forState: .Normal)
                //ok answer
                answerTwoButton.setTitle("Maybe next time you need to study more.", forState: .Normal)
                //good answer
                answerThreeButton.setTitle("I could help you study for the next test.", forState: .Normal)
                //good answer
                answerFourButton.setTitle("You could ask the teacher for help before the next test.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 1
            }
            
            else if promptValue == 2
            {
                  responseDict["Prompt 4"] = ("Ok: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah, I know.  I thought I studied enough...", forState: .Normal)
                //set buttons
                //ok answer
                answerOneButton.setTitle("Maybe next time you'll get it.", forState: .Normal)
                //good answer
                answerTwoButton.setTitle("You could ask the teacher for help before the next test.", forState: .Normal)
                //ok answer
                answerThreeButton.setTitle("Hopefully, next time you can study harder.", forState: .Normal)
                //bad answer
                answerFourButton.setTitle("It probably wasn't hard enough.", forState: .Normal)
                
                //set image
                friendImageView.image = UIImage(named: "ok_img_\(gender)")
                
                promptValue = 3
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 4: \(responseDict["Prompt 4"]!)") + "\r\n"
        }
        
        else if promptCount == 5
        {
            if promptValue == 1
            {
                  responseDict["Prompt 5"] = ("Good: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("Yeah! That's a good idea.  Thanks for your help!", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "happy_end_\(gender)")
                
                promptValue = 1
                
                responseDict["End"] = "Good Ending"
            }
            
            else if promptValue == 2
            {
                  responseDict["Prompt 5"] = ("Bad: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess I just didn't do a good job this time.", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "sad_end_\(gender)")
                
                promptValue = 2
                
                responseDict["End"] = "Bad Ending"
            }
            
            else if promptValue == 3
            {
                  responseDict["Prompt 5"] = ("Bad: \(answerFourButton.titleLabel!.text!)")
                
                promptButton.setTitle("I guess I just didn't do a good job this time.", forState: .Normal)
                //hide buttons
                answerOneButton.hidden = true
                answerTwoButton.hidden = true
                answerThreeButton.hidden = true
                answerFourButton.hidden = true
                endButton.hidden = false
                sendEmailButton.hidden = false
                
                //set image
                friendImageView.image = UIImage(named: "sad_end_\(gender)")
                
                promptValue = 2
                
                responseDict["End"] = "Bad Ending"
            }
            
            promptCount += 1
            
            messageBody = messageBody + ("Prompt 5: \(responseDict["Prompt 5"]!)") + "\r\n"
            messageBody = messageBody + ("Ending: \(responseDict["End"]!)") + "\r\n"
        }
    }
    
    @IBAction func endButtonClick(sender: AnyObject) {
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "EEEE, MMM, dd, yyyy, HH:mm"
        
        let currentDateStr: String = dateFormatter.stringFromDate(currentDate)
        
        let currentResult = Result(date : currentDateStr, results : messageBody)
        
        results += [currentResult]
        userDefaults.setBool(true, forKey: "resultsExist")
        
        ArchiveResults().archiveResults(results)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendEmailButtonPress(sender: AnyObject) {
            let composeEmailVC = MFMailComposeViewController()
            composeEmailVC.mailComposeDelegate = self
            
            composeEmailVC.setToRecipients([userDefaults.stringForKey("Email")!])
            
            composeEmailVC.setSubject("EIS Summary: \(dateFormatter.stringFromDate(currentDate))")
            
            composeEmailVC.setMessageBody(messageBody, isHTML: false)
            
            self.presentViewController(composeEmailVC, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func exitButton(sender: AnyObject) {
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "EEEE, MMM, dd, yyyy, HH:mm"
        
        let currentDateStr: String = dateFormatter.stringFromDate(currentDate)
        let incompleteResult : String = "Prompt 1: \(responseDict["Prompt 1"]!)" + "\r\n" + "Prompt 2: \(responseDict["Prompt 2"]!)" + "\r\n" + "Prompt 3: \(responseDict["Prompt 3"]!)" + "\r\n" + "Prompt 4: \(responseDict["Prompt 4"]!)" + "\r\n" + "Prompt 5: \(responseDict["Prompt 5"]!)" + "\r\n" + "Ending: \(responseDict["End"]!)"
        
        let currentResult = Result(date : currentDateStr, results : incompleteResult)
        
        results += [currentResult]
        
        userDefaults.setBool(true, forKey: "resultsExist")
        
        ArchiveResults().archiveResults(results)
        
        dismissViewControllerAnimated(true, completion: nil)
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
