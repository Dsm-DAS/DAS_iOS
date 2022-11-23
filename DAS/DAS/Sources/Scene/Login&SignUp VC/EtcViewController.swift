import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
class EtcViewController: BaseVC {
    var email: String = ""
    var code: String = ""
    var password: String = ""
    var grade = PublishRelay<Int>()
    var classNum = PublishRelay<Int>()
    var number = PublishRelay<Int>()
    private var limitTime: Int = 300
    let viewModel = EtcViewModel()
    private let joinLabel = UILabel().then {
        $0.text = "가입"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let etcNoticeLabel = UILabel().then {
        $0.text = "기타정보"
        $0.font = .systemFont(ofSize: 36, weight: .bold)
        $0.textColor = .black
    }
    private let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let nameTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let etcLabel = UILabel().then {
        $0.text = "학년, 반, 번호"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let pickerView = UIPickerView()
    private let pickerLeftView = UIView().then {
        $0.backgroundColor = UIColor(named: "TextColor")
    }
    private let pickerRightView = UIView().then {
        $0.backgroundColor = UIColor(named: "TextColor")
    }
    private let sexLabel = UILabel().then {
        $0.text = "성별"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let sexSegmentedControl = UISegmentedControl(items: ["남성","여성"]).then {
        $0.selectedSegmentIndex = 0
        $0.selectedSegmentTintColor = UIColor(named: "MainColor")
        $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    private let signupButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    override func bind() {
        let input = EtcViewModel.Input(emailText: email,
                              codeText: code,
                              passwordText: password,
                              gradeText: grade,
                              classNumText: classNum,
                              numberText: number,
                              signupBttonDidTap: signupButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.result.subscribe(onNext: {
            switch $0 {
            case true:
                print("회원가입 성공")
            case false:
                print("회원가입 실패")
            }
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        pickerView.delegate = self
        self.navigationItem.hidesBackButton = true
        nameTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
            .subscribe(onNext: {
                self.signupButton.isEnabled = $0
                switch $0{
                case true:
                    self.signupButton.backgroundColor = UIColor(named: "MainColor")
                case false:
                    self.signupButton.backgroundColor = UIColor(named: "SignUpButton")
                }
            }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            joinLabel,
            etcNoticeLabel,
            nameLabel,
            nameTextField,
            etcLabel,
            pickerView,
            sexLabel,
            sexSegmentedControl,
            signupButton
        ].forEach { view.addSubview($0) }
        [
            pickerLeftView,
            pickerRightView
        ].forEach { pickerView.addSubview($0) }
    }
    override func setLayout() {
        joinLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(157)
            $0.width.equalTo(42)
            $0.height.equalTo(30)
        }
        etcNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(135)
            $0.height.equalTo(45)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(etcNoticeLabel.snp.bottom).offset(76)
        }
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.height.equalTo(44)
        }
        etcLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(nameTextField.snp.bottom).offset(26)
        }
        pickerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(etcLabel.snp.bottom).offset(5)
            $0.height.equalTo(140)
        }
        pickerLeftView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(120)
            $0.top.bottom.equalToSuperview().inset(57)
            $0.width.equalTo(1)
        }
        pickerRightView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(120)
            $0.top.bottom.equalToSuperview().inset(57)
            $0.width.equalTo(1)
        }
        sexLabel.snp.makeConstraints {
            $0.top.equalTo(pickerView.snp.bottom).offset(22)
            $0.leading.equalToSuperview().inset(16)
        }
        sexSegmentedControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(sexLabel.snp.bottom).offset(4)
            $0.height.equalTo(50)
        }
        signupButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(41)
        }
    }
}
extension EtcViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 20
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
        
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickLabel = UILabel()
        pickLabel.textColor = .black
        pickLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        if component == 0 {
            pickLabel.text = "\(row + 1)"
        } else {
            pickLabel.text = "\(row + 1)"
        }
        pickLabel.textAlignment = .center
        return pickLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            grade.accept(row + 1)
            print("학년: \(row + 1)")
        case 1:
            classNum.accept(row + 1)
            print("반: \(row + 1)")
        case 2:
            number.accept(row + 1)
            print("번호: \(row + 1)")
        default:
            print("default")
        }
    }
}
