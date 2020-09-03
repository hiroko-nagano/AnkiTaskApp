//
//  ViewController.swift
//  ankiTaskApp
//
//  Created by hiroko nagano on 2020/08/30.
//  Copyright © 2020 hiroko.nagano. All rights reserved.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance  {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
    var topeddate = ""
    var topeddate2 = ""
    var topeddate3 = ""
    var topeddate4 = ""
    var topeddate5 = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calendar.select(Date())
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        topeddate = "\(year)/\(month)/\(day)"
        
        let tomorrow = Date(timeInterval: 60*60*24 , since: date)
        let year2 = tmpDate.component(.year, from: tomorrow)
        let month2 = tmpDate.component(.month, from: tomorrow)
        let day2 = tmpDate.component(.day, from: tomorrow)
        topeddate2 = "\(year2)/\(month2)/\(day2)"
        
        let nextweek = Date(timeInterval: 60*60*24*7, since: date)
        let year3 = tmpDate.component(.year, from: nextweek)
        let month3 = tmpDate.component(.month, from: nextweek)
        let day3 = tmpDate.component(.day, from: nextweek)
        topeddate3 = "\(year3)/\(month3)/\(day3)"
        
        let nextmonth = Date(timeInterval: 60*60*24*7*4, since: date)
        let year4 = tmpDate.component(.year, from: nextmonth)
        let month4 = tmpDate.component(.month, from: nextmonth)
        let day4 = tmpDate.component(.day, from: nextmonth)
        topeddate4 = "\(year4)/\(month4)/\(day4)"
        
        let threemonth = Date(timeInterval: 60*60*24*7*4*4, since: date)
        let year5 = tmpDate.component(.year, from: threemonth)
        let month5 = tmpDate.component(.month, from: threemonth)
        let day5 = tmpDate.component(.day, from: threemonth)
        topeddate5 = "\(year5)/\(month5)/\(day5)"
        
        let listViewController:ListViewController = self.storyboard?.instantiateViewController(identifier: "List") as! ListViewController
        listViewController.receiveddate = topeddate
        listViewController.receiveddate2 = topeddate2
        listViewController.receiveddate3 = topeddate3
        listViewController.receiveddate4 = topeddate4
        listViewController.receiveddate5 = topeddate5
        self.navigationController?.pushViewController(listViewController, animated: true)
    }
    
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    let listViewController:ListViewController = segue.destination as! ListViewController
     //   if segue.identifier == "editSegue" {
            
      //  }
   // }
    
    
    
    
    
}

