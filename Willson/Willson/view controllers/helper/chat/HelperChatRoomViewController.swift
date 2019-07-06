//
//  HelperChatRoomViewController.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperChatRoomViewController: UIViewController {

    let chatTableViewCellIdentifier: String = "ChatTableViewCell"
    
    @IBOutlet weak var chatRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "리트리버" + " 님"
        
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        chatRoomTableView.tableHeaderView = UIView()
        chatRoomTableView.rowHeight = 40
    }
    
    
}

extension HelperChatRoomViewController: UITableViewDelegate {
    
}

extension HelperChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: chatTableViewCellIdentifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.helperProfileImageView.image = UIImage(named: "helperChatImgProfileWoman")
            cell.helperNameLabel.text = "리트리버 님"
            cell.detailLabel.text = "새로운 톡방이 개설되었습니다"
        case 1:
            cell.helperProfileImageView.image = UIImage(named: "helperChatImgProfileMan")
            cell.helperNameLabel.text = "푸들 님"
            cell.detailLabel.text = "새로운 톡방이 개설되었습니다"
        default:
            return cell
        }
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "ChatHeaderTableViewCell") as! ChatHeaderTableViewCell
        
        
        switch (section) {
        case 0:
            headerCell.notificationTitle.text = "상담 대기 안내";
            headerCell.notificationContent.text = "질문자(답변자) 10분 이내 미 접속 시 대화 자동 종료 및 재매칭됩니다.";
            //return sectionHeaderView
            
            return headerCell
        default:
            <#code#>
        }
    }
}
