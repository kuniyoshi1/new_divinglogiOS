//
//  FirstViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/10/27.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class FirstViewController: UIViewController {
    @IBOutlet weak var myMap: MKMapView!
    var settitle3:[NSDictionary] = []
    
    var lat:Double = 0
    var long:Double = 0


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
                var lat = result.value(forKey: "lat") as! Double
                var long = result.value(forKey: "long") as! Double
                
                let title : NSDictionary =  ["title":title1, "created":created_at, "weit":weit1, "wather":water1,"utmp":utmp1,"tmp":tmp1,"suit":suit1,"stime":stime1,"ftime":ftime1,"spres":spres1,"fpres":fpres1,"point":point1,"memo":memo1,"memo2":memo21,"depth":depth1,"mdepth":mdepth1,"lat":lat,"long":long]
                settitle3.append(title)
                
            }
        } catch {
        }
        var settitle2:NSArray = settitle3 as NSArray
        let sortDescription = NSSortDescriptor(key: "created", ascending: false)
        let sortDescAry = [sortDescription]
        settitle3 = (settitle2.sortedArray(using: sortDescAry) as NSArray) as! [NSDictionary]
//        print(myAp.test)
//        print(settitle3[myAp.test]["point"]!)
//        print ("\(settitle3[myAp.test]["lat"])")
//        print ("\(settitle3[myAp.test]["long"])")
       
        if settitle3 != nil{
        let lat = settitle3[myAp.test]["lat"] as! Double
        let long = settitle3[myAp.test]["long"] as! Double
        
        let center = CLLocationCoordinate2DMake(lat,long)
        //ピンを生成
        let Pin:MKPointAnnotation = MKPointAnnotation()
        //座標を設定
        Pin.coordinate = center
        //タイトルを設定
        Pin.title = "\(settitle3[myAp.test]["title"]!)"
        
        //13　ピンを地図に置く
        self.myMap.addAnnotation(Pin)
        
        //14　緯度経度を中心にして半径2000mの範囲を表示
        self.myMap.region = MKCoordinateRegionMakeWithDistance(center, 20000.0, 20000.0)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        //Appdelegateにアクセスするための準備
            var myAp = UIApplication.shared.delegate as! AppDelegate
        //プロパティの値を書き換える（カウントアップ）
   //         myAp.myCount = "log"
        //プロパティの値を読み出す
        print("1画面目 count=\(myAp.myCount)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

