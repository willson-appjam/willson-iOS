//
//  AskerChatRoomViewController.swift
//  Willson
//
//  Created by 박지수 on 07/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import Toast_Swift

class AskerChatRoomViewController: UIViewController {

    // MARK: - properties
    let chatTableViewCellIdentifier: String = "ChatTableViewCell"
    var isTextFieldActive = false
    
    var timer = Timer()
    var count = 3600
    var completionHandlers: [() -> Void] = []
    
    // chatting
    var uid : String?
    var roomKey : String?
    
    public var destinationUid :String? // 나중에 내가 채팅할 대상의 uid
    
    var comments : [ChatModel.Comment] = []
    var destinationUserModel: UserModel?
    var askerUserModel: UserModel?
    
    var databaseRef : DatabaseReference?
    var observe : UInt?
    var peopleCount : Int?
    
    var messageArray = ["안녕하세요, 솝트님", "요즘 하고 계시는 고민이 취업 쪽이시던데 어떤가요?", "안녕하세요!", "요즘 고민이 많아요ㅠㅠㅠ", "구체적으로 상황 설명 부탁드려요"]
    var timeArray = ["PM 07:11", "PM 07:11", "PM 07:12", "PM 07:13", "PM 07:15"]
    var userArray = [0, 0, 1, 1, 0]
    
    // MARK: - IBOutlet
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var chatRoomTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var timeButton: UIBarButtonItem!
    
    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "리트리버" + " 님"
        
        textField.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped(_:)))
        view.addGestureRecognizer(tap)
        
        self.chatRoomTableView.register(UINib(nibName: ChatHeaderTVC.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ChatHeaderTVC.reuseIdentifier)
        
        // chatting
//        uid = Auth.auth().currentUser?.uid
        
//        createRoom()
        
        // UITableView delegate, dataSource
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeLimit), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        // UITableView delegate, dataSource
//        chatRoomTableView.delegate = self
//        chatRoomTableView.dataSource = self
        
//        checkChatRoom()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        databaseRef?.removeObserver(withHandle: observe ?? 0)
    }
    
    // MARK: - IBAction
    @IBAction func sendMessageAction(_ sender: Any) {
        if !self.textField.hasText {
            // toast message
            self.view.makeToast("내용을 입력해주세요.", duration: 3.0, position: .bottom)
            textField.resignFirstResponder()
        }else {
            /*
            let value :Dictionary<String,Any> = [
                "uid" : uid!,
                "message" : textField.text!,
                "timestamp" : ServerValue.timestamp()
            ]
            Database.database().reference().child("chatRooms").child(roomKey ?? "").child("comments").childByAutoId().setValue(value, withCompletionBlock: { (err, ref) in
                self.textField.text = ""
            })
 */
            messageArray.append(textField.text!)
            timeArray.append("PM 07:52")
            userArray.append(1)
            
            let indexPath = IndexPath(row: self.messageArray.count-1, section:0)
            self.chatRoomTableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
            self.textField.text = ""
            scrollToBottomOfChat()
        }
    }
    
    // MARK: - Methods
    @objc func timeLimit() {
        let dateFormatter = DateFormatter()
        
        if count > 0 {
            count -= 1
            timeButton.title = "\(count/60):\(count%60)"
            dateFormatter.dateFormat = "mm:ss"
            
            let formattime = dateFormatter.date(from:timeButton.title!)
            timeButton.title = dateFormatter.string(from: formattime!)
            
        } else {
            timeLimitStop()
        }
    }
    
    func timeLimitStop() {
        timer.invalidate()
        
    }
    
    func scrollToBottomOfChat(){
        let indexPath = IndexPath(row: self.messageArray.count - 1, section: 0)
        
        chatRoomTableView.scrollToRow(at: indexPath, at: .none, animated: false)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let tabbarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        
        let keyboardHeight: CGFloat = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.textFieldViewBottom.constant = -keyboardHeight + tabbarHeight
        })
        self.view.layoutIfNeeded()
        /*
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
 */
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.textFieldViewBottom.constant = 0
        })
        
        self.view.layoutIfNeeded()
        /*
        self.textFieldViewBottom.constant = 0
        self.view.layoutIfNeeded()
 */
    }
    
    func createRoom(){
        
        Database.database().reference().child("chatRooms").queryOrderedByKey().queryEqual(toValue: roomKey).observeSingleEvent(of: DataEventType.value, with: { (dataSnapshot) in
            if dataSnapshot.value == nil {
                let createRoomInfo : Dictionary<String,Any> = [ "users" : [
                    self.uid!: true,
                    self.destinationUid! :true
                    ]
                ]
                Database.database().reference().child("chatRooms").child(self.roomKey ?? "").setValue(createRoomInfo) { (error: Error?, ref: DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                    } else {
                        self.checkChatRoom()
                        print("Data saved successfully!")
                    }
                }
                return
            }
            
        })
    }
    
    func checkChatRoom(){
        
        Database.database().reference().child("chatRooms").queryOrderedByKey().queryEqual(toValue: roomKey).observeSingleEvent(of: DataEventType.value,with: { (datasnapshot) in
            guard let allObjects = datasnapshot.children.allObjects as? [DataSnapshot] else { return }
            for item in allObjects {
                
                if let chatRoomdic = item.value as? [String:AnyObject]{
                    
                    let chatModel = ChatModel(JSON: chatRoomdic)
                    if(chatModel?.users[self.destinationUid ?? ""] == true){
                        self.getDestinationInfo()
                    }
                }
            }
        })
    }
    
    func getDestinationInfo(){
        Database.database().reference().child("users").child(self.destinationUid!).observeSingleEvent(of: DataEventType.value, with: { (datasnapshot) in
            self.destinationUserModel = UserModel()
            self.destinationUserModel?.setValuesForKeys(datasnapshot.value as? [String:Any] ?? [String:Any]())
            self.getMessageList()
            
        })
    }
    
    func getUserData() {
        Database.database().reference(withPath: "users").child(uid ?? "").observeSingleEvent(of: DataEventType.value, with: { dataSnapshot in
            self.askerUserModel = UserModel()
            self.askerUserModel?.setValuesForKeys(dataSnapshot.value as? [String:Any] ?? [String:Any]())
            
        })
        
        Database.database().reference(withPath: "willsonUsers").child(destinationUid ?? "").observeSingleEvent(of: DataEventType.value, with: { dataSnapshot in
            self.destinationUserModel = UserModel()
            self.destinationUserModel?.setValuesForKeys(dataSnapshot.value as? [String:Any] ?? [String:Any]())
            
        })
    }
    
    func makeUserData() {
        let willProfile: Dictionary<String, String> = [
            "uid" : self.uid ?? "",
            "nickName" : self.destinationUserModel?.userName ?? ""
        ]
        let askerProfile: Dictionary<String, String> = [
            "uid" : self.uid ?? "",
            "nickName" : self.askerUserModel?.userName ?? ""
        ]
        
        Database.database().reference().child("chatRooms").child(roomKey ?? "").child("willsonUser").setValue(willProfile)
        Database.database().reference().child("chatRooms").child(roomKey ?? "").child("askerUser").setValue(askerProfile)
    }
    
    func setRoomkey(willsonUser: String, askerUser: String, roomKey: String) {
        let setRoomkey: Dictionary<String, Any> = [
            "roomKey" : roomKey
        ]
        
        Database.database().reference(withPath: "willsonUsers").child(willsonUser).updateChildValues(setRoomkey)
        Database.database().reference(withPath: "users").child(askerUser).updateChildValues(setRoomkey)
    }
    
    func getMessageList(){
        databaseRef = Database.database().reference().child("chatrooms").child(self.roomKey ?? "").child("comments")
        observe = databaseRef?.observe(DataEventType.value, with: { (datasnapshot) in
            self.comments.removeAll()
            var readUserDic : Dictionary<String,AnyObject> = [:]
            guard let allObject = datasnapshot.children.allObjects as? [DataSnapshot] else { return }
            for item in allObject {
                let key = item.key as String
                let comment = ChatModel.Comment(JSON: item.value as! [String:AnyObject])
                let comment_motify = ChatModel.Comment(JSON: item.value as! [String:AnyObject])
                comment_motify?.readUsers[self.uid!] = true
                readUserDic[key] = comment_motify?.toJSON() as NSDictionary?
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
extension AskerChatRoomViewController: UITableViewDelegate {
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
extension AskerChatRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return comments.count
        return messageArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: chatTableViewCellIdentifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
        
//        if self.comments[indexPath.row].uid == uid {
        if userArray[indexPath.item] == 0 {
            if(indexPath.item != 0) {
                if(indexPath.item - 1 == 0) {
                    cell.profileImg.isHidden = true
                }
            } else {
                cell.profileImg.isHidden = false
            }
            
            cell.ownText.isHidden = true
            cell.ownView.isHidden = true
            cell.ownTime.isHidden = true
            cell.oppoText.isHidden = false
            cell.oppoView.isHidden = false
            cell.oppoTime.isHidden = false
            //상대방
            /*
            cell.oppoText.text = self.comments[indexPath.row].message
            if let time = self.comments[indexPath.row].timestamp {
                cell.oppoTime.text = time.toDayTime
            }
 */
            cell.oppoText.text = messageArray[indexPath.item]
            cell.oppoTime.text = timeArray[indexPath.item]
            
        } else {
            cell.profileImg.isHidden = true
            cell.ownText.isHidden = false
            cell.ownView.isHidden = false
            cell.ownTime.isHidden = false
            cell.oppoText.isHidden = true
            cell.oppoView.isHidden = true
            cell.oppoTime.isHidden = true
            //자신
            /*
            cell.ownText.text = self.comments[indexPath.row].message
            if let time = self.comments[indexPath.row].timestamp {
                cell.ownTime.text = time.toDayTime
            }
 */
            cell.ownText.text = messageArray[indexPath.item]
            cell.ownTime.text = timeArray[indexPath.item]
        }
        
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }
    
    /*
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
 */
    /*
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView: ChatHeaderTVC = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatHeaderTVC.reuseIdentifier) as? ChatHeaderTVC else { return }
        
        headerView.clipsToBounds = true
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 138
    }
 */
}

// MARK: - UITextFieldDelegate
extension AskerChatRoomViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isTextFieldActive = true
//        keyboardWillShow()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isTextFieldActive = false
    }
    
    //빈 화면 탭했을 때 키보드 내리기
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

