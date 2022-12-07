import UIKit
import SnapKit
import Then

class SkillStackView: UIView {
    let skillStack = ["React.js", "Next.js", "Node.js", "JavaScript", "Java", "Swift", "Python", "object - C"]
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
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        skillStackCollectionView.delegate = self
        skillStackCollectionView.dataSource = self
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
            $0.height.equalTo(85)
        }
    }
}

extension SkillStackView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        skillStack.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillStackCollectionViewCell", for: indexPath) as! SkillStackCollectionViewCell
        cell.skillStackLabel.text = skillStack[indexPath.row]
        cell.backgroundColor = UIColor(named: "SignUpButtonColor")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            $0.text = skillStack[indexPath.row]
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 24, height: size.height + 16)
      }
}

