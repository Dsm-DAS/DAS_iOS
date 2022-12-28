import UIKit
import SnapKit
import Then

class LinkCollectionViewCell: UICollectionViewCell {
    let linkImageView = UIImageView()
    let linkLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    override func layoutSubviews() {
        self.backgroundColor = UIColor(named: "SignUpButtonColor")
        self.layer.cornerRadius = 14
        [
            linkImageView,
            linkLabel
        ].forEach { addSubview($0) }
        linkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(6)
            $0.width.equalTo(16)
        }
        linkLabel.snp.makeConstraints {
            $0.leading.equalTo(linkImageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(4)
        }
    }
}

