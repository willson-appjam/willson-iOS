//
//  HelperChatRoomViewController.swift
//  Willson
//
//  Created by 박지수 on 06/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Alamofire

class HelperChatRoomViewController: UIViewController {

    // MARK: - properties
    // UITableViewCell Identifier
    let chatTableViewCellIdentifier: String = "ChatTableViewCell"
    let chatHeaderTableViewCellIdentifier: String = "ChatHeaderTVC"
    
    // chatting
    var uid : String?
    var chatRoomUid : String?
    
    public var destinationUid :String? // 나중에 내가 채팅할 대상의 uid
    
    var comments : [ChatModel.Comment] = []
    var destinationUserModel :UserModel?
    
    var databaseRef : DatabaseReference?
    var observe : UInt?
    var peopleCount : Int?
    
    
    //var isKeyboardAppear = false
    var isTextFieldActive = false
    
//    var messageArray = ["안녕하세유-", "리트리버님?", "반가워용", "^^"]
//    var timeArray = ["PM 07:11", "PM 07:11", "PM 07:12", "PM 07:13"]
//    var userArray = [0, 0, 1, 1]
    
    // MARK: - IBOutlet
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var chatRoomTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldViewBottom: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "리트리버" + " 님"
        
        textField.delegate = self
        
        // 빈 화면 탭 하면 키보드 내리기
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(tap)
        
        self.chatRoomTableView.register(UINib(nibName: ChatHeaderTVC.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ChatHeaderTVC.reuseIdentifier)
        
        // chatting
        uid = Auth.auth().currentUser?.uid
        
        createRoom()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // UITableView delegate, dataSource
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        // chatting
        checkChatRoom()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        databaseRef?.removeObserver(withHandle: observe!)
    }
    
    // MARK: - IBAction
    @IBAction func sendMessageAction(_ sender: Any) {
//        messageArray.append(textField.text!)
//        timeArray.append("PM 07:13")
//        userArray.append(1)
        /*
        let indexPath = IndexPath(row: self.messageArray.count-1, section:0)
        self.chatRoomTableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
         */
    }
    
    // MARK: - Methods
    @objc func keyboardWillShow(notification: NSNotification) {
        /*
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight: CGFloat = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.textFieldViewBottom.constant = -keyboardHeight
        })
        self.view.layoutIfNeeded()
         */
        
        if let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            self.textFieldViewBottom.constant = keyboardSize.height
        }
        
        UIView.animate(withDuration: 0, animations: {
            self.view.layoutIfNeeded()
        }, completion: {
            (complete) in
            
            if self.comments.count > 0{
                self.chatRoomTableView.scrollToRow(at: IndexPath(item:self.comments.count - 1,section:0), at: UITableView.ScrollPosition.bottom, animated: true)
            }
        })
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        /*
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.textFieldViewBottom.constant = 0
        })
        */
        
        self.textFieldViewBottom.constant = 0
        self.view.layoutIfNeeded()

    }
    
    func createRoom(){
        let createRoomInfo : Dictionary<String,Any> = [ "users" : [
            uid!: true,
            destinationUid! :true
            ]
        ]
        
        
        if(chatRoomUid == nil){
            self.sendButton.isEnabled = false
            // 방 생성 코드
            Database.database().reference().child("chatrooms").childByAutoId().setValue(createRoomInfo, withCompletionBlock: { (err, ref) in
                if(err == nil){
                    self.checkChatRoom()
                }
            })
            
        }else{
            let value :Dictionary<String,Any> = [
                
                "uid" : uid!,
                "message" : textField.text!,
                "timestamp" : ServerValue.timestamp()
            ]
            
            Database.database().reference().child("chatrooms").child(chatRoomUid!).child("comments").childByAutoId().setValue(value, withCompletionBlock: { (err, ref) in
//                self.sendGcm()
                self.textField.text = ""
            })
        }
    }
    
    func checkChatRoom(){
        
        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value,with: { (datasnapshot) in
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                
                if let chatRoomdic = item.value as? [String:AnyObject]{
                    
                    let chatModel = ChatModel(JSON: chatRoomdic)
                    if(chatModel?.users[self.destinationUid!] == true){
                        self.chatRoomUid = item.key
                        self.sendButton.isEnabled = true
                        self.getDestinationInfo()
                    }
                }
            }
        })
    }
    
    func getDestinationInfo(){
        
        Database.database().reference().child("users").child(self.destinationUid!).observeSingleEvent(of: DataEventType.value, with: { (datasnapshot) in
            self.destinationUserModel = UserModel()
            self.destinationUserModel?.setValuesForKeys(datasnapshot.value as! [String:Any])
            self.getMessageList()
            
        })
    }
    
    func getMessageList(){
        databaseRef = Database.database().reference().child("chatrooms").child(self.chatRoomUid!).child("comments")
        observe = databaseRef?.observe(DataEventType.value, with: { (datasnapshot) in
            self.comments.removeAll()
            var readUserDic : Dictionary<String,AnyObject> = [:]
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                let key = item.key as String
                let comment = ChatModel.Comment(JSON: item.value as! [String:AnyObject])
                let comment_motify = ChatModel.Comment(JSON: item.value as! [String:AnyObject])
                comment_motify?.readUsers[self.uid!] = true
                readUserDic[key] = comment_motify?.toJSON() as! NSDictionary
                self.comments.append(comment!)
            }
            
            let nsDic = readUserDic as NSDictionary
            if(!(self.comments.last?.readUsers.keys.contains(self.uid!))!){
                
                
                datasnapshot.ref.updateChildValues(nsDic as! [AnyHashable : Any], withCompletionBlock: { (err, ref) in
                    
                    self.chatRoomTableView.reloadData()
                    
                    if self.comments.count > 0{
                        self.chatRoomTableView.scrollToRow(at: IndexPath(item:self.comments.count - 1,section:0), at: UITableView.ScrollPosition.bottom, animated: true)
                        
                    }
                    
                })
            }else{
                self.chatRoomTableView.reloadData()
                
                if self.comments.count > 0{
                    self.chatRoomTableView.scrollToRow(at: IndexPath(item:self.comments.count - 1,section:0), at: UITableView.ScrollPosition.bottom, animated: true)
                    
                }
            }
            
            
            
            
            
        })
        
    }

}

// MARK: - UITableViewDelegate
extension HelperChatRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
}

// MARK: - UITableViewDataSource
extension HelperChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: chatTableViewCellIdentifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        
        
        if self.comments[indexPath.row].uid == uid {
            if(indexPath.item != 0) {
                if(indexPath.item - 1 == 0) {
                    cell.profileImg.isHidden = true
                }
            }
            
            cell.ownText.isHidden = true
            cell.ownView.isHidden = true
            cell.ownTime.isHidden = true
            //상대방
            cell.oppoText.text = self.comments[indexPath.row].message
            if let time = self.comments[indexPath.row].timestamp {
                cell.oppoTime.text = time.toDayTime
            }
            
//            setReadCount(label: view.label_read_counter, position: indexPath.row)
        } else {
            cell.profileImg.isHidden = true
            cell.oppoText.isHidden = true
            cell.oppoView.isHidden = true
            cell.oppoTime.isHidden = true
            //자신
            cell.ownText.text = self.comments[indexPath.row].message
            if let time = self.comments[indexPath.row].timestamp {
                cell.ownTime.text = time.toDayTime
            }
        }
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        return cell
 
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView: ChatHeaderTVC = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatHeaderTVC.reuseIdentifier) as? ChatHeaderTVC else { return UIView() }
        if let titleLabel = headerView.notificationTitle {
            titleLabel.text = "상담 대기 안내"
        }
        if let contentLabel = headerView.notificationContent {
            contentLabel.text = "질문자(답변자) 10분 이내 미 접속 시 대화 자동 종료 및 재매칭됩니다."
        }
        
        return headerView
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView: ChatHeaderTVC = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatHeaderTVC.reuseIdentifier) as? ChatHeaderTVC else { return }
        
        headerView.clipsToBounds = true
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 138
    }
    
   
}

// MARK: UITextFieldDelegate
extension HelperChatRoomViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isTextFieldActive = true
        //keyboardWillShow()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isTextFieldActive = false
    }
    
    //빈 화면 탭했을 때 키보드 내리기
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension Int{
    
    var toDayTime :String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        return dateFormatter.string(from: date)
        
    }
    
}
