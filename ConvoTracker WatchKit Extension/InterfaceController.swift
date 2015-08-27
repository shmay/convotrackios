//
//  InterfaceController.swift
//  ConvoTracker WatchKit Extension
//
//  Created by Kyle Murphy on 6/30/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import WatchKit
import Foundation
import thingy

class InterfaceController: WKInterfaceController {
  let dataModel = DataModel()

  @IBOutlet weak var table: WKInterfaceTable!
  
  override func awakeWithContext(context: AnyObject?) {
      super.awakeWithContext(context)
      
      // Configure interface objects here.
  }

  override func willActivate() {
      // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    dataModel.loadPeople()
    fillTable()
  }

  override func didDeactivate() {
      // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
    println("pers: \(dataModel.people[rowIndex])")
    dataModel.loadPeople()
    return dataModel.people[rowIndex]
  }
  
  func clearTable() {
    println("clearTable")
    let indices = NSIndexSet(indexesInRange: NSRange(location: 0, length: table.numberOfRows))
    table.removeRowsAtIndexes(indices)
  }
  
  func fillTable() {
    println("fill table")
    let p = dataModel.people
    table.setNumberOfRows(p.count, withRowType: "PersonRow")
    
    for (index,person) in enumerate(p) {
      if let row = table.rowControllerAtIndex(index) as? PersonRow {
        // Give it a message informing the user to log in
        row.personTitle.setText(person.name)
      }
    }
  }
  
  func updateTable() {
    clearTable()
    fillTable()
  }

}
