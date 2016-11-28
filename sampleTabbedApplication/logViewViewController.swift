//
//  logViewViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/11/22.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import CoreData
import MapKit

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
    @IBOutlet weak var logMap: MKMapView!
    
    var log:Array! = []
     var settitle3:[NSDictionary] = []

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<Divinglog> = Divinglog.fetchRequest()
        // Entityを指定する設定
        let entityDiscription = NSEntityDescription.entity(forEntityName: "Divinglog", in: viewContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Divinglog")
        fetchRequest.entity = entityDiscription
        
        //Appdelegateにアクセスするための準備
        var myAp = UIApplication.shared.delegate as! AppDelegate
    
        
        do {
            let fetchResults = try viewContext.fetch(query)
            print(fetchResults)
            for result: AnyObject in fetchResults {
                var title1 = (result.value(forKey: "title") as? String)!
                var weit1 = (result.value(forKey: "weit") as? String)!
                var water1 = (result.value(forKey: "wather") as? String)!
                var utmp1 = (result.value(forKey: "utmp") as? String)!
                var tmp1 = (result.value(forKey: "tmp") as? String)!
                var suit1 = (result.value(forKey: "suit") as? String)!
                var stime1 = (result.value(forKey: "stime") as? String)!
                var ftime1 = (result.value(forKey: "ftime") as? String)!
                var spres1 = (result.value(forKey: "spres") as? String)!
                var fpres1 = (result.value(forKey: "fpres") as? String)!
                var point1 = (result.value(forKey: "point") as? String)!
                var memo1 = (result.value(forKey: "memo") as? String)!
                var memo21 = (result.value(forKey: "memo2") as? String)!
                var depth1 = (result.value(forKey: "depth") as? String)!
                var mdepth1 = (result.value(forKey: "mdepth") as? String)!
                var created_at: Date! = result.value(forKey: "created_at") as! Date
                let title : NSDictionary =  ["title":title1, "created":created_at, "weit":weit1, "wather":water1,"utmp":utmp1,"tmp":tmp1,"suit":suit1,"stime":stime1,"ftime":ftime1,"spres":spres1,"fpres":fpres1,"point":point1,"memo":memo1,"memo2":memo21,"depth":depth1,"mdepth":mdepth1]
                settitle3.append(title)
            
            }
        } catch {
        }
        var settitle2:NSArray = settitle3 as NSArray
        let sortDescription = NSSortDescriptor(key: "created", ascending: false)
        let sortDescAry = [sortDescription]
        settitle3 = (settitle2.sortedArray(using: sortDescAry) as NSArray) as! [NSDictionary]
        print(myAp.test)
        print(settitle3[myAp.test]["point"]!)
        
        settitle.text = settitle3[myAp.test]["title"] as! String!
        point.text = settitle3[myAp.test]["point"] as! String!
        bady.text = settitle3[myAp.test]["bady"] as! String!
        wather.text = settitle3[myAp.test]["wather"] as! String!
        tmp.text = settitle3[myAp.test]["tmp"] as! String!
        utmp.text = settitle3[myAp.test]["utmp"] as! String!
        weit.text = settitle3[myAp.test]["weit"] as! String!
        suits.text = settitle3[myAp.test]["suit"] as! String!
        depth.text = settitle3[myAp.test]["depth"] as! String!
        mdepth.text = settitle3[myAp.test]["mdepth"] as! String!
        spres.text = settitle3[myAp.test]["spres"] as! String!
        fpres.text = settitle3[myAp.test]["fpres"] as! String!
        memo.text = settitle3[myAp.test]["memo"] as! String!
        memo2.text = settitle3[myAp.test]["memo2"] as! String!
        
        print(settitle3[myAp.test]["lat"])
        print(settitle3[myAp.test]["long"])
        let lat = settitle3[myAp.test]["lat"] as! Double
        let long = settitle3[myAp.test]["long"] as! Double
        
         let center = CLLocationCoordinate2DMake(lat,long)
        //ピンを生成
        let Pin:MKPointAnnotation = MKPointAnnotation()
        //座標を設定
        Pin.coordinate = center
        //タイトルを設定
        Pin.title = "\(settitle3[myAp.test]["title"])"

        //13　ピンを地図に置く
        self.logMap.addAnnotation(Pin)

        //14　緯度経度を中心にして半径2000mの範囲を表示
       self.logMap.region = MKCoordinateRegionMakeWithDistance(center, 2000.0, 2000.0)
        
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
