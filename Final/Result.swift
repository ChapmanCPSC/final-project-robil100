//
//  Result.swift
//  Final
//
//  Created by Matt on 5/14/16.
//  Copyright © 2016 Robillard, Matt. All rights reserved.
//

import UIKit

class Result : NSObject {
    var date : String
    var results : String

    init(date : String, results: String)
    {
        self.date = date
        self.results = results
    }

    init(coder decoder: NSCoder)
    {
        self.date = decoder.decodeObjectForKey("date") as! String
        self.results = decoder.decodeObjectForKey("results") as! String
    }

    func encodeWithCoder(coder: NSCoder)
    {
        coder.encodeObject(self.date, forKey: "date")
        coder.encodeObject(self.results, forKey: "results")
    }
}


