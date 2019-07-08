//
//  AskerLoginViewController.swift
//  Willson
//
//  Created by 박지수 on 29/06/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import KakaoOpenSDK

class AskerLoginViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var kakaotalkBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconTF()
    }
    
    func viewWillApear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAccessToken() //sns 로그인
    }
    
    // MARK: - IBAction
    
    // 일반 로그인
    @IBAction func tappedLoginButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AskerTabbar")
        self.present(viewController, animated: true)
//        self.navigationController?.show(viewController, sender: nil)
    }
    
    // 페이스북 로그인
    @IBAction func facebookBtnAction(_ sender: Any) {
        var getEmail = ""
        let fbLoginManager : LoginManager = LoginManager()

        fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
            
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((AccessToken.current) != nil){
                            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    let dict: NSDictionary = result as! NSDictionary
                                    if let token = AccessToken.current?.tokenString {
                                        print("tocken: \(token)")
                                        
                                        let userDefult = UserDefaults.standard
                                        userDefult.setValue(token, forKey: "access_tocken")
                                        userDefult.synchronize()
                                    }
                                    if let user : NSString = dict.object(forKey:"name") as! NSString? {
                                        print("user: \(user)")
                                    }
                                    if let id : NSString = dict.object(forKey:"id") as? NSString {
                                        print("id: \(id)")
                                    }
                                    if let email : NSString = (result! as AnyObject).value(forKey: "email") as? NSString {
                                        print("email: \(email)")
                                        getEmail = email as String
                                    }
                                    
                                    
                                    //회원정보가 서버에 존재하지 않을 경우 회원가입 창으로 이동(데이터로 이메일 정보 전송)
                                    let dvc = UIStoryboard(name: "AskerSignUp", bundle: nil).instantiateViewController(withIdentifier: "AskerSNSSignUpViewController") as! AskerSNSSignUpViewController
                                    
                                    dvc.snsEmail = getEmail
                                    self.present(dvc, animated: true, completion: nil)
                                }
                            })
                        }
                    }
                }
            }
        }

    }
    
    @IBAction func kakaotalkBtnAction(_ sender: Any) {
        var getEmail = ""
        if KOSession.shared().isOpen() { KOSession.shared().close() }
        KOSession.shared().presentingViewController = self
        
        func profile(_ error: Error?, user: KOUserMe?) {
            guard let user = user,
                error == nil else { return }
            
            guard let token = user.id else { return }
            let name = user.nickname ?? ""
            
            if let gender = user.account?.gender {
                if gender == KOUserGender.male {
                    print("male")
                } else if gender == KOUserGender.female {
                    print("female")
                }
            }
            
            let email = user.account?.email ?? ""
            let profile = user.profileImageURL?.absoluteString ?? ""
            let thumbnail = user.thumbnailImageURL?.absoluteString ?? ""
            
            print(token)
            print(name)
            print(email)
            print(profile)
            print(thumbnail)
            getEmail = email
        }
        
        KOSession.shared().open(completionHandler: { (error) in
            if error != nil || !KOSession.shared().isOpen() { return }
            KOSessionTask.userMeTask(completion: { (error, user) in
                if let account = user?.account {
                    var updateScopes = [String]()
                    if account.emailNeedsAgreement {
                        updateScopes.append("account_email")
                    }
                    
                    if account.genderNeedsAgreement {
                        updateScopes.append("gender")
                    }
                    
                    if account.genderNeedsAgreement {
                        updateScopes.append("birthday")
                    }
                    KOSession.shared()?.updateScopes(updateScopes, completionHandler: { (error) in
                        guard error == nil else {
                            return
                        }
                        KOSessionTask.userMeTask(completion: { (error, user) in
                            profile(error, user: user)
                            
                            let dvc = UIStoryboard(name: "AskerSignUp", bundle: nil).instantiateViewController(withIdentifier: "AskerSNSSignUpViewController") as! AskerSNSSignUpViewController
                            
                            
                            dvc.snsEmail = getEmail
                            self.present(dvc, animated: true, completion: nil)
                        })
                    })
                } else {
                    profile(error, user: user)
                }
            })
        })
    }
    
    
    @IBAction func signinBtnAction(_ sender: Any) {
        guard let email = emailTF.text else {return}
        guard let password = pwTF.text else {return}
        
        UserSigninService.shared.login(email, password) {
            data in
            
            switch data {
            case .success(let token):
                UserDefaults.standard.set(token, forKey: "token")
                
                let dvc = UIStoryboard(name: "AskerSignUp", bundle: nil).instantiateViewController(withIdentifier: "AskerSignUpNC") as! UINavigationController
                self.present(dvc, animated: true, completion: nil)
                
                break
            case .requestErr(let err):
                self.simpleAlert(title: "로그인 실패", message: err as! String)
                break
            case .pathErr:
                // 대체로 경로를 잘못 쓴 경우입니다.
                // 오타를 확인해보세요.
                print("경로 에러")
                break
            case .serverErr:
                // 서버의 문제인 경우입니다.
                // 여기에서 동작할 행동을 정의해주시면 됩니다.
                print("서버 에러")
                break
            case .networkFail:
                self.simpleAlert(title: "통신 실패", message: "네트워크 상태를 확인하세요.")
                break
            } //로직은 클라이언트가 아닌 서버파트에서 담당해야 함
        }
    }
    
    // MARK: - Methods
    func getAccessToken() {
        guard let token = AccessToken.current else { return }
        
        print("#### AccessToken ####")
        print(token)
        print("#### AccessToken ####")
    }
    
    
    func iconTF() {
        emailTF.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 21, y: 17, width: 13, height: 14))
        let image = UIImage(named: "loginImgEmail")
        imageView.image = image
        emailTF.leftView = imageView
        
        pwTF.leftViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 21, y: 17, width: 13, height: 14))
        let image2 = UIImage(named: "loginImgPassword")
        imageView2.image = image2
        pwTF.leftView = imageView2
    }
    func snsSignup() {
        let dvc = UIStoryboard(name: "AskerSignUp", bundle: nil).instantiateViewController(withIdentifier: "AskerSNSSignUpViewController") as! AskerSNSSignUpViewController
        
        //dvc.email.text = getEmail
        self.present(dvc, animated: true, completion: nil)
    }
    
}
