//
//  HelperChatListViewController.swift
//  Willson
//
//  Created by JHKim on 04/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import Firebase

class HelperChatListViewController: UIViewController {
    
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

        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.tableFooterView = UIView()
        chatListTableView.rowHeight = 92
        
        // chatting
        self.uid = Auth.auth().currentUser?.uid
        self.getChatroomsList()
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

extension HelperChatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let destinationUid = self.destinationUsers[indexPath.row]
        guard let viewController: HelperChatRoomViewController = UIStoryboard(name: "HelperChat", bundle: nil).instantiateViewController(withIdentifier: "HelperChatRoomViewController") as? HelperChatRoomViewController else { return }
        viewController.destinationUid = destinationUid
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension HelperChatListViewController: UITableViewDataSource {
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
            //            let url = URL(string:userModel.profileImageUrl!)
            
            //            cell.imageview.layer.cornerRadius = cell.imageview.frame.width/2
            //            cell.imageview.layer.masksToBounds = true
            //            cell.imageview.kf.setImage(with: url)
            
            
            let lastMessagekey = self.chatrooms[indexPath.row].comments.keys.sorted(){$0>$1}
            cell.detailLabel.text = self.chatrooms[indexPath.row].comments[lastMessagekey[0]]?.message
            let unixTime = self.chatrooms[indexPath.row].comments[lastMessagekey[0]]?.timestamp
            cell.timeLabel.text = unixTime?.toDayTime
        })
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    
}
