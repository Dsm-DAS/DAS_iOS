import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
class EmailCodeViewController: BaseVC {
    private var limitTime: Int = 300
    let viewModel = SignUpViewModel()
    private let joinLabel = UILabel().then {
        $0.text = "가입"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let emailCodeNoticeLabel = UILabel().then {
        $0.text = "인증번호"
        $0.font = .systemFont(ofSize: 36, weight: .bold)
        $0.textColor = .black
    }
    private let CodeStateLabel = UILabel().then {
        $0.text = "입력한 이메일로 전송된 6자리 인증 번호를 입력해 주세요"
        $0.numberOfLines = 2
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    private let emailLabel = UILabel().then {
        $0.text = "인증번호"
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
    private let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)    }
    override func configureVC() {
        emailTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: {
                self.nextButton.isEnabled = $0
                switch $0{
                case true:
                    self.nextButton.backgroundColor = UIColor(named: "MainColor")
                case false:
                    self.nextButton.backgroundColor = UIColor(named: "SignUpButton")
                }
            }).disposed(by: disposeBag)
        nextButton.rx.tap
            .subscribe(onNext: {
                self.viewModel.emailText = self.emailTextField.text ?? ""
                let vc = EmailCodeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
//    private func alert(title:String,message:String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            switch title {
//            case "회원가입":
//                self.dismiss(animated: true)
//            default:
//                break
//            }
//        }
//        alert.addAction(okAction)
//        present(alert, animated: true, completion:nil)
//    }
    override func addView() {
        [
            joinLabel,
            emailCodeNoticeLabel,
            CodeStateLabel,
            emailLabel,
            emailTextField,
            nextButton
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        joinLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(157)
            $0.width.equalTo(42)
            $0.height.equalTo(30)
        }
        emailCodeNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(135)
            $0.height.equalTo(45)
        }
        CodeStateLabel.snp.makeConstraints {
            $0.top.equalTo(emailCodeNoticeLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(CodeStateLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(60)
            $0.height.equalTo(20)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(4)
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
