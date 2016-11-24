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
    var log:[NSDictionary] = []
    var selectedName:String = ""
    var settitle:[NSDictionary] = []
    @IBOutlet weak var myTable: UITableView!
 

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<Divinglog> = Divinglog.fetchRequest()
      
        
        do {
            let fetchResults = try viewContext.fetch(query)
            for result: AnyObject in fetchResults {
               var title1 = (result.value(forKey: "title") as? String)!
                var created_at: Date! = result.value(forKey: "created_at") as! Date
                let title : NSDictionary =  ["title":title1, "created":created_at]
                settitle.append(title)
                print(settitle)
            }
        } catch {
        }
        var settitle2:NSArray = settitle as NSArray
        let sortDescription = NSSortDescriptor(key: "created", ascending: false)
        let sortDescAry = [sortDescription]
        settitle = (settitle2.sortedArray(using: sortDescAry) as NSArray) as! [NSDictionary]


        
        
    }
    override func viewDidAppear(_ animated: Bool) {
                //プロパティの値を書き換える（カウントアップ）
            }
    //行数を決定するメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return log!["title"].count
        return settitle.count
    }
    
    //表示するセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier:  "myCell")
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "myCell") as! myTableViewCell
        var created = settitle[indexPath.row]["created"]
        //dateformat
        let created2 = DateFormatter()
        created2.dateFormat = "yyyy/MM/dd hh:mm:ss "
        //Stringに変換
        let strcreated = created2.string(from: created as! Date)
        let title2 = settitle[indexPath.row]["title"]
        cell2.textLabel?.text = title2 as! String?
        print(strcreated)
        cell2.hideLabel.text = strcreated as! String?
        return cell2
    }
    //選択されたときに行う処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\((indexPath as! NSIndexPath).row)行目を選択")
        var cell2 = tableView.dequeueReusableCell(withIdentifier: "myCell",for: indexPath) as! myTableViewCell

        //Appdelegateにアクセスするための準備
        var myAp = UIApplication.shared.delegate as! AppDelegate
        myAp.myCount = cell2.hideLabel.text!
        print(cell2.hideLabel.text)
        print("あああああ\(myAp.myCount)")
        
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
