//
//  DataModel.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 8/25/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import Foundation

private let kPeopleFileName = "People"
private let kPeopleFileExtension = "plist"
private let kAppGroupIdentifier = "group.com.blah.kmurphles.convo.documents"
private let kInitialPeopleCopiedKey = "com.blah.kmurphles.convo.peopleCopied"

public class DataModel {
  public var people = [Person]()
  
  public init() {
    loadPeople()
    registerDefaults()
  }
  
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! [String]
    return paths[0]
  }
  
  func dataFilePath() -> String {
    return documentsDirectory().stringByAppendingPathComponent("People.plist")
  }
  
  func registerDefaults() {
    let dictionary = ["NoteID": 0 ]
    
    NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
  }
  
  public func savePeople() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(people, forKey: "People")
    archiver.finishEncoding()
    println("saved people: \(savedPeopleURL.absoluteString)")
    data.writeToURL(savedPeopleURL, atomically: true)
  }
  
  public func loadPeople() {
    let path = savedPeopleURL
    if let data = NSData(contentsOfURL: path) {
      println("peeps")
      let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
      people = unarchiver.decodeObjectForKey("People") as! [Person]
      unarchiver.finishDecoding()
    }
    
  }
  
  class func nextNoteID() -> Int {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let itemID = userDefaults.integerForKey("NoteID")
    userDefaults.setInteger(itemID + 1, forKey: "NoteID")
    userDefaults.synchronize()
    return itemID
  }
  
  private let savedPeopleURL: NSURL = {
    var sharedContainerURL: NSURL? =
    NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(kAppGroupIdentifier)
    
    var docURL = NSURL()
    if let sharedContainerURL = sharedContainerURL {
      println("shared made it")
      docURL = sharedContainerURL.URLByAppendingPathComponent("\(kPeopleFileName).\(kPeopleFileExtension)")
    }
    return docURL
    }()
}