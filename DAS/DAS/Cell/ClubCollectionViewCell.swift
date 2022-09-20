//
//  ClubCollectionViewCell.swift
//  DAS
//
//  Created by 박주영 on 2022/09/19.
//

import UIKit
import SnapKit
import Then

class ClubCollectionViewCell: UICollectionViewCell {
    let clubImageView = UIImageView().then {
        $0.image = UIImage(named: "ClubImageMini")
    }
    let clubNameLabel = UILabel().then {
        $0.text = "동아리이름"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    let centerLine = UILabel().then {
        $0.backgroundColor = .gray
    }
    let tagLabel = UILabel().then {
        $0.text = "#자바스크립트 #스프링부트 #리엑트네이티브 #안드로이드"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 2
    }
  
    override func layoutSubviews() {
        self.backgroundColor = UIColor(named: "CellBackGround")
        [clubImageView, clubNameLabel, centerLine, tagLabel].forEach {self.addSubview($0)}
        clubImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(8)
            $0.width.height.equalTo(50)
        }
        clubNameLabel.snp.makeConstraints {
            $0.left.equalTo(clubImageView.snp.right).offset(8)
            $0.top.equalToSuperview().inset(21)
            $0.height.equalTo(22)
        }
        centerLine.snp.makeConstraints {
            $0.top.equalTo(clubImageView.snp.bottom).offset(8)
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(8)
        }
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(centerLine.snp.bottom).offset(7)
            $0.left.right.bottom.equalToSuperview().inset(5)
        }
    }
}
