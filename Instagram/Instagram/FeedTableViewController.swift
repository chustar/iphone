//
//  FeedTableViewController.swift
//  Instagram
//
//  Created by Chuma Nnaji on 1/18/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var titles: [String] = []
    var usernames: [String] = []
    var images: [UIImage] = []
    var imageFiles: [PFFile] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        var getFollowedUsersQuery = PFQuery(className: "followers")
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser().username)
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                var followedUser = ""
                for object in objects {
                    followedUser = object["following"] as String

                    var query = PFQuery(className: "post")
                    query.whereKey("username", equalTo: followedUser)
                    query.findObjectsInBackgroundWithBlock({
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        if error == nil {
                            for object in objects {
                                self.titles.append(object["title"] as String)
                                self.usernames.append(object["username"] as String)
                                self.imageFiles.append(object["imageFile"] as PFFile)

                                self.tableView.reloadData()
                            }
                        } else {
                            println(error)
                        }
                    })
                }
            } else {
                println(error)
            }
        })
        var query = PFQuery(className: "post")
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    self.titles.append(object["title"] as String)
                    self.usernames.append(object["username"] as String)
                    self.imageFiles.append(object["imageFile"] as PFFile)

                    self.tableView.reloadData()
                }
            } else {
                println(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as FeedItemTableViewCell

        cell.title.text = titles[indexPath.row]
        cell.username.text = usernames[indexPath.row]

        imageFiles[indexPath.row].getDataInBackgroundWithBlock({
            (data: NSData!, error: NSError!) -> Void in
            if error == nil {
                let image = UIImage(data: data)
                cell.postedImage.image = image
            }
        })

        return cell
    }
}
