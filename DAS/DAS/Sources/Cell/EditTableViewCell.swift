import UIKit
import SnapKit
import Then

class EditTableViewCell: BaseTC {
    let editImageView = UIImageView().then {
        $0.image = UIImage(named: "Heart")
    }
    let titleLabel = UILabel().then {
        $0.text = "계정"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    let chevronImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = UIColor(named: "TextColor")
    }
    let bottomLineView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override func addView() {
        self.selectionStyle = .none
        [
            editImageView,
            titleLabel,
            chevronImageView,
            bottomLineView
        ].forEach { addSubview($0) }
    }
    override func setLayout() {
        editImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
            $0.leading.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(editImageView.snp.trailing).offset(10.55)
        }
        chevronImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
        }
        bottomLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
