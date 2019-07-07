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
        getAccessToken()
    }
    
    // MARK: - Methods
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
    
    
    // MARK: - IBAction
    
    // 일반 로그인
    @IBAction func tappedLoginButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AskerTabbar", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AskerTabbar")
        self.present(viewController, animated: true)
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
    
    func snsSignup() {
        let dvc = UIStoryboard(name: "AskerSignUp", bundle: nil).instantiateViewController(withIdentifier: "AskerSNSSignUpViewController") as! AskerSNSSignUpViewController
        
        //dvc.email.text = getEmail
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func signinBtnAction(_ sender: Any) {
        let dvc = UIStoryboard(name: "AskerSignUp", bundle: nil).instantiateViewController(withIdentifier: "AskerSignUpNC") as! UINavigationController
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    func getAccessToken() {
        guard let token = AccessToken.current else { return }
        
        print("#### AccessToken ####")
        print(token)
        print("#### AccessToken ####")
    }
}
