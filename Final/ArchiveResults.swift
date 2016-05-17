//
//  ArchiveResults.swift
//  Final
//
//  Created by Matt on 5/15/16.
//  Copyright © 2016 Robillard, Matt. All rights reserved.
//

import Foundation
import UIKit

class ArchiveResults : NSObject
{
    var documentDirectories : NSArray = []
    var documentDirectory : String = ""
    var path : String = ""
    
    func archiveResults(results: [Result])
    {
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDirectory = documentDirectories.objectAtIndex(0) as! String
       path = documentDirectory.stringByAppendingString("result.archive")
        if NSKeyedArchiver.archiveRootObject(results, toFile: path)
        {
           
        }
    }
    
    func retrieveResults() -> NSObject
    {
        var dataToRetrieve : [Result]?
        documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        documentDirectory = documentDirectories.objectAtIndex(0) as! String
        path = documentDirectory.stringByAppendingString("result.archive")
        if let dataToRetrieve2 = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [Result]
        {
            dataToRetrieve = dataToRetrieve2 as [Result]
        }
        
        return dataToRetrieve!
        
    }
}