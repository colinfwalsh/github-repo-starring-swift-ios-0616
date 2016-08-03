//
//  ReposTableViewController.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        
        GithubAPIClient.checkIfRepositoryIsStarred("colinfwalsh", completion: {(true) in })
        
        store.getRepositoriesWithCompletion {
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.repositories.count
    }
    
    func unstarredAlertController() {
        let alertController = UIAlertController(title: "DIRECTORY UNSTARRED", message: "You unstarred this repository", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
           // print("Cancel button pressed")
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
           // print("OK button pressed")
        }
        alertController.addAction(OKAction)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func starredAlertController() {
        let alertController = UIAlertController(title: "DIRECTORY STARRED", message: "You starred this repository", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            //print("Cancel button pressed")
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            //print("OK button pressed")
        }
        alertController.addAction(OKAction)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)
        
        let repository:GithubRepository = self.store.repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let repository:GithubRepository = self.store.repositories[indexPath.row]
        
        store.toggleStarStatusForRepository(repository){(toggle) in
            if toggle == true {
                self.starredAlertController()}
            else {
                self.unstarredAlertController()}
        }
    }
}
