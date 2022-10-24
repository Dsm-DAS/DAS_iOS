import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
class SignUpViewController: BaseVC {
    let viewModel = SignUpViewModel()
    var gradeList = [["1","2","3"],["1","2","3","4"],["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]]
    var seletedPicker = ["1","1","1"]
    let picker = UIPickerView()
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    private let contentView = UIView().then {
        $0.backgroundColor  = .white
    }
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named:"Logo2")
    }
    private let signUpLabel = UILabel().then {
        $0.text = "가입"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    private let emailLabel = UILabel().then {
        $0.text = "Email"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    private let emailTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
    }
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
        configPickerView()
//        textFieldDidChange()
        gradeTextField.rx.text.orEmpty.subscribe({
            print($0)
        }).disposed(by: disposeBag)
    }
    override func bind() {
        let input = SignUpViewModel.Input(emailText: emailTextField.rx.text.orEmpty.asDriver(),
                                          codeText: emailCheckTextField.rx.text.orEmpty.asDriver(),
                                          nameText: nameTextField.rx.text.orEmpty.asDriver(),
                                          passwordText: passwordTextField.rx.text.orEmpty.asDriver(),
                                          gradeText: gradeTextField.rx.text.orEmpty.asDriver(),
                                          classText: classTextField.rx.text.orEmpty.asDriver(),
                                          numberText: numberTextField.rx.text.orEmpty.asDriver(),
                                          emailCheckCodeButtonDidTap: emailCkeckCodeButton.rx.tap.asSignal(),
                                          emailCheckButtonDidTap: emailCheckButton.rx.tap.asSignal(),
                                          signupBttonDidTap: signUpButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.sentEmailCodeResult.asObservable()
            .subscribe(onNext: {
                switch $0 {
                case true:
                    print("성공")
                    self.emailCheckButton.isEnabled = true
                    self.emailCheckButton.backgroundColor = UIColor(named: "MainColor")
                    self.alert(title: "안내", message: "인증번호 전송")
                case false:
                    print("실패")
                }
            }).disposed(by: disposeBag)
        output.codeCheckResult.asObservable()
            .subscribe(onNext: {
                switch $0 {
                case true:
                    print("성공")
                    self.alert(title: "안내", message: "이메일 인증 성공")
                case false:
                    print("실패")
                }
            }).disposed(by: disposeBag)
        output.signUpResult.asObservable()
            .subscribe(onNext: {
                switch $0 {
                case true:
                    print("성공")
                    self.alert(title: "회원가입", message: "회원가입 완료")
                case false:
                    print("실패")
                }
            }).disposed(by: disposeBag)
        output.isEnable.asObservable()
            .subscribe(onNext: {
                switch $0 {
                case true:
                    self.signUpButton.isEnabled = true
                case false:
                    self.signUpButton.isEnabled = false
                }
                
            }).disposed(by: disposeBag)
        
    }
    func textFieldDidChange() {
        let textField = Observable.combineLatest(emailTextField.rx.text.orEmpty,
                                                 passwordTextField.rx.text.orEmpty,
                                                 nameTextField.rx.text.orEmpty,
                                                 emailCheckTextField.rx.text.orEmpty,
                                                 gradeTextField.rx.text.orEmpty,
                                                 classTextField.rx.text.orEmpty,
                                                 numberTextField.rx.text.orEmpty)
        
        textField
            .map { $0.count != 0 && $1.count != 0 && $2.count != 0 && $3.count != 0 && $4.count != 0 && $5.count != 0 && $6.count != 0
            }
            .bind(to: signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    private func alert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            switch title {
            case "회원가입":
                self.dismiss(animated: true)
            default:
                break
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion:nil)
    }
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImageView, signUpLabel, emailLabel, emailTextField, emailCkeckCodeButton, emailNoticeLabel, emailCheckLabel, emailCheckTextField, emailCheckButton, nameLabel, nameTextField, passwordLabel, passwordTextField, passwordStateLabel, passwordCheckLabel, passwordCheckTextField, gradeTextField, classTextField, numberTextField, signUpButton].forEach {
            contentView.addSubview($0)
        }
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(800)
        }
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(104)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(41)
        }
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(42)
            $0.height.equalTo(30)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(signUpLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().inset(40)
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(32)
            $0.width.equalTo(nameTextField.snp.width).inset(40)
            $0.height.equalTo(40)
        }
        emailCkeckCodeButton.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(4)
            $0.width.equalTo(74)
            $0.right.equalToSuperview().inset(32)
            $0.height.equalTo(40)
        }
        emailNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(44)
            $0.width.equalTo(161)
            $0.height.equalTo(20)
        }
        emailCheckLabel.snp.makeConstraints {
            $0.top.equalTo(emailNoticeLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(40)
        }
        emailCheckTextField.snp.makeConstraints {
            $0.top.equalTo(emailCheckLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().inset(32)
            $0.width.equalTo(nameTextField.snp.width).inset(40)
            $0.height.equalTo(40)
        }
        emailCheckButton.snp.makeConstraints {
            $0.top.equalTo(emailCheckLabel.snp.bottom).offset(4)
            $0.width.equalTo(74)
            $0.right.equalToSuperview().inset(32)
            $0.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(emailCheckTextField.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(40)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(40)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(40)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.greaterThanOrEqualTo(40)
        }
        passwordStateLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(44)
            $0.width.equalTo(200)
            $0.height.greaterThanOrEqualTo(40)
        }
        passwordCheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordStateLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(40)
            $0.width.equalTo(88)
            $0.height.equalTo(20)
        }
        passwordCheckTextField.snp.makeConstraints {
            $0.top.equalTo(passwordCheckLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(40)
        }
        gradeTextField.snp.makeConstraints {
            $0.left.equalToSuperview().inset(32)
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(12)
            $0.width.equalTo(nameTextField.snp.width).dividedBy(3).inset(1.5)
            $0.height.greaterThanOrEqualTo(34)
        }
        classTextField.snp.makeConstraints {
            $0.left.equalTo(gradeTextField.snp.right).offset(4.5)
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(12)
            $0.width.equalTo(nameTextField.snp.width).dividedBy(3).inset(1.5)
            $0.height.greaterThanOrEqualTo(34)
        }
        numberTextField.snp.makeConstraints {
            $0.left.equalTo(classTextField.snp.right).offset(4.5)
            $0.top.equalTo(passwordCheckTextField.snp.bottom).offset(12)
            $0.width.equalTo(nameTextField.snp.width).dividedBy(3).inset(1.5)
            $0.height.greaterThanOrEqualTo(34)
        }
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(gradeTextField.snp.bottom).offset(28)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.greaterThanOrEqualTo(36)
        }
    }
}
extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func configPickerView() {
        picker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216)
        picker.delegate = self
        picker.dataSource = self
        
        gradeTextField.inputView = picker
        classTextField.inputView = picker
        numberTextField.inputView = picker
        configToolbar()
    }
    func configToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        
        // 만든 아이템들을 세팅해주고
        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        // 악세사리로 추가한다.
        gradeTextField.inputAccessoryView = toolBar
        classTextField.inputAccessoryView = toolBar
        numberTextField.inputAccessoryView = toolBar
    }
    @objc func donePicker() {
//        let row = self.picker.selectedRow(inComponent: 0)
//        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.gradeTextField.resignFirstResponder()
        self.classTextField.resignFirstResponder()
        self.numberTextField.resignFirstResponder()
    }

    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
    @objc func cancelPicker() {
        self.gradeTextField.text = nil
        self.classTextField.text = nil
        self.numberTextField.text = nil
        self.gradeTextField.resignFirstResponder()
        self.classTextField.resignFirstResponder()
        self.numberTextField.resignFirstResponder()
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return gradeList.count
    }
    // pickerview의 선택지는 데이터의 개수만큼
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeList[component].count
    }
    // pickerview 내 선택지의 값들을 원하는 데이터로 채워준다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradeList[component][row]
    }
    // textfield의 텍스트에 pickerview에서 선택한 값을 넣어준다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            seletedPicker[0] = gradeList[component][row]
            gradeTextField.text = gradeList[component][row]+"학년"
        case 1:
            seletedPicker[1] = gradeList[component][row]
            classTextField.text = gradeList[component][row]+"반"
        case 2:
            seletedPicker[2] = gradeList[component][row]
            numberTextField.text = gradeList[component][row]+"번"
        default:
            print("Error!!")
        }
    }
}
