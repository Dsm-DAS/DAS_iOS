import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class CommentEditVC: BaseVC {
    var commentId = 0
    let viewModel = CommentEditViewModel()
    private let titleLabel = UILabel().then {
        $0.text = "댓글"
        $0.textColor = UIColor(named: "TextColor")
    }
    private let editTextField = UITextField().then {
        $0.addLeftPadding()
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "BackGroundColor2")?.cgColor
        $0.backgroundColor = UIColor(named: "BackGroundColor")
    }
    private let cancelButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "SignUpButtonColor")
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.layer.cornerRadius = 8
    }
    private let editButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.setTitle("수정", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
    }
    override func configureVC() {
        cancelButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
    override func bind() {
        let input = CommentEditViewModel.Input(commentId: commentId, content: editTextField.rx.text.orEmpty.asDriver(), patchButtonDidTap: editButton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.patchResult.subscribe(onNext: {
            switch $0 {
            case true:
                print("성공")
                self.dismiss(animated: true)
            default:
                print("실패")
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            titleLabel,
            editTextField,
            cancelButton,
            editButton
        ].forEach { view.addSubview($0) }
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(28)
            $0.top.equalToSuperview().inset(29)
        }
        editTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        editButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(editTextField.snp.bottom).offset(12)
            $0.height.equalTo(34)
            $0.width.equalTo(68)
        }
        cancelButton.snp.makeConstraints {
            $0.trailing.equalTo(editButton.snp.leading).offset(-8)
            $0.top.equalTo(editTextField.snp.bottom).offset(12)
            $0.height.equalTo(34)
            $0.width.equalTo(68)
        }
    }
    
}
