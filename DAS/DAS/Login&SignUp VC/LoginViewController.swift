import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
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
        $0.backgroundColor = UIColor(named: "SignUpButton")
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
        $0.isEnabled = false
    }
    private let signUpButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "SignUpButtonColor")
        $0.setTitle("가입", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 8
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        targets()
    }
    override func viewWillLayoutSubviews() {
        view.backgroundColor = .white
        addSubView()
        makeLayoutConstraints()
    }
    private func targets(){
        loginButton.addTarget(self, action:#selector(touchLoginButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(touchSignUpButton), for: .touchUpInside)
        [emailTextField,passwordTextField].forEach {$0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)}
    }
    @objc func textFieldDidChange(_ sender: Any?) {
        if emailTextField.text! != "" && passwordTextField.text! != "" {
            loginButton.backgroundColor = UIColor(named: "MainColor")
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = UIColor(named: "SignUpButton")
            loginButton.isEnabled = false
        }
    }
    
    @objc
    func touchLoginButton(){
        guard let email = emailTextField.text, email.isEmpty == false else { return }
        guard let password = passwordTextField.text, password.isEmpty == false else { return }
        MY.request(.login(email: email, password: password)) { res in
            switch res {
            case .success(let result):
                switch result.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                    if let data = try? decoder.decode(LoginDataModel.self, from: result.data){
                        Token.accessToken = data.access_token
                        Token.refreshToken = data.refresh_token
                    }
                default:
                    print("Login result err")
                }
            case .failure(_):
                print("Login respons err")
            }
        }
    }
    @objc
    func touchSignUpButton(){
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    private func addSubView(){
        [logoImageView, loginLabel, emailLabel, emailTextField, passwordLabel, passwordTextField, loginButton, signUpButton].forEach {
            view.addSubview($0)
        }
    }
    private func makeLayoutConstraints() {
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
