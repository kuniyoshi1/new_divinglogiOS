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
    @IBOutlet weak var logCount: UILabel!
var settitle3:[NSDictionary] = []
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTable.isEditing = false
               
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
        
        logCount.text = "合計LOG数 \(settitle.count)件"
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
        var cell2 = myTable.cellForRow(at: indexPath) as! myTableViewCell
        //Appdelegateにアクセスするための準備
        var myAp = UIApplication.shared.delegate as! AppDelegate
        myAp.myCount = cell2.hideLabel.text!
        myAp.test = (indexPath as! NSIndexPath).row
        print(cell2.hideLabel.text)
        print("あああああ\(myAp.myCount)")
        
         performSegue(withIdentifier: "secondSegue",sender: nil)
    }
    
    @IBAction func returenMenu(segue:UIStoryboardSegue){
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    @IBAction func editBtn(_ sender: UIButton) {
        if self.myTable.isEditing == true{
           self.myTable.isEditing = false
        }else{
            self.myTable.isEditing = true
        }
}
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if  (editingStyle == UITableViewCellEditingStyle.delete) {
    print("削除")
    // 先にデータを更新する
    self.settitle.remove(at: indexPath.row)
    // それからテーブルの更新
    tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        var cell2 = myTable.cellForRow(at: indexPath) as! myTableViewCell
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<Divinglog> = Divinglog.fetchRequest()
        // Entityを指定する設定
        let entityDiscription = NSEntityDescription.entity(forEntityName: "Divinglog", in: viewContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Divinglog")
        fetchRequest.entity = entityDiscription
        //Appdelegateにアクセスするための準備
        var myAp = UIApplication.shared.delegate as! AppDelegate
        myAp.myCount = cell2.hideLabel.text!
        var df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd hh:mm:ss "
        df.timeZone = TimeZone.current
        print(myAp.myCount)
        //保存していた日付を文字列からDate型に変換
        var savedDateTime:NSDate = df.date(from: "\(myAp.myCount)") as! NSDate
        print(savedDateTime)
        //検索条件として指定
        let predicate = NSPredicate(format: "SELF.created_at = %@", savedDateTime )
        query.predicate = predicate
        
        do {
            let fetchResults = try viewContext.fetch(query)
            print(fetchResults)
            for result: AnyObject in fetchResults {
                var dicTmp:NSMutableDictionary = NSMutableDictionary()
                dicTmp["title"] = result.value(forKey: "title") as! String
                dicTmp["weit"] = result.value(forKey: "weit") as! String
                dicTmp["wather"] = result.value(forKey: "wather") as! String
                dicTmp["utmp"] = result.value(forKey: "utmp") as! String
                dicTmp["tmp"] = result.value(forKey: "tmp") as! String
                dicTmp["suit"] = result.value(forKey: "suit") as! String
                dicTmp["stime"] = result.value(forKey: "stime") as! String
                dicTmp["ftime"] = result.value(forKey: "ftime") as! String
                dicTmp["spres"] = result.value(forKey: "spres") as! String
                dicTmp["fpres"] = result.value(forKey: "fpres") as! String
                dicTmp["point"] = result.value(forKey: "point") as! String
                dicTmp["memo"] = result.value(forKey: "memo") as! String
                dicTmp["memo2"] = result.value(forKey: "memo2") as! String
                dicTmp["depth"] = result.value(forKey: "depth") as! String
                dicTmp["mdepth"] = result.value(forKey: "mdepth") as! String
                dicTmp["created_at"] = result.value(forKey: "created_at") as! Date
                dicTmp["lat"] = result.value(forKey: "lat") as! Double
                dicTmp["long"] = result.value(forKey: "long") as! Double
                dicTmp["photoUrl"] = result.value(forKey: "photoUrl") as! String
                dicTmp["date"] = result.value(forKey: "date") as! String
                settitle3.append(dicTmp)
                // settitle3 as! NSManagedObject
                let record = result as! NSManagedObject
                viewContext.delete(record)
            }
             try viewContext.save()
        } catch {}
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
