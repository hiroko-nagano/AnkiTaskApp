//
//  AddViewController.swift
//  ankiTaskApp
//
//  Created by hiroko nagano on 2020/08/30.
//  Copyright © 2020 hiroko.nagano. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startPage: UITextField!
    @IBOutlet weak var lastPage: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var studyUISwich: UISwitch!
    
    let realm = try! Realm()
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景をタップしたらdismisskkeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        startPage.text = task.startpage
        lastPage.text = task.lastpage
        memoTextView.text  = task.memo
        studyUISwich.isOn = task.swich
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.startpage = self.startPage.text!
            self.task.lastpage = self.lastPage.text!
            self.task.memo = self.memoTextView.text!
            
            if self.studyUISwich.isOn  {
                self.task.swich = true
            } else {
                self.task.swich = false
            }
                    
            self.realm.add(self.task, update: .modified)
        }
        super.viewWillDisappear(animated)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        if let titleText = titleTextField.text {
            if titleText.isEmpty {
                print("タイトルなし")
                return
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
