import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
class ChangePasswordVC: BaseVC {
    let viewModel = ChangePasswordViewModel()
    private let setLabel = UILabel().then {
        $0.text = "설정"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let passwordNoticeLabel = UILabel().then {
        $0.text = "비밀번호 변경"
        $0.font = .systemFont(ofSize: 36, weight: .bold)
        $0.textColor = .black
    }
    private let passwordStateLabel = UILabel().then {
        $0.text = "비밀번호는 8자 이상, 20자 이내여야 하며, 대문자 알파벳과 특수문자를 포함해야 합니다"
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    private let passwordLabel = UILabel().then {
        $0.text = "기존 비밀번호"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let passwordTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let newPasswordLabel = UILabel().then {
        $0.text = "새 비밀번호"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let newPasswordTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let passwordStateImageView = UIImageView().then {
        $0.image = UIImage(named: "CheckSign.x")
    }
    private let nextButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    private func validpassword(mypassword: String) -> Bool {
        let passwordreg =  ("(?=.*[0-9])(?=.*[a-zA-Z]).{8,20}$")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }
    override func bind() {
        let input = ChangePasswordViewModel.Input(previousPasswordText: passwordTextField.rx.text.orEmpty.asDriver(), newPasswordText: newPasswordTextField.rx.text.orEmpty.asDriver(), changeButtonDidTap: nextButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                self.dismiss(animated: true)
            default:
                return
            }
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        self.navigationItem.hidesBackButton = true
        newPasswordTextField.rx.text.orEmpty
            .filter { !$0.isEmpty }
            .map {self.validpassword(mypassword: $0)}
            .subscribe(onNext: { [self] in
                self.nextButton.isEnabled = $0
                switch $0{
                case true:
                    passwordStateImageView.image = UIImage(named: "CheckSign.o")
                    nextButton.backgroundColor = UIColor(named: "MainColor")
                case false:
                    passwordStateImageView.image = UIImage(named: "CheckSign.x")
                    nextButton.backgroundColor = UIColor(named: "SignUpButton")
                }
            }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            setLabel,
            passwordNoticeLabel,
            passwordStateLabel,
            passwordLabel,
            passwordTextField,
            newPasswordLabel,
            newPasswordTextField,
            nextButton
        ].forEach { view.addSubview($0) }
        newPasswordTextField.addSubview(passwordStateImageView)
    }
    override func setLayout() {
        setLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(157)
            $0.width.equalTo(42)
            $0.height.equalTo(30)
        }
        passwordNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(setLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(200)
            $0.height.equalTo(45)
        }
        passwordStateLabel.snp.makeConstraints {
            $0.top.equalTo(passwordNoticeLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordStateLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(90)
            $0.height.equalTo(20)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        passwordStateImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
        newPasswordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(90)
            $0.height.equalTo(20)
        }
        newPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(newPasswordLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(41)
        }
        
    }
    
    
}
