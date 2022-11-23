import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
class EmailViewController: BaseVC {
    let viewModel = EmailViewModel()
    private let joinLabel = UILabel().then {
        $0.text = "가입"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let emailNoticeLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = .systemFont(ofSize: 36, weight: .bold)
        $0.textColor = .black
    }
    private let signUpStateLabel = UILabel().then {
        $0.text = "dsm.hs.kr 도메인을 사용하세요"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
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
        $0.layer.borderColor = UIColor(named:"SignUpButtonColor")?.cgColor
    }
    private let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    override func bind() {
        let input = EmailViewModel.Input(emailText: emailTextField.rx.text.orEmpty.asDriver(),
                             nextButtonDidTap: nextButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: { [self] in
            switch $0 {
            case true:
                print("코드 보냄")
                let vc = EmailCodeViewController()
                vc.email = emailTextField.text!
                print(vc.email)
                navigationController?.pushViewController(vc, animated: true)
            case false:
                print("코드 보내기 실패")
            }
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        emailTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: { [self] in
                nextButton.isEnabled = $0
                switch $0{
                case true:
                    nextButton.backgroundColor = UIColor(named: "MainColor")
                case false:
                    nextButton.backgroundColor = UIColor(named: "SignUpButton")
                }
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
            emailNoticeLabel,
            signUpStateLabel,
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
        emailNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(95)
            $0.height.equalTo(45)
        }
        signUpStateLabel.snp.makeConstraints {
            $0.top.equalTo(emailNoticeLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(signUpStateLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(42)
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
