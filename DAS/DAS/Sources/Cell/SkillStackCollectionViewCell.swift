import UIKit
import SnapKit
import Then

class SkillStackCollectionViewCell: UICollectionViewCell {
    let skillStackLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = 18
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "BackGroundColor3")?.cgColor
        addSubview(skillStackLabel)
        skillStackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}
