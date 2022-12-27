import UIKit
import SnapKit
import Then

class LinkView: UIView {
    
    var link = [" ", " ", " "]
    let linkCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        $0.register(LinkCollectionViewCell.self, forCellWithReuseIdentifier: "LinkCollectionViewCell")
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        linkCollectionView.delegate = self
        linkCollectionView.dataSource = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        addSubview(linkCollectionView)
        linkCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LinkView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LinkCollectionViewCell", for: indexPath) as! LinkCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.linkImageView.image = UIImage(named: "Github")
        case 1:
            cell.linkImageView.image = UIImage(named: "Instagram")
        default:
            cell.linkImageView.image = UIImage(named: "Facebook")
        }
        cell.linkLabel.text = link[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            $0.text = link[indexPath.row]
            $0.sizeToFit()
        }
        let size = label.frame.size
        return CGSize(width: size.width + 36, height: size.height + 8)
      }
}
