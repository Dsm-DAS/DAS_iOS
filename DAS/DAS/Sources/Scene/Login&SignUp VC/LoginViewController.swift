import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
class LoginViewController: BaseVC {
    let viewModel = LoginViewModel()
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named:"Logo2")
    }
    private let loginLabel = UILabel().then {
        $0.text = "로그인"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let emailTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let passwordTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
        $0.isSecureTextEntry = true
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    private let signUpButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "SignUpButtonColor")
        $0.setTitle("가입", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.layer.cornerRadius = 8
    }
    override func configureVC() {
        textFieldDidChange()
        touchSignupButton()
    }
    override func bind() {
        let input = LoginViewModel.Input(emailText: emailTextField.rx.text.orEmpty.asDriver(), passwordText: passwordTextField.rx.text.orEmpty.asDriver(), loginButtonDidTap: loginButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                self.dismiss(animated: true)
                print("login 성공")
            case false:
                print("login 실패")
            }
        }).disposed(by: disposeBag)
    }
    private func textFieldDidChange() {
        let textField = Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty)
        textField
            .map { $0.count != 0 && $1.count != 0 }
            .subscribe(onNext: {
                self.loginButton.isEnabled = $0
                switch $0{
                case true:
                    self.loginButton.backgroundColor = UIColor(named: "MainColor")
                case false:
                    self.loginButton.backgroundColor = UIColor(named: "SignUpButton")
                }
            })
            .disposed(by: disposeBag)
    }
    private func touchSignupButton() {
        signUpButton.rx.tap
            .subscribe(onNext: {
                let vc = UINavigationController(rootViewController: EmailViewController())
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    override func addView() {
        [logoImageView, loginLabel, emailLabel, emailTextField, passwordLabel, passwordTextField, loginButton, signUpButton].forEach {
            view.addSubview($0)
        }
    }
    override func setLayout() {
        loginLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualToSuperview().inset(157)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(30)
            $0.width.equalTo(63)
        }
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(134)
            $0.height.equalTo(35)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(107)
            $0.left.equalToSuperview().inset(28)
        }
        emailTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(emailLabel.snp.bottom).offset(4)
            $0.height.equalTo(44)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.left.equalToSuperview().inset(28)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(41)
        }
        signUpButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(41)
            $0.bottom.lessThanOrEqualToSuperview().inset(34)
        }
    }
      
}
