//
//  AboutViewController.swift
//  ConvoTracker
//
//  Created by Kyle Murphy on 8/25/15.
//  Copyright (c) 2015 Kyle Murphy. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController, UIWebViewDelegate {
  @IBOutlet weak var webV: UIWebView!
  @IBAction func tapClose(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    webV.delegate = self
    // Load the BullsEye.html file into the web view.
    if let htmlFile = NSBundle.mainBundle().pathForResource("about", ofType: "html") {
      let htmlData = NSData(contentsOfFile: htmlFile)
      let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
      webV.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
    }
  }
  
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    println("request: \(request)")
    if navigationType == UIWebViewNavigationType.LinkClicked {
      UIApplication.sharedApplication().openURL(request.URL!)
      return false;
    }
    return true;
  }
  
}

