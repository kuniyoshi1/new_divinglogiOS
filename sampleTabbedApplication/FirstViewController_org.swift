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
                var title1:String = result.value(forKey: "title") as! String
                var weit1:String = result.value(forKey: "weit") as! String
                var water1:String = result.value(forKey: "wather") as! String
                var utmp1:String = result.value(forKey: "utmp") as! String
                var tmp1:String = result.value(forKey: "tmp") as! String
                var suit1:String = result.value(forKey: "suit") as! String
                var stime1:String = result.value(forKey: "stime") as! String
                var ftime1:String = result.value(forKey: "ftime") as! String
                var spres1:String = result.value(forKey: "spres") as! String
                var fpres1:String = result.value(forKey: "fpres") as! String
                var point1:String = result.value(forKey: "point") as! String
                var memo1:String = result.value(forKey: "memo") as! String
                var memo21:String = result.value(forKey: "memo2") as! String
                var depth1:String = result.value(forKey: "depth") as! String
                var mdepth1:String = result.value(forKey: "mdepth") as! String
                var created_at: Date! = result.value(forKey: "created_at") as! Date
                var lat:Double = result.value(forKey: "lat") as! Double
                var long:Double = result.value(forKey: "long") as! Double
                var photoUrl:String = result.value(forKey: "photoUrl") as! String
                var strdate:String = result.value(forKey: "date") as! String
                
                let title :NSDictionary =  ["title":title1 as AnyObject, "created":created_at as AnyObject, "weit":weit1 as AnyObject, "wather":water1 as AnyObject,"utmp":utmp1 as AnyObject,"tmp":tmp1 as AnyObject,"suit":suit1 as AnyObject,"stime":stime1 as AnyObject,"ftime":ftime1 as AnyObject,"spres":spres1 as AnyObject,"fpres":fpres1 as AnyObject,"point":point1 as AnyObject,"memo":memo1 as AnyObject,"memo2":memo21 as AnyObject,"depth":depth1 as AnyObject,"mdepth":mdepth1 as AnyObject,"lat":lat as AnyObject,"long":long as AnyObject,"photoUrl":photoUrl as AnyObject,"date":strdate as AnyObject]
                settitle3.append(title as NSDictionary)
                
            }
        } catch {
        }
    
//        var settitle2:NSArray = settitle3 as NSArray
//        let sortDescription = NSSortDescriptor(key: "created", ascending: false)
//        let sortDescAry = [sortDescription]
//        settitle3 = (settitle2.sortedArray(using: sortDescAry) as NSArray) as! [NSDictionary]
//        print(myAp.test)
//        print(settitle3[myAp.test]["point"]!)
//        print ("\(settitle3[myAp.test]["lat"])")
//        print ("\(settitle3[myAp.test]["long"])")
         if settitle3.count > 0 {
        for i in settitle3{
            print("key=\(i)")
            //var torihada = settitle3[i] as! AnyObject
            print(i["lat"])
        let lat = i["lat"] as! Double
        let long = i["long"] as! Double
            let center = CLLocationCoordinate2DMake(lat,long)
            //ピンを生成
            let Pin:MKPointAnnotation = MKPointAnnotation()
            //座標を設定
            Pin.coordinate = center
            //タイトルを設定
           // Pin.title = "\(settitle3[myAp.test]["title"]!)"
            
            //13　ピンを地図に置く
            self.myMap.addAnnotation(Pin)
            
            //14　緯度経度を中心にして半径2000mの範囲を表示
            self.myMap.region = MKCoordinateRegionMakeWithDistance(center, 2000000.0, 2000000.0)

        }
        }
    }
    
//        if settitle3.count > 0 {
//        let lat = settitle3[myAp.test]["lat"] as! Double
//        let long = settitle3[myAp.test]["long"] as! Double
//        
//        let center = CLLocationCoordinate2DMake(lat,long)
//        //ピンを生成
//        let Pin:MKPointAnnotation = MKPointAnnotation()
//        //座標を設定
//        Pin.coordinate = center
//        //タイトルを設定
//        Pin.title = "\(settitle3[myAp.test]["title"]!)"
//        
//        //13　ピンを地図に置く
//        self.myMap.addAnnotation(Pin)
//        
//        //14　緯度経度を中心にして半径2000mの範囲を表示
//        self.myMap.region = MKCoordinateRegionMakeWithDistance(center, 2000000.0, 2000000.0)
//        }
//    }
    

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

