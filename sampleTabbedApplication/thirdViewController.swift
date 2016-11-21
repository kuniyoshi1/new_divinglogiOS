//
//  thirdViewController.swift
//  sampleTabbedApplication
//
//  Created by 國吉イチ on 2016/10/27.
//  Copyright © 2016年 國吉イチ. All rights reserved.
//

import UIKit
import CoreData

class thirdViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
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
    override func viewDidAppear(_ animated: Bool) {
        //Appdelegateにアクセスするための準備
        var myAp = UIApplication.shared.delegate as! AppDelegate
        //プロパティの値を書き換える（カウントアップ）
        myAp.myCount += 1
        //プロパティの値を読み出す
        print("3画面目 count=\(myAp.myCount)")
    }
    //行数を決定するメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settitle.count
    }
    //表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier:  "myCell")
        var title2:String = settitle[(indexPath as NSIndexPath).row] as! String
        cell.textLabel?.text = title2
        return cell
    }
    //選択されたときに行う処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\((indexPath as! NSIndexPath).row)行目を選択")
         performSegue(withIdentifier: "secondSegue",sender: nil)
    }
    
    @IBAction func returenMenu(segue:UIStoryboardSegue){
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
