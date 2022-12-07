import UIKit
import SnapKit
import Then

class MyClubCollectionViewCell: UICollectionViewCell {
    let clubImageView = UIImageView().then {
        $0.image = UIImage.init(named: "ClubImageMini")
    }
    let clubNameLabel = UILabel().then {
        $0.text = "멋진로고동아리"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 16
        self.backgroundColor = .green
        [
            clubImageView,
            clubNameLabel
        ].forEach { addSubview($0) }
        
        clubImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(8)
            $0.width.height.equalTo(50)
        }
        clubNameLabel.snp.makeConstraints {
            $0.leading.equalTo(clubImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
    }
}
