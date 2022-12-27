import UIKit
import SnapKit
import Then

class MyClubView: UIView {
    let title = ["DMS","모딥","행사부","Gram"]
    let image = ["DMS","모딥","ClubImageMini","ClubImageMini"]
    private let myClubLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.text = "소속동아리"
    }
    let myClubeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        var layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 218, height: 66)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        $0.register(MyClubCollectionViewCell.self, forCellWithReuseIdentifier: "MyClubCollectionViewCell")
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
        myClubeCollectionView.delegate = self
        myClubeCollectionView.dataSource = self
        [
            myClubLabel,
            myClubeCollectionView
        ].forEach { addSubview($0) }
        
        myClubLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(12)
        }
        myClubeCollectionView.snp.makeConstraints {
            $0.top.equalTo(myClubLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}

extension MyClubView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyClubCollectionViewCell", for: indexPath) as! MyClubCollectionViewCell
        let r : CGFloat = CGFloat.random(in: 0.7...1)
        let g : CGFloat = CGFloat.random(in: 0.7...1)
        let b : CGFloat = CGFloat.random(in: 0.7...1)
        cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        cell.clubNameLabel.text = title[indexPath.row]
        cell.clubImageView.image = UIImage(named: image[indexPath.row])
        return cell
    }
}
