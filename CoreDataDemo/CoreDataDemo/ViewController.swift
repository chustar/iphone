//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Chuma Nnaji on 1/3/15.
//  Copyright (c) 2015 Chuma Nnaji. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!

//        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
//        newUser.setValue("Blah", forKey: "username")
//        newUser.setValue("pass2", forKey: "password")
//        context.save(nil)

        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", "Blah")

        var results = context.executeFetchRequest(request, error: nil)

        if results?.count > 0 {
            for result: AnyObject in results! {
                if let user = result.valueForKey("username") as? String {
                    println(user)
                    if user == "Blah" {
//                        context.deleteObject(result as NSManagedObject)
//                        result.setValue("pass3", forKey: "password")
                    }
                }

                context.save(nil)
                println(results)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

