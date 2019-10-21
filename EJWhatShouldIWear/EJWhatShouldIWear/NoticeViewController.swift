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
    var count = 0
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
        
        let noticeValue: [String: Any] = [
            "title": "공지사항 \(count+1)",
            "detail": "돌이켜보면 결코 되돌릴 수 없는 것들을 붙잡고 되돌려지지 않는다는 사실 앞에 늘 너무 오랫동안 분개했던 것 같다. 특히 인간관계가 그랬다. 거기에는 어떤 오해나 실수가 있더라도 어찌됐든 돌이킬 수 있어야만 진짜 우정이고 진짜 사랑이라는 생각이 있었다. 그러나 진짜 사랑과 진짜 우정이란 진짜와 가짜를 나누는 서로 다른 논리들 앞에서 유명무실해진다. 사실 언제든 돌이킬 수 있다는 믿음은 최선을 다해 노력하지 않게 하고 결과적으로 사람을 좀 비겁하게 만든다. 이제와서 생각해보니 최소한 내가 실패한 관계들은 대개 그랬던 것 같다. 결국, 우리는 모두 순순히 누군가의 과거가 될 용기가 필요하다. ",
            "timestamp": ServerValue.timestamp()
            ]
        
        self.ref.child("notices").child("notice\(count+1)").setValue(noticeValue) { (error, reference) in
            self.count += 1
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
            cell.textLabel?.text = notice["title"] as? String
            
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
