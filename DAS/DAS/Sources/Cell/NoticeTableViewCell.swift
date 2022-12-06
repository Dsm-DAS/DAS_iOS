//
//  NoticeTableViewCell.swift
//  DAS
//
//  Created by 박도연 on 2022/11/23.
//

import UIKit
import SnapKit
import Then

class NoticeTableViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    let titleLabel = UILabel().then {
        $0.text = "어쩌구 저쩌구 모집합니다"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    let subTitleLabel = UILabel().then {
        $0.text = "프론트엔드, 백엔드, 인공지능 등"
        $0.textColor = UIColor(named: "TextColor")
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
    }
    let clubImageView = UIImageView().then {
        $0.image = UIImage(named: "ClubImageMini")
        
    }
    let BottomLineView = UIView().then {
        
        $0.backgroundColor = UIColor(named: "PickerLine")
        
    }
    
    override func layoutSubviews() {
        
        addSubview()
        makeLayoutConstraint()
    }
    
    
     func addSubview() {
        
         [titleLabel,subTitleLabel,clubImageView,BottomLineView].forEach {self.addSubview($0)}
    }
    
    func makeLayoutConstraint() {
        
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        clubImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(14)
            $0.width.height.equalTo(50)
        }

        BottomLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
        
}
