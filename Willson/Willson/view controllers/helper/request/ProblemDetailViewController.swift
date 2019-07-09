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
    
    // MARK: - IBOutlet
    @IBOutlet weak var problemDetailTableView: UITableView!

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // UITableView delegate, dataSource
        problemDetailTableView.delegate = self
        problemDetailTableView.dataSource = self
        
        self.problemDetailTableView.separatorStyle = .none
    }
    
    // MARK: - IBAction
    
    // MARK: - Methods

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
            return cell
        case 1:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "#짝사랑"
            return cell
        case 2:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "#어색한, #질투나는, #슬픈, #무기력한"
            return cell
        case 3:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "3: 일상생활에 지장을 주는 정도"
            return cell
        case 4:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            cell.contentLabel.text = "학창시절 음악이 너무나도 하고 싶었던 저는 부모님의 반대에 부딪혀 많이 좌절하곤 했었습니다."
            return cell
        case 5:
            guard let cell: ProblemDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: problemDetailTableViewCellIdnetifier, for: indexPath) as? ProblemDetailTableViewCell else { return UITableViewCell() }
            switch indexPath.row {
            case 1:
                cell.contentLabel.text = "성별: 여자"
            case 2:
                cell.contentLabel.text = "성격: #감성적인, #신중한"
            case 3:
                cell.contentLabel.text = "경험: #이별, #다툼, #우울"
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
}
