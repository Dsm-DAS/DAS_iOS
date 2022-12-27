import UIKit
import SnapKit
import Then

class CommentCollectionViewCell: UICollectionViewCell {
    var commentId = 0
    let userImageView = UIImageView()
    let userNameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    let commentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.numberOfLines = 2
    }
    private let menuImageView = UIImageView().then {
        $0.image = UIImage(named: "EditMenu")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
        [
            userImageView,
            userNameLabel,
            commentLabel,
            menuImageView
        ].forEach { addSubview($0) }
        userImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(8)
            $0.height.width.equalTo(40)
        }
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(8)
        }
        commentLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(4)
        }
        menuImageView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
            $0.height.width.equalTo(20)
        }
    }
}
