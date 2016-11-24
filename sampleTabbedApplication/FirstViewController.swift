//
//  FirstViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/10/27.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {
    @IBOutlet weak var myMap: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        //Appdelegateにアクセスするための準備
            var myAp = UIApplication.shared.delegate as! AppDelegate
        //プロパティの値を書き換える（カウントアップ）
            myAp.myCount = "log"
        //プロパティの値を読み出す
        print("1画面目 count=\(myAp.myCount)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

