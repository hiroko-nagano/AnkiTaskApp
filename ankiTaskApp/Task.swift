//
//  Task.swift
//  ankiTaskApp
//
//  Created by hiroko nagano on 2020/08/30.
//  Copyright © 2020 hiroko.nagano. All rights reserved.
//

import RealmSwift

class Task: Object {
    //管理用ID.プライマリーキー
    @objc dynamic var id = 0
    //タイトル
    @objc dynamic var title = ""
    //開始ページ
    @objc dynamic var startpage = ""
    //最後のページ
    @objc dynamic var lastpage = ""
    //メモ
    @objc dynamic var memo = ""
    //日付
    @objc dynamic var date = ""
    //スイッチオンオフ
    @objc dynamic var swich: Bool = true
    //明日
    @objc dynamic var date2 = ""
    //来週
    @objc dynamic var date3 = ""
    //来月
    @objc dynamic var date4 = ""
    //３ヶ月後
    @objc dynamic var date5 = ""
    //終了ボタン
    @objc dynamic var finishbutton: Bool = true
    
    
    
    //id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
