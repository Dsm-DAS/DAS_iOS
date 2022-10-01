//
//  StudentCollectionViewCell.swift
//  DAS
//
//  Created by 박주영 on 2022/09/19.
//

import UIKit
import SnapKit
import Then
class StudentCollectionViewCell: UICollectionViewCell {
    let studentImageView = UIImageView().then {
        $0.image = UIImage(named: "CellImage")
    }
    let studentNameLabel = UILabel().then {
        $0.text = "박김이름"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    let heartButton = UIButton().then {
        $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        $0.tintColor = UIColor(named: "MainColor")
    }
    let heartCount = UILabel().then {
        $0.text = "38"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor(named: "MainColor")
    }
    override func layoutSubviews() {
        addSubView()
        makeLayoutConstraint()
    }
    func addSubView(){
        [studentImageView, studentNameLabel, heartButton, heartCount].forEach {self.addSubview($0)}
    }
    func makeLayoutConstraint(){
        studentImageView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        studentNameLabel.snp.makeConstraints {
            $0.left.equalTo(studentImageView.snp.right).offset(7)
            $0.top.equalToSuperview().inset(5)
            $0.height.equalTo(25)
        }
        heartButton.snp.makeConstraints {
            $0.left.equalTo(studentImageView.snp.right).offset(7)
            $0.top.equalTo(studentNameLabel.snp.bottom).offset(6)
            $0.height.equalTo(16)
        }
        heartCount.snp.makeConstraints {
            $0.left.equalTo(heartButton.snp.right)
            $0.top.equalTo(studentNameLabel.snp.bottom).offset(4)
        }
    }
}
