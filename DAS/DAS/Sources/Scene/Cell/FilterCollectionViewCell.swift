//
//  StudentFilterCollectionViewCell.swift
//  DAS
//
//  Created by 박도연 on 2022/12/04.
//

import UIKit
import SnapKit
import Then

class FilterCollectionViewCell: UICollectionViewCell {
    var bool = false
    let nameLabel = UILabel().then {
        $0.text = ""
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "BackGroundColor3")?.cgColor
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}
