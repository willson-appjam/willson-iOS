//
//  AskerChatListViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class AskerChatListViewController: UIViewController {
    
    // MARK: - properties
    let chatListTableViewCellIdentifier: String = "ChatListTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var chatListTableView: UITableView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UITableView delegate, dataSource
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.tableFooterView = UIView()
        chatListTableView.rowHeight = 92
    }
}

extension AskerChatListViewController: UITableViewDelegate {
    
}

extension AskerChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: chatListTableViewCellIdentifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    
}
