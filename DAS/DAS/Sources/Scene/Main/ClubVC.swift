import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ClubVC: BaseVC {
    private let backView = UIView().then {
        $0.backgroundColor = .purple
    }
    private let clubImageView = UIImageView().then {
        $0.image = UIImage(named: "ClubImageMini")
    }
    private let titleLabel = UILabel().then {
        $0.text = "멋진로고동아리"
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    private let tagLabel = UILabel().then {
        $0.text = "#백엔드 #프론트엔드 #웹 #뭐시기"
        $0.textColor = UIColor(named: "TextColor")
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    private let subTitle = UILabel().then {
        $0.text = "동아리소개 하나 둘 셋 넷 두번째줄 이다 하나둘 셋넷다섯 반가워요 로고가멋진동아리이빈다"
        $0.textAlignment = .center
        $0.numberOfLines = 3
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    private let lookUpLabel = UILabel().then {
        $0.text = "조회 148"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
        $0.textColor = UIColor(named: "LookUp")
    }
    private let clubMemberLabel = UILabel().then {
        $0.text = "부원"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    private let clubMemberCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.itemSize = CGSize(width: 175, height: 60)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(StudentCollectionViewCell.self, forCellWithReuseIdentifier: "StudentCollectionViewCell")
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override func configureVC() {
        self.navigationController?.isNavigationBarHidden = false
        clubMemberCollectionView.delegate = self
        clubMemberCollectionView.dataSource = self
    }
    
    override func addView() {
        [
            backView,
            clubImageView,
            titleLabel,
            tagLabel,
            subTitle,
            lookUpLabel,
            clubMemberLabel,
            clubMemberCollectionView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        backView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        clubImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backView.snp.bottom).offset(-44)
            $0.width.height.equalTo(88)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalTo(clubImageView.snp.bottom).offset(18)
        }
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        subTitle.snp.makeConstraints {
            $0.top.equalTo(tagLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(267)
        }
        lookUpLabel.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        clubMemberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.top.equalTo(lookUpLabel.snp.bottom).offset(28)
        }
        clubMemberCollectionView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(clubMemberLabel.snp.bottom).offset(12)
        }
    }
}

extension ClubVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath) as! StudentCollectionViewCell
        cell.studentImageView.image = UIImage(named: "CellImage")
        return cell
    }
}
