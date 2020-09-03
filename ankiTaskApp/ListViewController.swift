//
//  ListViewController.swift
//  ankiTaskApp
//
//  Created by hiroko nagano on 2020/08/30.
//  Copyright © 2020 hiroko.nagano. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift
import SVProgressHUD

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var task: Task!
    var addButtonItem: UIBarButtonItem!
    var receiveddate : String?
    var receiveddate2 : String?
    var receiveddate3 : String?
    var receiveddate4 : String?
    var receiveddate5 : String?
    
    let realm = try! Realm()
    var taskArray = try! Realm().objects(Task.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.dateLabel.text = receiveddate
        
        let nib = UINib(nibName: "ListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        let predicate = NSPredicate(format: "date = %@", receiveddate!)
        taskArray = realm.objects(Task.self).filter(predicate)
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTopped(_:)))
        self.navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    
    @objc func addButtonTopped(_ sender: UIBarButtonItem) {
        let addViewController  = self.storyboard?.instantiateViewController(identifier: "Add") as! AddViewController
        let task = Task()
        let allTasks = realm.objects(Task.self)
        if allTasks.count != 0 {
            task.id = allTasks.max(ofProperty: "id")! + 1
        } else if allTasks.count == 0 {
            task.id = 0
        }
        
        task.date = receiveddate!
        task.date2 = receiveddate2!
        task.date3 = receiveddate3!
        task.date4 = receiveddate4!
        task.date5 = receiveddate5!
        task.finishbutton = true
        
        addViewController.task = task
        self.navigationController?.pushViewController(addViewController, animated: true)
    }
    
    //データの数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    //各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        //セルに値を設定する
        cell.setTaskArray(taskArray[indexPath.row])
        //セル内のボタンのアクション
        cell.finishButton.addTarget(self, action: #selector(tapfinishButton(_:forEvent:)), for: .touchUpInside)
        return cell
    }
    
    @objc func tapfinishButton(_ sender: UIButton, forEvent event: UIEvent) {
        
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        let listDate = taskArray[indexPath!.row]
        
        if listDate.finishbutton == false {
            sender.isEnabled = true
        } else {
            
            if listDate.swich == true {
                try! realm.write {
                    listDate.swich = false
                    
                    let task2 = Task()
                    let allTasks = realm.objects(Task.self)
                    task2.id = allTasks.max(ofProperty: "id")! + 1
                    task2.title = "\(listDate.title) \("(復習)")"
                    task2.startpage = "\(listDate.startpage)"
                    task2.lastpage = "\(listDate.lastpage)"
                    task2.memo = "\(listDate.memo)"
                    task2.swich = false
                    task2.date = "\(listDate.date2)"
                    task2.finishbutton = true
                    realm.add(task2, update: .modified)
                    
                    let task3 = Task()
                    task3.id = allTasks.max(ofProperty: "id")! + 2
                    task3.title = "\(listDate.title) \("(復習)")"
                    task3.startpage = "\(listDate.startpage)"
                    task3.lastpage = "\(listDate.lastpage)"
                    task3.memo = "\(listDate.memo)"
                    task3.swich = false
                    task3.date = "\(listDate.date3)"
                    task3.finishbutton = true
                    realm.add(task3, update: .modified)
                    
                    let task4 = Task()
                    task4.id = allTasks.max(ofProperty: "id")! + 3
                    task4.title = "\(listDate.title) \("(復習)")"
                    task4.startpage = "\(listDate.startpage)"
                    task4.lastpage = "\(listDate.lastpage)"
                    task4.memo = "\(listDate.memo)"
                    task4.swich = false
                    task4.date = "\(listDate.date4)"
                    task4.finishbutton = true
                    realm.add(task4, update: .modified)
                    
                    let task5 = Task()
                    task5.id = allTasks.max(ofProperty: "id")! + 4
                    task5.title = "\(listDate.title) \("(復習)")"
                    task5.startpage = "\(listDate.startpage)"
                    task5.lastpage = "\(listDate.lastpage)"
                    task5.memo = "\(listDate.memo)"
                    task5.swich = false
                    task5.date = "\(listDate.date5)"
                    task5.finishbutton = true
                    realm.add(task5, update: .modified)
                    
                    listDate.finishbutton = false
                    SVProgressHUD.showSuccess(withStatus: "復習が追加されました")
                    SVProgressHUD.dismiss(withDelay: 2)
                    
                }
                
            } else {
                try! realm.write{
                    listDate.finishbutton = false
                }
            }
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addViewController:AddViewController = segue.destination as! AddViewController
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            addViewController.task = taskArray[indexPath!.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
    }
    
    //セルが削除可能である
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath : IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Deleteボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            try! realm.write {
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
