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
    var userId = 0
    let studentImageView = UIImageView().then {
        $0.image = UIImage(named: "CellImage")
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "PickerLine")?.cgColor
    }
    let studentNameLabel = UILabel().then {
        $0.text = "박김이름"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    let lookUpCount = UILabel().then {
        $0.text = "38 조회"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor(named: "LookUp")
    }
    override func layoutSubviews() {
        addSubView()
        makeLayoutConstraint()
    }
    func addSubView(){
        [studentImageView, studentNameLabel, lookUpCount].forEach {self.addSubview($0)}
    }
    func makeLayoutConstraint(){
        studentImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
        studentNameLabel.snp.makeConstraints {
            $0.leading.equalTo(studentImageView.snp.trailing).offset(7)
            $0.top.equalToSuperview().inset(5)
            $0.height.equalTo(25)
        }
        lookUpCount.snp.makeConstraints {
            $0.leading.equalTo(studentImageView.snp.trailing).offset(6)
            $0.top.equalTo(studentNameLabel.snp.bottom).offset(4)
        }
    }
}
