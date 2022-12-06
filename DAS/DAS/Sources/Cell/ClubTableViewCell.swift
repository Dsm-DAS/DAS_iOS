//
//  ClubTableViewCell.swift
//  DAS
//
//  Created by 박도연 on 2022/11/29.
//

import UIKit
import SnapKit
import Then

class ClubTableViewCell: UITableViewCell {
    let backView = UIView().then {
        $0.backgroundColor = .cyan
        $0.layer.cornerRadius = 21
    }
    let clubImageView = UIImageView().then {
        $0.image = UIImage(named: "ClubImageMini")
    }
    let clubNameLabel = UILabel().then {
        $0.text = "동아리이름"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    let tagLabel = UILabel().then {
        $0.text = "#자바스크립트 #스프링부트 #리엑트네이티브 #안드로이드"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.numberOfLines = 2
    }
    
    override func layoutSubviews() {
        [
            backView,
            tagLabel
        ].forEach{ addSubview($0) }
        [
            clubImageView,
            clubNameLabel,
        ].forEach { backView.addSubview($0) }
        backView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(66)
        }
        clubImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        clubNameLabel.snp.makeConstraints {
            $0.leading.equalTo(clubImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(25)
        }
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(backView.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview().inset(12)
        }
    }
}
