//
//  Note.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 8/25/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import Foundation
import UIKit

public class Note: NSObject, NSCoding {
  public var note = ""
  //  var id: Int
  
  public override init() {
    //    id = DataModel.nextNoteID()
    super.init()
  }
  
  public required init(coder aDecoder: NSCoder) {
    note = aDecoder.decodeObjectForKey("Note") as! String
    //    id = aDecoder.decodeObjectForKey("NoteID") as! Int
    super.init()
  }
  
  public func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(note, forKey: "Note")
    //    aCoder.encodeInteger(id, forKey: "NoteID")
  }
  
}