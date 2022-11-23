import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
class EmailCodeVC: BaseVC {
    var email = ""
    private var limitTime: Int = 300
    let viewModel = EmailCodeViewModel()
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
    private let codeTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let timerLabel = UILabel().then {
        $0.text = "05:00"
        $0.textColor = UIColor(named: "MainColor")
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    private let emailCodeImageView = UIImageView().then {
        $0.image = UIImage(named: "EmailCodeImage")
    }
    private let checkButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("인증", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    override func bind() {
        let input = EmailCodeViewModel.Input(codeText: codeTextField.rx.text.orEmpty.asDriver(),
                                             emailText: email,
                                             checkButtonDidTap: checkButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: { [self] in
            switch $0 {
            case true:
                print("코드 맞음")
                let vc = PasswordVC()
                vc.email = email
                vc.code = codeTextField.text!
                navigationController?.pushViewController(vc, animated: true)
            case false:
                print("코드 다름")
            }
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        self.navigationItem.hidesBackButton = true
        getSecTime()
        codeTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: {
                self.checkButton.isEnabled = $0
                switch $0{
                case true:
                    self.checkButton.backgroundColor = UIColor(named: "MainColor")
                case false:
                    self.checkButton.backgroundColor = UIColor(named: "SignUpButton")
                }
            }).disposed(by: disposeBag)
    }
    @objc func getSecTime(){
        secToTime(sec: limitTime)
        limitTime -= 1;
    }
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        if second < 10 {
            timerLabel.text = "0\(minute)" + ":" + "0\(second)"
        } else {
            timerLabel.text = "0\(minute)" + ":" + "\(second)"
        }
        if limitTime != 0 {
            perform(#selector(getSecTime), with: nil, afterDelay: 1.0)
        }
    }
    override func addView() {
        [
            joinLabel,
            emailCodeNoticeLabel,
            CodeStateLabel,
            emailLabel,
            codeTextField,
            emailCodeImageView,
            checkButton
        ].forEach { view.addSubview($0) }
        codeTextField.addSubview(timerLabel)
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
        codeTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        timerLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
        emailCodeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(codeTextField.snp.bottom).offset(64)
        }
        checkButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(41)
        }
    }
}
