import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class SkillStackView: UIView {
    var skillStack = BehaviorRelay<[String]>(value: [])
    let disposeBag = DisposeBag()
    let skillStackLabel = UILabel().then {
        $0.text = "기술 스택"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    let skillStackCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        var layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        $0.register(SkillStackCollectionViewCell.self, forCellWithReuseIdentifier: "SkillStackCollectionViewCell")
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    private func bind() {
        skillStack.bind(to: skillStackCollectionView.rx.items(cellIdentifier: "SkillStackCollectionViewCell", cellType: SkillStackCollectionViewCell.self)) { row, item, cell in
            cell.skillStackLabel.text = item
            cell.backgroundColor = UIColor(named: "SignUpButtonColor")
        }.disposed(by: disposeBag)
    }
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        skillStackCollectionView.delegate = self
        [
            skillStackLabel,
            skillStackCollectionView
        ].forEach { addSubview($0) }
        skillStackLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(12)
        }
        skillStackCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(skillStackLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SkillStackView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            $0.text = skillStack.value[indexPath.row]
            $0.sizeToFit()
        }
        let size = label.frame.size
        return CGSize(width: size.width + 24, height: size.height + 16)
      }
}

