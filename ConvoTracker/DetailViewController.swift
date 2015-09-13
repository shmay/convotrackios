//
//  DetailViewController.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 6/27/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import UIKit
import thingy

class DetailViewController: UITableViewController, NoteFormControllerDelegate,PersonDetailControllerDelegate {
  var dataModel: DataModel!

  var person: Person? {
    didSet {
      self.configureView()
    }
  }

  @IBAction func tapEdit(sender: AnyObject) {
    performSegueWithIdentifier("EditPerson", sender: self)
  }
  
  @IBOutlet var editBtn: UIBarButtonItem!
  
  func configureView() {
    println("configureView")

    // Update the user interface for the detail item.
    if let p: Person = self.person {
      println("set title")
      title = p.name
    }
    
//    self.setEditing(true, animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
        
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "tapPlus:")
    self.navigationItem.rightBarButtonItems = [addButton, editBtn]
    
    //// Do any additional setup after loading the view, typically from a nib.
    self.configureView()
  }
  
  func tapPlus(sender: AnyObject) {
    performSegueWithIdentifier("NoteForm", sender: nil)
  }
  
  func noteFormControllerDidCancel(controller: NoteFormController) {
    println("did cancel")
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func noteFormController(controller: NoteFormController, didFinishAddingNote note: Note) {
    println("notes")
    person?.notes.append(note)
    dataModel.savePeople()
    tableView.reloadData()
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func noteFormController(controller: NoteFormController, didFinishEditingNote note: Note) {
    dataModel.savePeople()
    tableView.reloadData()
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func personDetailControllerDidCancel(controller: PersonDetailController) {
    println("cancel")
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func personDetailController(controller: PersonDetailController, didFinishEditingPerson person: Person) {
    dataModel.savePeople()
    self.title = person.name
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "NoteForm" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! NoteFormController
      controller.delegate = self
      
      if let note = sender as? Note {
        controller.note = note
      }
    } else if segue.identifier == "EditPerson" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! PersonDetailController
      controller.delegate = self
      
      if let p = person {
        controller.person = p
      }
    }
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let p = person {
      return p.notes.count
    } else {
      return 0
    }
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let p = person {
      performSegueWithIdentifier("NoteForm", sender: p.notes[indexPath.row])
    }
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    
    let note = person!.notes[indexPath.row]
    
    cell.textLabel!.text = note.note
    
    return cell
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      person!.notes.removeAtIndex(indexPath.row)
      dataModel.savePeople()
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

