import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
class EmailViewController: BaseVC {
    let viewModel = SignUpViewModel()
//    var gradeList = [["1","2","3"],["1","2","3","4"],["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]]
//    var seletedPicker = ["1","1","1"]
//    let picker = UIPickerView()
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
//extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    func configPickerView() {
//        picker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216)
//        picker.delegate = self
//        picker.dataSource = self
//
//        gradeTextField.inputView = picker
//        classTextField.inputView = picker
//        numberTextField.inputView = picker
//        configToolbar()
//    }
//    func configToolbar() {
//        let toolBar = UIToolbar()
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor.black
//        toolBar.sizeToFit()
//
//        let doneBT = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.donePicker))
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelBT = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
//
//        // 만든 아이템들을 세팅해주고
//        toolBar.setItems([cancelBT,flexibleSpace,doneBT], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
//        // 악세사리로 추가한다.
//        gradeTextField.inputAccessoryView = toolBar
//        classTextField.inputAccessoryView = toolBar
//        numberTextField.inputAccessoryView = toolBar
//    }
//    @objc func donePicker() {
////        let row = self.picker.selectedRow(inComponent: 0)
////        self.picker.selectRow(row, inComponent: 0, animated: false)
//        self.gradeTextField.resignFirstResponder()
//        self.classTextField.resignFirstResponder()
//        self.numberTextField.resignFirstResponder()
//    }
//
//    // "취소" 클릭 시 textfield의 텍스트 값을 nil로 처리 후 입력창 내리기
//    @objc func cancelPicker() {
//        self.gradeTextField.text = nil
//        self.classTextField.text = nil
//        self.numberTextField.text = nil
//        self.gradeTextField.resignFirstResponder()
//        self.classTextField.resignFirstResponder()
//        self.numberTextField.resignFirstResponder()
//    }
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return gradeList.count
//    }
//    // pickerview의 선택지는 데이터의 개수만큼
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return gradeList[component].count
//    }
//    // pickerview 내 선택지의 값들을 원하는 데이터로 채워준다.
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return gradeList[component][row]
//    }
//    // textfield의 텍스트에 pickerview에서 선택한 값을 넣어준다.
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch component {
//        case 0:
//            seletedPicker[0] = gradeList[component][row]
//            gradeTextField.text = gradeList[component][row]+"학년"
//        case 1:
//            seletedPicker[1] = gradeList[component][row]
//            classTextField.text = gradeList[component][row]+"반"
//        case 2:
//            seletedPicker[2] = gradeList[component][row]
//            numberTextField.text = gradeList[component][row]+"번"
//        default:
//            print("Error!!")
//        }
//    }
//}
