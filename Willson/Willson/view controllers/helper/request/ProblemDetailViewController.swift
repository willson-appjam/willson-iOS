//
//  ProblemDetailViewController.swift
//  Willson
//
//  Created by JHKim on 10/07/2019.
//  Copyright © 2019 JaehuiKim. All rights reserved.
//

import UIKit

class ProblemDetailViewController: UIViewController {
    
    // MARK: - properties
    let problemDetailTitleTableViewCellIdentifier = "ProblemDetailTitleTableViewCell"
    let problemDetailTableViewCellIdnetifier = "ProblemDetailTableViewCell"
    
    var userProfile: UserProfile?
    var userProfileData: UserProfileData?
    var user: User?
    var userPersonality: [Personality]?
    var question: UserQuestion?
    var userID: Int?
    
    // MARK: - IBOutlet
    @IBOutlet weak var problemDetailTableView: UITableView!

    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        getUserProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserProfile()
        // UITableView delegate, dataSource
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        problemDetailTableView.delegate = self
        problemDetailTableView.dataSource = self
        
        self.problemDetailTableView.separatorStyle = .none
    }
    // MARK: - IBAction
    
    // MARK: - Methods
    func getUserProfile() {
        UserProfileService.shared.getProfile(userID: userID!) {
            userProfile, statusCode in
            switch statusCode {
            case 200:
                self.userProfile = userProfile
                self.userProfileData = userProfile.data
                self.user = self.userProfileData?.user
                self.userPersonality = self.userProfileData?.userPersonality
                self.question = self.userProfileData?.question
                break;
            default:
                break;
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension ProblemDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 315
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 315
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UITableViewDataSource
extension ProblemDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 5: return 3
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: ProblemDetailTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTitleTableViewCellIdentifier, for: indexPath) as? ProblemDetailTitleTableViewCell else { return UITableViewCell() }
            cell.nickname.text = user?.nickname ?? ""
            cell.detailInfo.text = "\(user?.gender ?? "") / \(user?.age ?? "")"
            
            return cell
        case 1:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "# \(question?.categoryListName ?? "")"
            return cell
        case 2:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "#\(question?.questionFeeling[0].feelingName ?? ""), #\(question?.questionFeeling[1].feelingName ?? ""), #\(question?.questionFeeling[2].feelingName ?? "")"
            return cell
        case 3:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "\(String(question?.weight ?? 0)) / 5 "
            return cell
        case 4:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "\(question?.content ?? "")"
            return cell
        case 5:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            switch indexPath.row {
            case 0:
                cell.contentLabel.text = "성별: \(question?.helperGender ?? "")"
            case 1:
                cell.contentLabel.text = "성격: #\(question?.questionPersonality[0].personalityName ?? ""), #\(question?.questionPersonality[0].personalityName ?? ""), ##\(question?.questionPersonality[0].personalityName ?? "")"
            case 2:
                cell.contentLabel.text = "경험: #\(question?.questionFeeling[0].feelingName ?? ""), #\(question?.questionFeeling[1].feelingName ?? ""), #\(question?.questionFeeling[2].feelingName ?? "")"
            default: break
            }
            return cell
        case 6:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "정서적 지지: 1, 문제 해결 조력: 3, 경험 제공: 5"
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1: return "당신의 연애고민은 어디에 해당하나요?"
        case 2: return "어떤 감정을 느꼈나요?"
        case 3: return "당신의 고민은 얼마나 중요한가요?"
        case 4: return "구체적으로 어떤 내용인가요?"
        case 5: return "원하는 헬퍼는 어떤 분인가요?"
        case 6: return "원하는 대화 방향은 무엇인가요?"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.backgroundView?.backgroundColor = .white
        header.textLabel?.textColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
        header.textLabel?.font = UIFont(name: "NanumSquareL", size: 16)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
    }
}
