import SnapKit
import Then
import UIKit

class ProFilButton: UIButton {
    let studentImageView = UIImageView().then {
        $0.layer.cornerRadius = 28
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "CellImage")
    }
    let studentNameLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    let subTitleLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    let editImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = UIColor(named: "TextColor")
        $0.contentMode = .scaleToFill
    }
    override func layoutSubviews() {
        addSubView()
        makeLayoutConstraint()
    }
    func addSubView(){
        [
            studentImageView,
            studentNameLabel,
            subTitleLabel,
            editImageView
        ].forEach {self.addSubview($0)}
    }
    func makeLayoutConstraint(){
        studentImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(20)
            $0.width.height.equalTo(56)
        }
        studentNameLabel.snp.makeConstraints {
            $0.leading.equalTo(studentImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(27)
            $0.height.equalTo(25)
        }
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(studentImageView.snp.trailing).offset(12)
            $0.top.equalTo(studentNameLabel.snp.bottom)
            $0.height.equalTo(20)
        }
        editImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview().inset(38)
            $0.height.equalTo(25)
            $0.width.equalTo(16)
        }
    }
}
