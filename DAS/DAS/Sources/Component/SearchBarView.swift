import UIKit
import SnapKit
import Then

class SearchBarView: UIView {
    private let searchTextField = UITextField().then {
        $0.addLeftPadding()
    }
    private let searchButton = UIButton().then {
        $0.setImage(UIImage(named: "SearchMini"), for: .normal)
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "BackGroundColor2")?.cgColor
        self.backgroundColor = UIColor(named: "BackGroundColor")
        [
            searchTextField,
            searchButton
        ].forEach { addSubview($0) }
        searchTextField.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(searchButton.snp.leading)
        }
        searchButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(24)
        }
    }
}
