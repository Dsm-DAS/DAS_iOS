import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

class ClubVC: BaseVC {
    var clubId = 0
    private let viewModel = ClubViewModel()
    private let clubList = PublishRelay<Void>()
    private let backView = UIView().then {
        let r : CGFloat = CGFloat.random(in: 0.7...1)
        let g : CGFloat = CGFloat.random(in: 0.7...1)
        let b : CGFloat = CGFloat.random(in: 0.7...1)
        $0.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    private let clubImageView = UIImageView().then {
        $0.image = UIImage(named: "ClubImageMini")
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().then {
        $0.text = "멋진로고동아리"
        $0.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    private let clubTypeLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .white
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor(named: "ClubType")
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textAlignment = .center
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
        $0.backgroundColor = UIColor(named: "SignUpButtonColor")
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
        $0.text = "31 조회"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .center
    }
    private let heartView = HeartView().then {
        $0.heartButton.isEnabled = true
        $0.heartCountLabel.text = "23"
        $0.layer.cornerRadius = 14
        $0.heartButton.tintColor = .black
        $0.heartCountLabel.textColor = .black
        $0.backgroundColor = UIColor(named: "SignUpButtonColor")
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        clubList.accept(())
        clubMemberCollectionView.reloadData()
    }
    override func bind() {
        let input = ClubViewModel.Input(clubId: clubId, clubDetailList: clubList.asSignal())
        let output = viewModel.transform(input)
        output.userList.bind(to: clubMemberCollectionView.rx.items(cellIdentifier: "StudentCollectionViewCell", cellType: StudentCollectionViewCell.self)) { row, item, cell in
            cell.studentNameLabel.text = item.name
            cell.studentImageView.kf.setImage(with: URL(string: item.profile_image_url))
            cell.lookUpCount.isHidden = true
        }.disposed(by: disposeBag)
        output.clubDetailList.subscribe(onNext: { [self] in
            titleLabel.text = $0.club_name
            clubImageView.kf.setImage(with: URL(string: $0.club_image_url))
            if $0.club_type == "MAIN" {
                clubTypeLabel.text = "전공"
            }
            tagLabel.text = "#\($0.club_category)"
            subTitle.text = $0.club_introduce
            lookUpLabel.text = "\($0.club_views) 조회"
        }).disposed(by: disposeBag)
    }
    
    override func addView() {
        [
            backView,
            clubImageView,
            titleLabel,
            clubTypeLabel,
            tagLabel,
            subTitle,
            heartView,
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
            $0.centerX.equalToSuperview().offset(-20)
            $0.top.equalTo(clubImageView.snp.bottom).offset(18)
        }
        clubTypeLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.top.equalTo(clubImageView.snp.bottom).offset(24)
            $0.width.equalTo(36)
            $0.height.equalTo(24)
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
        heartView.snp.makeConstraints {
            $0.top.equalTo(subTitle.snp.bottom).offset(4)
            $0.trailing.equalTo(lookUpLabel.snp.leading).offset(-8)
            $0.height.equalTo(28)
        }
        lookUpLabel.snp.makeConstraints {
            let label = UILabel().then {
                $0.text = lookUpLabel.text
                $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                $0.sizeToFit()
            }
            $0.top.equalTo(subTitle.snp.bottom).offset(4)
            $0.centerX.equalToSuperview().offset(35)
            $0.width.equalTo(label.frame.width + 16)
            $0.height.equalTo(28)
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
