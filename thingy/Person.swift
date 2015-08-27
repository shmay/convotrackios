//
//  Person.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 8/25/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import Foundation
import UIKit

public class Person: NSObject, NSCoding {
  public var dataModel: DataModel!
  
  public var name = ""
  public var notes = [Note]()
  
  public init(name: String) {
    self.name = name
    super.init()
  }
  
  public required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObjectForKey("Name") as! String
    notes = aDecoder.decodeObjectForKey("Notes") as! [Note]
    super.init()
  }
  
  public func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "Name")
    aCoder.encodeObject(notes, forKey: "Notes")
  }
  
}