//
//  Person.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 6/27/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

//import Foundation
//import UIKit
//
//class Person: NSObject, NSCoding {
//  var dataModel: DataModel!
//  
//  var name = ""
//  var notes = [Note]()
//  
//  init(name: String) {
//    self.name = name
//    super.init()
//  }
//  
//  required init(coder aDecoder: NSCoder) {
//    name = aDecoder.decodeObjectForKey("Name") as! String
//    notes = aDecoder.decodeObjectForKey("Notes") as! [Note]
//    super.init()
//  }
//  
//  func encodeWithCoder(aCoder: NSCoder) {
//    aCoder.encodeObject(name, forKey: "Name")
//    aCoder.encodeObject(notes, forKey: "Notes")
//  }
//  
//}
