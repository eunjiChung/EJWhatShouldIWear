//
//  NoticeViewController.swift
//  EJWhatShouldIWear
//
//  Created by eunji on 21/10/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NoticeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Instances
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier = "NoticeViewController"
    var ref = Database.database().reference()
    var noticeData = [[String: Any]]()
    var selectedIndexPath: NSIndexPath!
    var cellData = [Bool]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNoticeDB()
    }
    
    // MARK: - Database
    func getNoticeDB() {
        
        self.ref.child("notices").queryOrdered(byChild: "timeRelease").observeSingleEvent(of: .value) { (datasnapshot) in
            for item in datasnapshot.children.allObjects as! [DataSnapshot] {
                let notice = item.value as! [String: Any]
                self.noticeData.append(notice)
            }
            
            self.noticeData.reverse()   // 최신순으로 하기 위해 reverse해줌
            
            for _ in self.noticeData {
                self.cellData.append(false)
            }
            
            self.tableView.reloadData()
        }
    }
    

    @IBAction func didTouchInsert(_ sender: Any) {
        
        // TODO: - 공지사항 추가할 경우 이 부분을 Showing한다
        let noticeValue: [String: Any] = [
            "title": "setting_notice",
            "detail": """
             2.0.1 버전 업데이트 사항
            
             - 공지사항 추가
             
             * 맨 처음 화면에 나오는 옷들은 그날 입을 옷을 종합적으로 추천드립니다 :)
            """,
            "timestamp": ServerValue.timestamp()
            ]
        
        self.ref.child("notices").child("notice").setValue(noticeValue) { (error, reference) in
            print("count 1")
        }
        
    }
    
    
    // MARK: - View Control
    @IBAction func didTouchBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.noticeData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellData[section] == true {
            return 2
        }

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTitleTableViewCell.identifier, for: indexPath) as! NoticeTitleTableViewCell
            
            let notice = self.noticeData[indexPath.section]
            let noticeStr = notice["title"] as! String
            cell.textLabel?.text = LocalizedString(with: noticeStr)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoticeDetailTableViewCell.identifier, for: indexPath) as! NoticeDetailTableViewCell
            
            let notice = self.noticeData[indexPath.section]
            cell.detailLabel.text = notice["detail"] as? String
            
            return cell
        }
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Library.selectionHapticFeedback()
        
        if cellData[indexPath.section] == true {
            cellData[indexPath.section] = false
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .top)
            tableView.endUpdates()
        } else {
            cellData[indexPath.section] = true
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .top)
            tableView.endUpdates()
        }
    }

}
