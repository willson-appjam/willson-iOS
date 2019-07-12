//
//  AskerChatListViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

class AskerChatListViewController: UIViewController {
    
    // MARK: - properties
    let chatListTableViewCellIdentifier: String = "ChatListTableViewCell"
    
    // chatting
    var uid : String!
    var chatrooms : [ChatModel]! = []
    var destinationUsers : [String] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var chatListTableView: UITableView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tabBarController?.tabBar.isHidden = false
        
        chatListTableView.tableFooterView = UIView()
        chatListTableView.rowHeight = 92
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
    }
    
    // MARK: - Methods
    func getChatroomsList(){
        
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
            
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                self.chatrooms.removeAll()
                if let chatroomdic = item.value as? [String:AnyObject]{
                    let chatModel = ChatModel(JSON: chatroomdic)
                    self.chatrooms.append(chatModel!)
                }
            }
            self.chatListTableView.reloadData()
        })
    }
}

extension AskerChatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationUid = self.destinationUsers[indexPath.row]
        guard let viewController: HelperChatRoomViewController = UIStoryboard(name: "AskerChat", bundle: nil).instantiateViewController(withIdentifier: "AskerChatRoomViewController") as? HelperChatRoomViewController else { return }
        viewController.destinationUid = destinationUid
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension AskerChatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: chatListTableViewCellIdentifier, for: indexPath) as? ChatListTableViewCell else { return UITableViewCell() }
        
        var destinationUid :String?
        
        for item in chatrooms[indexPath.row].users{
            if(item.key != self.uid){
                destinationUid = item.key
                destinationUsers.append(destinationUid!)
            }
        }
        Database.database().reference().child("users").child(destinationUid!).observeSingleEvent(of: DataEventType.value, with: { (datasnapshot) in
            let userModel = UserModel()
            userModel.setValuesForKeys(datasnapshot.value as! [String:AnyObject])
            
            cell.textLabel?.text = userModel.userName
            
            let lastMessagekey = self.chatrooms[indexPath.row].comments.keys.sorted(){$0>$1}
            cell.detailLabel.text = self.chatrooms[indexPath.row].comments[lastMessagekey[0]]?.message
            let unixTime = self.chatrooms[indexPath.row].comments[lastMessagekey[0]]?.timestamp
            cell.timeLabel.text = unixTime?.toDayTime
        })
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0)
        return cell
    }
}
