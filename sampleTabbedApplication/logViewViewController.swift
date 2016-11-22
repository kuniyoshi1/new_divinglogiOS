//
//  logViewViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/11/22.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import CoreData

class logViewViewController: UIViewController {
    @IBOutlet weak var settitle: UITextField!
    @IBOutlet weak var point: UITextField!
    @IBOutlet weak var bady: UITextField!
    @IBOutlet weak var wather: UITextField!
    @IBOutlet weak var tmp: UITextField!
    @IBOutlet weak var utmp: UITextField!
    @IBOutlet weak var weit: UITextField!
    @IBOutlet weak var suits: UITextField!
    @IBOutlet weak var depth: UITextField!
    @IBOutlet weak var mdepth: UITextField!
    @IBOutlet weak var spres: UITextField!
    @IBOutlet weak var fpres: UITextField!
    @IBOutlet weak var memo: UITextView!
    @IBOutlet weak var memo2: UITextView!
    
    var log:Array! = []

    

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<Divinglog> = Divinglog.fetchRequest()
        do {
            let fetchResults = try viewContext.fetch(query)
            for result: AnyObject in fetchResults {
                let title: String? = result as? String
                
                print("title\(title)")
                log.append(title!)
            }
        } catch {
        }
        
    }

        
    

    override func didReceiveMemoryWarning() {
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
