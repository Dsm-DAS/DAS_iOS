import UIKit
import Then
import SnapKit
class EmptyView: UIView {
    let emptyImageView = UIImageView()
    
    let emptyLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = UIColor(named: "SignUpButtonColor")
    }

    override func layoutSubviews() {
        [
            emptyImageView,
            emptyLabel
        ].forEach { addSubview($0) }
        emptyImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(180)
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }

}
