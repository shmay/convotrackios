//
//  MasterViewController.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 6/27/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import UIKit
import thingy

class MasterViewController: UITableViewController, PersonDetailControllerDelegate {
  var dataModel: DataModel!

  var objects = [AnyObject]()

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem()

    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "tapPlus:")
    self.navigationItem.rightBarButtonItem = addButton
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func tapAction(sender: AnyObject) {
    showSheet()
  }
  
  func tapPlus(sender: AnyObject) {
    performSegueWithIdentifier("personForm", sender: nil)
  }
  
  func personDetailControllerDidCancel(controller: PersonDetailController) {
    println("cancel")
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func personDetailController(controller: PersonDetailController, didFinishAddingPerson person: Person) {
    dataModel.people.append(person)
    dataModel.savePeople()
    println("did finish adding person: \(count(dataModel.people))")
    tableView.reloadData()
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func personDetailController(controller: PersonDetailController, didFinishEditingPerson person: Person) {
    tableView.reloadData()
    dismissViewControllerAnimated(true, completion: nil)
  }

  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow() {
          let vc = segue.destinationViewController as! DetailViewController
          let person = dataModel.people[indexPath.row] as Person
          vc.person = person
          vc.dataModel = dataModel
        }
    } else if segue.identifier == "personForm" {
      let navigationController = segue.destinationViewController as! UINavigationController
      let controller = navigationController.topViewController as! PersonDetailController
      controller.delegate = self
    }
  }
  
  
  func showSheet() {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
    
    let aboutAction = UIAlertAction(title: "About", style: .Default, handler: {action in
      self.performSegueWithIdentifier("AboutUs", sender: self)
    })
    alertController.addAction(aboutAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    alertController.addAction(cancelAction)
    
    presentViewController(alertController, animated: true, completion: nil)
  }


  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.people.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

    let person = dataModel.people[indexPath.row] as Person
    
    println("cell for row: \(person.name)")
    (cell.viewWithTag(100) as? UILabel)?.text = person.name
    (cell.viewWithTag(101) as? UILabel)?.text = "(\(person.notes.count))"

    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      let p = dataModel.people[indexPath.row]
      
      if p.notes.count > 0 {
        var alert = UIAlertController(title: "Are you sure?", message: "All notes for this person will be destroyed",preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "I'm sure", style: .Destructive, handler: { action in
          self.dataModel.people.removeAtIndex(indexPath.row)
          tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
          self.dataModel.savePeople()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
      } else {
        dataModel.people.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        self.dataModel.savePeople()
      }
      

    } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

}

