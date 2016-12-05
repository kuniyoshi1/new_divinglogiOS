//
//  SecondViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/10/27.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import Photos
import MobileCoreServices

class SecondViewController: UIViewController,UITextFieldDelegate,MKMapViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    @IBOutlet weak var serch: UITextField!
    
    @IBOutlet weak var dispMap: MKMapView!
    
    var targetCoordinate:String = ""
    var photo:String = ""
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    
    var lat:Double = 0
    var long:Double = 0
    var photoUrl:String = ""
    var strURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titletxt.delegate = self
        point.delegate = self
        bady.delegate = self
        wather.delegate = self
        tmp.delegate = self
        utmp.delegate = self
        weit.delegate = self
        suit.delegate = self
        depth.delegate = self
        mdepth.delegate = self
        spres.delegate = self
        fpres.delegate = self
        stime.delegate = self
        ftime.delegate = self
        serch.delegate = self

        
        //アノテーションビューを返すメソッド
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
            let testView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            
            //吹き出しを表示可能にする。
            testView.canShowCallout = true
            
            //ドラッグ可能にする。
            testView.isDraggable = true
            
            return testView
        }
        
        
        
        //ドラッグ＆ドロップ時の呼び出しメソッド
        func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
            
            //ピンを離した場合
            if(newState == .ending){
                
                if let test = view.annotation as? MKPointAnnotation {
                    //ピンのサブタイトルを最新の座標にする。
                    test.subtitle = "\(Double(test.coordinate.latitude)), \(Double(test.coordinate.longitude))"
                }
            }
        }
    
        imageFromCameraRoll.contentMode = .scaleAspectFit
    }
    override func viewDidAppear(_ animated: Bool) {
        //Appdelegateにアクセスするための準備
        var myAp = UIApplication.shared.delegate as! AppDelegate
        //プロパティの値を書き換える（カウントアップ）
  //      myAp.myCount = "addlog"
        //プロパティの値を読み出す
        print("2画面目 count=\(myAp.myCount)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        serch.text = textField.text
        // キーボードを閉じる
        textField.resignFirstResponder()
        //②入力された文字を取り出す
        let serchKeyword = serch.text
        
        //③入力された文字をデバックエリアに表示
        print(serchKeyword)
        
        //⑤CLGeocoderインスタンスを取得
        let geocoder = CLGeocoder()
        
        //⑥入力された文字から位置情報を取得
        geocoder.geocodeAddressString(serchKeyword!, completionHandler: { (placemarks:[CLPlacemark]?, error:Error?) in
            
            //⑦位置情報が存在する場合１件目の位置情報をplacemarkに取り出す
            if let placemark = placemarks?[0]{
                
                //⑧位置情報から緯度経度が存在する場合、緯度経度をtargetCoordinateに取り出す
                if let targetCoordinate = placemark.location?.coordinate{
                    
                    //⑨緯度経度をデバイスエリアに表示
                    print(targetCoordinate)
                    
                    //⑩MKPointAnnotationインスタンスを取得し、ピンを生成
                    //let pin = MKPointAnnotation()
                    
                    //11　ピンの置く場所に緯度経度を設定
                    //pin.coordinate = targetCoordinate
                    
                    //12　ピンのタイトルを設定
                    //pin.title = serchKeyword
                    
                    //13　ピンを地図に置く
                    //self.dispMap.addAnnotation(pin)
                    
                    //14　緯度経度を中心にして半径2000mの範囲を表示
                    self.dispMap.region = MKCoordinateRegionMakeWithDistance(targetCoordinate, 2000.0, 2000.0)
                    
                }
            }
        })
        return true
    }
    
    @IBAction func pressMap(_ sender: UILongPressGestureRecognizer) {
        //マップビュー内のタップした位置を取得する。
        let location:CGPoint = sender.location(in: dispMap)
        
        if (sender.state == UIGestureRecognizerState.ended){
            
            //タップした位置を緯度、経度の座標に変換する。
            let mapPoint:CLLocationCoordinate2D = dispMap.convert(location, toCoordinateFrom: dispMap)
            
            //ピンを作成してマップビューに登録する。
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            annotation.title = "ピン"
            annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
            dispMap.addAnnotation(annotation)
            lat = annotation.coordinate.latitude
            long = annotation.coordinate.longitude

    }
    }
    
    
    @IBAction func imagePic(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {    //追記
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言
            let controller = UIImagePickerController()
            
            controller.delegate = self
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //トリミング
            controller.allowsEditing = true
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(controller, animated: true, completion: nil)
            
        }
        //UserDefaultから取り出す
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        if photo != nil{
        // データを取り出す
         strURL = photo
        
        
            
            let url = URL(string: strURL as String!)
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
            let manager: PHImageManager = PHImageManager()
            manager.requestImage(for: asset,targetSize: CGSize(width: 5, height: 500),contentMode: .aspectFill,options: nil) { (image, info) -> Void in
                self.imageFromCameraRoll.image = image
            }
        }
    }
    
    //カメラロールで写真を選んだ後
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
        
        let strURL:String = assetURL.description
        
        //Coredeta用に代入
        photoUrl = strURL
        
        print(photoUrl)
        
        
        // ユーザーデフォルトを用意する
        let myDefault = UserDefaults.standard
        
        // データを書き込んで
        myDefault.set(strURL, forKey: "selectedPhotoURL")
        
        // 即反映させる
        myDefault.synchronize()
        photo = strURL
        
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
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
        let created2 = DateFormatter()
        created2.dateFormat = "yyyy/MM/dd hh:mm:ss"
        created2.timeZone = TimeZone.current
        
        var strDateTmp = created2.string(from: Date())
        var changeDate = created2.date(from: strDateTmp)
        newRecord.setValue(changeDate, forKey: "created_at")
        newRecord.setValue(lat, forKey: "lat")
        newRecord.setValue(long, forKey: "long")
        newRecord.setValue("\(photoUrl)", forKey: "photoUrl")
        print(lat)
        print(long)
        print(photoUrl)
        
        do {
            try viewContext.save()
        } catch {
        }
    }


    
    

    
    
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

