import UIKit
import SnapKit
import Then

class HeartView: UIView {
    let heartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "Heart"), for: .normal)
        $0.tintColor = UIColor(named: "LookUp")
    }
    let heartCountLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor(named: "LookUp")
    }
    override func layoutSubviews() {
        [
            heartButton,
            heartCountLabel
        ].forEach { addSubview($0) }
        heartButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        heartCountLabel.snp.makeConstraints {
            $0.leading.equalTo(heartButton.snp.trailing)
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
    }
}
