//
//  PersonController.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 6/30/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import WatchKit
import Foundation
import thingy

class PersonController: WKInterfaceController {
  var person: Person?
  
  @IBOutlet weak var table: WKInterfaceTable!
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    person = context as? Person
    
    self.setTitle(person?.name)
    println("cntx: \(person)")
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    updateTable()
  }

  
  func updateTable() {
    if let p = person {
      println("notes count: \(p.notes.count)")
      table.setNumberOfRows(p.notes.count, withRowType: "NoteRow")
      
      for (index,note) in enumerate(p.notes) {
        if let row = table.rowControllerAtIndex(index) as? NoteRow {
          // Give it a message informing the user to log in
          row.noteTitle.setText(note.note)
        }
      }
    }
  }
}
