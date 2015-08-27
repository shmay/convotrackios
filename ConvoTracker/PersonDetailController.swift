//
//  PersonDetailController.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 6/27/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import Foundation
import UIKit
import thingy

@objc protocol PersonDetailControllerDelegate: class {
  func personDetailControllerDidCancel(controller: PersonDetailController)
  optional func personDetailController(controller: PersonDetailController, didFinishAddingPerson person: Person)
  func personDetailController(controller: PersonDetailController, didFinishEditingPerson person: Person)
}

class PersonDetailController: UIViewController {
  var person: Person?
  
  @IBOutlet weak var nameField: UITextField!
  weak var delegate: PersonDetailControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let p = person {
      self.title = "Edit Person"
      nameField.text = p.name
    }
  }
  
  @IBAction func tapDone(sender: AnyObject) {
    if person == nil {
      person = Person(name: nameField.text)
      delegate?.personDetailController!(self, didFinishAddingPerson: person!)
    } else {
      person!.name = nameField.text
      delegate?.personDetailController(self, didFinishEditingPerson: person!)
    }
  }
  
  @IBAction func tapCancel(sender: AnyObject) {
    delegate?.personDetailControllerDidCancel(self)
  }
}