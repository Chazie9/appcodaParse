//
//  DetailViewController.swift
//  ParseDemo
//
//  Created by Charles Harring on 9/9/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI



class DetailViewController: UIViewController {

    var currentObject : PFObject?
    
    
    // Some text fields
    @IBOutlet weak var problemTitle: UITextField!
    @IBOutlet weak var problemLocation: UITextField!
    @IBOutlet weak var problemDiscription: UITextField!
    @IBOutlet weak var managersNotes: UITextField!
    
    
    
    @IBAction func save(sender: AnyObject) {
        
        if let updateObject = currentObject as PFObject? {
            
            // Update the existing parse object
            updateObject["problemTitle"] = problemTitle.text
            updateObject["problemLocation"] = problemLocation.text
            updateObject["problemDiscription"] = problemDiscription.text
            updateObject["managersNotes"] = managersNotes.text
            
            // Save the data back to the server in a background task
            updateObject.saveEventually()
            
        } else {
            
            // Create a new parse object
            var updateObject = PFObject(className:"theProblems")
            
            updateObject["problemTitle"] = problemTitle.text
            updateObject["problemLocation"] = problemLocation.text
            updateObject["problemDiscription"] = problemDiscription.text
            updateObject["managersNotes"] = managersNotes.text
            updateObject.ACL = PFACL(user: PFUser.currentUser()!)
            
            // Save the data back to the server in a background task
            updateObject.saveEventually()
            
        }
        
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Unwrap the current object object
        if let object = currentObject {
            problemTitle.text = object["problemTitle"] as! String
            problemLocation.text = object["problemLocation"] as! String
            problemDiscription.text = object["problemDiscription"] as! String
            managersNotes.text = object["managersNotes"] as! String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
