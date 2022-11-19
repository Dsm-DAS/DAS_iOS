import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class PasswordViewController: BaseVC {
    private let emailCkeckCodeButton = UIButton(type: .system).then {
        $0.setTitle("전송", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
    }
    private let emailNoticeLabel = UILabel().then {
        $0.text = "dsm.hs.kr을 사용하세요"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let emailCheckLabel = UILabel().then {
        $0.text = "인증번호"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let emailCheckTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    private let emailCheckButton = UIButton(type: .system).then {
        $0.setTitle("인증", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "SignUpButton")
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
    }
    private let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let nameTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let passwordTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    private let passwordStateLabel = UILabel().then {
        $0.text = "8~20자 이내, 알파벳 대문자, 특수문자 1자를 포합해야 합니다"
        $0.textColor = .lightGray
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let passwordCheckLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let passwordCheckTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
    }
    private let gradeTextField = UITextField().then {
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .placeholderText
        $0.placeholder = "학년"
        $0.addLeftPadding()
    }
    private let classTextField = UITextField().then {
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .placeholderText
        $0.placeholder = "반"
        $0.addLeftPadding()
    }
    private let numberTextField = UITextField().then {
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .placeholderText
        $0.placeholder = "번호"
        $0.addLeftPadding()
    }
    private var signUpButton = UIButton(type: .system).then {
        $0.setBackgroundColor(UIColor(named: "MainColor")! , for: .normal)
        $0.setBackgroundColor(UIColor(named: "SignUpButton")!, for: .disabled)
        $0.setTitle("가입", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
        $0.isEnabled = true
    }
    override func configureVC() {
        
    }
}
