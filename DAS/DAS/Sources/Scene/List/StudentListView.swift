
import UIKit
import Then
import SnapKit

class StudentListView: UIView {
    let data = ["1학년", "2학년", "3학년", "1반", "2반", "3반", "4반"]
    
    let filterLabel = UILabel().then {
        $0.text = "필터"
        $0.textColor = .gray
    }
    
    let filterStudentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 44, height: 36)
        $0.register(StudentFilterCollectionViewCell.self, forCellWithReuseIdentifier: "StudentFilterCollectionViewCell")
        $0.collectionViewLayout = layout
    }
    
    private let studentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 8
        layout.itemSize = CGSize(width: 170, height: 60)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(StudentCollectionViewCell.self, forCellWithReuseIdentifier: "StudentCollectionViewCell")
        return view
        
    }()
    
    
    private func addView() {
        [
            studentCollectionView,
            filterStudentCollectionView,
            filterLabel
        ].forEach{ self.addSubview($0) }
    
    }
    override func layoutSubviews() {
        studentCollectionView.delegate = self
        studentCollectionView.dataSource = self
        filterStudentCollectionView.delegate = self
        filterStudentCollectionView.dataSource = self
        addView()
        filterStudentCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(211)
            $0.height.equalTo(80)
        }
        studentCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterStudentCollectionView.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(790)
        }
        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(28)
            
        }
    }
    

}




extension StudentListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case studentCollectionView:
            return 10
        case filterStudentCollectionView:
            return 7
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case studentCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath)
            return cell
            
        case filterStudentCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentFilterCollectionViewCell", for: indexPath) as! StudentFilterCollectionViewCell
            cell.nameLabel.text = data[indexPath.row]
            return cell
        default:
            print("dd")
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case studentCollectionView:
            return CGSize(width: 170, height: 60)
        case filterStudentCollectionView:
            let label = UILabel().then {
                $0.text = data[indexPath.row]
                $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                $0.sizeToFit()
            }
            return CGSize(width: label.frame.width + 24, height: 36)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        switch collectionView {
        case studentCollectionView:
            return
        case filterStudentCollectionView:
            print("\(indexPath.row)")
            let cell = collectionView.cellForItem(at: indexPath) as!
            StudentFilterCollectionViewCell
            
            if cell.backgroundColor != UIColor(named: "MainColor") {
                cell.backgroundColor = .init(named: "MainColor")
                cell.nameLabel.textColor = .white
            }else{
                cell.backgroundColor = .white
                cell.nameLabel.textColor = .black
            }
        default:
            return
        }
    }
}



