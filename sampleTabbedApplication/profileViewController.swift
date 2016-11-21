//
//  profileViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/11/21.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import CoreData

class profileViewController: UIViewController {
    var settitle:Array! = []


    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<Divinglog> = Divinglog.fetchRequest()
        do {
            let fetchResults = try viewContext.fetch(query)
            for result: AnyObject in fetchResults {
                let title: String? = result.value(forKey: "title") as? String
                
                print("title\(title)")
                settitle.append(title!)
            }
        } catch {
        }
        
    }


        // Do any additional setup after loading the view.
    }




    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
