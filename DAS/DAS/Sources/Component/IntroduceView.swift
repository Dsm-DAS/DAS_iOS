import UIKit
import Then
import SnapKit

class IntroduceView: UIView {
    private let introduceProFilLabel = UILabel().then {
        $0.text = "자기소개"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    let proFilLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 4
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        [
            introduceProFilLabel,
            proFilLabel
        ].forEach { addSubview($0) }
        proFilLabel.snp.makeConstraints {
            $0.top.equalTo(introduceProFilLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(60)
        }
        introduceProFilLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(12)
        }
    }
}
