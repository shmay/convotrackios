//
//  NoteForm.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 6/29/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import Foundation
import UIKit
import thingy

protocol NoteFormControllerDelegate: class {
  func noteFormControllerDidCancel(controller: NoteFormController)
  func noteFormController(controller: NoteFormController, didFinishAddingNote note: Note)
  func noteFormController(controller: NoteFormController, didFinishEditingNote note: Note)
}

class NoteFormController: UIViewController {
  var note: Note?
  
  @IBOutlet weak var noteField: UITextField!
  weak var delegate: NoteFormControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let n = note {
      self.title = "Edit Note"
      noteField.text = n.note
    }
  }

  @IBAction func tapCancel(sender: AnyObject) {
    delegate?.noteFormControllerDidCancel(self)
  }
  
  @IBAction func tapDone(sender: AnyObject) {
    if let editNote = note {
      editNote.note = noteField.text
      delegate?.noteFormController(self, didFinishEditingNote: editNote)
    } else {
      let newNote = Note()
      newNote.note = noteField.text
      delegate?.noteFormController(self, didFinishAddingNote: newNote)
    }
  }
}