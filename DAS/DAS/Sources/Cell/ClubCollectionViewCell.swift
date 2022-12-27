import UIKit
import SnapKit
import Then

class ClubCollectionViewCell: UICollectionViewCell {
    var clubId = 0
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
    let heartView = HeartView().then {
        $0.heartCountLabel.text = "sdf"
    }
    
    let tagLabel = UILabel().then {
        $0.text = "#자바스크립트 #스프링부트 #리엑트네이티브 #안드로이드"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
            heartView
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
        heartView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(backView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(12)
        }
    }
}
