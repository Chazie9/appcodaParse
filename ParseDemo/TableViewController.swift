//
//  TableViewController.swift
//  ParseDemo
//
//  Created by Charles Harring on 9/9/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI


class TableViewController: PFQueryTableViewController {
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
            super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        
            // Configure the PFQueryTableView
            self.parseClassName = "theProblems"
            self.textKey = "problemTitle"
            self.pullToRefreshEnabled = true
            self.paginationEnabled = false
        }
    
        // Define the query that will provide the data for the table view
        override func queryForTable() -> PFQuery {
                var query = PFQuery(className: "theProblems")
                query.orderByAscending("problemTitle")
                return query
        }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let problemTitle = object?["problemTitle"] as? String {
            cell?.textLabel?.text = problemTitle
        }
        if let problemLocation = object?["problemLocation"] as? String {
            cell?.detailTextLabel?.text = problemLocation
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        var detailScene = segue.destinationViewController as! DetailViewController
        
        // Pass the selected object to the destination view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as! PFObject)
        }
    }
       // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
   override func viewDidAppear(animated: Bool) {
        
     // Refresh the table to ensure any data changes are displayed
      tableView.reloadData()


   }
}
    