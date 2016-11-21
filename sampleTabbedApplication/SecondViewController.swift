//
//  SecondViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/10/27.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titletxt: UITextField!
    @IBOutlet weak var point: UITextField!
    @IBOutlet weak var bady: UITextField!
    @IBOutlet weak var wather: UITextField!
    @IBOutlet weak var tmp: UITextField!
    @IBOutlet weak var utmp: UITextField!
    @IBOutlet weak var weit: UITextField!
    @IBOutlet weak var suit: UITextField!
    @IBOutlet weak var depth: UITextField!
    @IBOutlet weak var mdepth: UITextField!
    @IBOutlet weak var spres: UITextField!
    @IBOutlet weak var fpres: UITextField!
    @IBOutlet weak var stime: UITextField!
    @IBOutlet weak var ftime: UITextField!
    @IBOutlet weak var memo: UITextView!
    @IBOutlet weak var memo2: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        //Appdelegateにアクセスするための準備
        var myAp = UIApplication.shared.delegate as! AppDelegate
        //プロパティの値を書き換える（カウントアップ）
        myAp.myCount += 1
        //プロパティの値を読み出す
        print("2画面目 count=\(myAp.myCount)")
    }
    @IBAction func tapSave(_ sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let Divinglog = NSEntityDescription.entity(forEntityName: "Divinglog", in: viewContext)
        let newRecord = NSManagedObject(entity: Divinglog!, insertInto: viewContext)
        newRecord.setValue("\(titletxt.text!)", forKey: "title") //値を代入
        newRecord.setValue("\(point.text!)", forKey: "point")//値を代入
        newRecord.setValue("\(bady.text!)", forKey: "bady") //値を代入
        newRecord.setValue("\(wather.text!)", forKey: "wather")//値を代入
        newRecord.setValue("\(tmp.text!)", forKey: "tmp") //値を代入
        newRecord.setValue("\(utmp.text!)", forKey: "utmp")//値を代入
        newRecord.setValue("\(weit.text!)", forKey: "weit") //値を代入
        newRecord.setValue("\(suit.text!)", forKey: "suit")//値を代入
        newRecord.setValue("\(depth.text!)", forKey: "depth") //値を代入
        newRecord.setValue("\(mdepth.text!)", forKey: "mdepth")//値を代入
        newRecord.setValue("\(spres.text!)", forKey: "spres") //値を代入
        newRecord.setValue("\(fpres.text!)", forKey: "fpres")//値を代入
        newRecord.setValue("\(stime.text!)", forKey: "stime")//値を代入
        newRecord.setValue("\(ftime.text!)", forKey: "ftime")//値を代入
        newRecord.setValue("\(memo.text!)", forKey: "memo")//値を代入
        newRecord.setValue("\(memo2.text!)", forKey: "memo2")//値を代入
        
        
        do {
            try viewContext.save()
        } catch {
        }
    }
    
//    @IBAction func test(_ sender: UIButton) {
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let viewContext = appDelegate.persistentContainer.viewContext
//        let query: NSFetchRequest<Divinglog> = Divinglog.fetchRequest()
//        
//        do {
//            let fetchResults = try viewContext.fetch(query)
//            for result: AnyObject in fetchResults {
//                let title: String? = result.value(forKey: "title") as? String
//               
//                
//                print("title\(title)")
//               
//            }
//        } catch {
//        }
//    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

