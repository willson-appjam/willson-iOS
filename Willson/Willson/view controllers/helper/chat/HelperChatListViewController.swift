//
//  HelperChatListViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class HelperChatListViewController: UIViewController {
    
    // MARK: - properties
    let chatListTableViewCellIdentifier: String = "ChatListTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var chatListTableView: UITableView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.tableFooterView = UIView()
        chatListTableView.rowHeight = 92
    }
}

extension HelperChatListViewController: UITableViewDelegate {
    
}

extension HelperChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: chatListTableViewCellIdentifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        
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
    
    
}
