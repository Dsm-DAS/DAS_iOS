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
    override func layoutSubviews() {
        [clubImageView, clubNameLabel].forEach {self.addSubview($0)}
        clubImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(8)
            $0.width.height.equalTo(50)
        }
        clubNameLabel.snp.makeConstraints {
            $0.left.equalTo(clubImageView.snp.right).offset(8)
            $0.top.equalToSuperview().inset(21)
            $0.width.equalTo(88)
            $0.height.equalTo(22)
        }
    }
}
