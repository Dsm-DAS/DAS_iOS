import UIKit
import Then
import SnapKit

class IntroduceView: UIView {
    private let introduceProFilLabel = UILabel().then {
        $0.text = "자기소개"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    let proFilLabel = UILabel().then {
//        $0.text = "반가워요 저는 자기소개를 쓰고 있어요 \n두번째 줄이에요 \n히히-세번째줄-발사"
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
