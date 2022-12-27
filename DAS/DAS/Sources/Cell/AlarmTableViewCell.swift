import UIKit
import SnapKit
import Then

class AlarmTableViewCell: UITableViewCell {
    var isTouch = false
    let alarmImageView = UIImageView().then {
        $0.image = UIImage(named: "Notice.white")
    }
    let imageBackView = UIView().then {
        $0.layer.cornerRadius = 25
        $0.backgroundColor = UIColor(named: "MainColor")
    }
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.text = "sdfsdf"
    }
    let timeLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.textColor = UIColor(named: "TextColor")
        $0.text = "sdfdsf"
    }
    let bottomLineView = UIView().then {
        $0.backgroundColor = UIColor(named: "PickerLine")
    }
    override func layoutSubviews() {
        imageBackView.addSubview(alarmImageView)
        [
            imageBackView,
            titleLabel,
            timeLabel,
            bottomLineView
        ].forEach { addSubview($0) }
        alarmImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(24)
            $0.height.equalTo(26)
        }
        imageBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageBackView.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview()
        }
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(imageBackView.snp.trailing).offset(8)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.trailing.equalToSuperview()
        }
        bottomLineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }

}
