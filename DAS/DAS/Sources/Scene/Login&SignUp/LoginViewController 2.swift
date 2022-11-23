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
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    private let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let emailTextField = UITextField().then {
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
        $0.isSecureTextEntry = true
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setBackgroundColor(UIColor(named: "MainColor")! , for: .normal)
        $0.setBackgroundColor(UIColor(named: "SignUpButton")!, for: .disabled)
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
    }
    private let signUpButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "SignUpButtonColor")
        $0.setTitle("가입", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
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
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    private func touchSignupButton() {
        signUpButton.rx.tap
            .subscribe(onNext: {
                let vc = SignUpViewController()
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
        logoImageView.snp.makeConstraints {
            $0.top.lessThanOrEqualToSuperview().inset(254)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(41)
        }
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(63)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(40)
        }
        emailTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(32)
            $0.top.equalTo(emailLabel.snp.bottom).offset(4)
            $0.height.equalTo(40)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(40)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(40)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(28)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(36)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(36)
            $0.bottom.lessThanOrEqualToSuperview().inset(130)
        }
    }
      
}
