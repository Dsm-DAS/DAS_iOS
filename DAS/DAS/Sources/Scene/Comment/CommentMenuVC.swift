import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
class CommentMenuVC: BaseVC {
    var commentId = 0
    private let viewModel = CommentMenuViewModel()
    private let removeImageView = UIImageView().then {
        $0.image = UIImage(named: "Delete")
    }
    private let removeLabel = UILabel().then {
        $0.text = "삭제"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    private let removebutton = UIButton(type: .system)
    private let seperateLineView = UIView().then {
        $0.backgroundColor = UIColor(named: "PickerLine")
    }
    private let editImageView = UIImageView().then {
        $0.image = UIImage(named: "Edit")
    }
    private let editLabel = UILabel().then {
        $0.text = "수정"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    private let editbutton = UIButton(type: .system)
    
    override func bind() {
        print(commentId)
        let input = CommentMenuViewModel.Input(commentId: commentId, deleteButtonDidTap: removebutton.rx.tap.asSignal())
        let output = viewModel.transform(input)
        output.deleteResult.subscribe(onNext: {
            switch $0 {
            case true:
                self.dismiss(animated: true)
            default:
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    override func configureVC() {
        editbutton.rx.tap
            .subscribe(onNext: {
                let vc = CommentEditVC()
                vc.commentId = self.commentId
                if #available(iOS 16.0, *) {
                    if let sheet = vc.sheetPresentationController {
                        let id = UISheetPresentationController.Detent.Identifier("frist")
                        let detent = UISheetPresentationController.Detent.custom(identifier: id) { _ in
                            return 159
                        }
                        sheet.detents = [detent]
                        sheet.preferredCornerRadius = 12
                        sheet.prefersGrabberVisible = true
                        self.present(vc, animated: true)
                    }
                    vc.isModalInPresentation = true
                }
            }).disposed(by: disposeBag)
    }
    override func addView() {
        [
            removeImageView,
            removeLabel
        ].forEach { removebutton.addSubview($0) }
        [
            editImageView,
            editLabel
        ].forEach { editbutton.addSubview($0) }
        [
            removebutton,
            editbutton,
            seperateLineView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        removeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        removeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(removeImageView.snp.trailing).offset(4)
        }
        
        editImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        editLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(removeImageView.snp.trailing).offset(4)
        }
        removebutton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(13)
            $0.height.equalTo(55)
        }
        seperateLineView.snp.makeConstraints {
            $0.top.equalTo(removebutton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        editbutton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(seperateLineView.snp.bottom)
            $0.height.equalTo(55)
        }
    }
}
