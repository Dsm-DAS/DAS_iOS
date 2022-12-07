import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift


class MainVC: BaseVC {
    var images = ["ClubImage", "ClubImage", "ClubImage", "ClubImage", "ClubImage", "ClubImage"]
    let viewModel = MainViewModel()
    private let refresh = PublishRelay<Void>()
    private let clubScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
    }
    private let clubContentView = UIView()
    
    private let clubNameLabel = UILabel().then {
        $0.text = "동아리 이름을 입력"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .white
    }
    private let pageControl = UIPageControl().then {
        $0.addTarget(MainVC.self, action: #selector(pageControlDidTap), for: .valueChanged)
    }

    private let collectionScrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    private let collectionContentView = UIView()
    
    private let clubLabel = UILabel().then {
        $0.text = "동아리"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    private let clubAllButton = UIButton(type: .system).then {
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.setTitle("모두 보기", for: .normal)
        $0.setTitleColor(UIColor(named: "MainColor"), for: .normal)
    }
    private let studentLabel = UILabel().then {
        $0.text = "학생"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .black
    }
    
    private let studentAllButton = UIButton(type: .system).then {
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.setTitle("모두 보기", for: .normal)
        $0.setTitleColor(UIColor(named: "MainColor"), for: .normal)
    }
    
    private let clubCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 12.0)
        layout.itemSize = CGSize(width: 312, height: 126)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ClubCollectionViewCell.self, forCellWithReuseIdentifier: "ClubCollectionViewCell")
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let studentCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.itemSize = CGSize(width: 170, height: 60)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(StudentCollectionViewCell.self, forCellWithReuseIdentifier: "StudentCollectionViewCell")
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override func configureVC() {
        self.view.backgroundColor = UIColor(named: "topViewBackGround")
        delegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        refresh.accept(())
    }
//    override func bind() {
//        let input = MainViewModel.Input(refreshToken: refresh.asSignal())
//        let output = viewModel.transform(input)
//        output.result.subscribe(onNext: {
//            switch $0 {
//            case true:
//                return
//            default:
//                let vc = LoginVC()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true)
//            }
//        }).disposed(by: disposeBag)
//    }
    @objc
    private func pageControlDidTap(_ sender: UIPageControl) {
        let current = sender.currentPage
        clubScrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    private func delegates() {
        clubCollectionView.delegate = self
        clubCollectionView.dataSource = self
        studentCollectionView.delegate = self
        studentCollectionView.dataSource = self
        clubScrollView.delegate = self
        collectionScrollView.delegate = self
    }
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[i])
            clubContentView.addSubview(imageView)
            imageView.snp.makeConstraints {
                $0.centerX.equalTo(view.frame.width / 2 + view.frame.width * CGFloat(i))
                $0.height.equalToSuperview()
                $0.width.equalTo(clubScrollView.snp.width).multipliedBy(0.9)
                $0.top.equalToSuperview()
            }
        }
    }
    
    // MARK: - Layout
    override func addView() {
        [
            clubScrollView,
            clubNameLabel,
            pageControl,
            collectionScrollView
        ].forEach { view.addSubview($0) }
        self.clubScrollView.addSubview(clubContentView)
        clubScrollView.contentSize = clubContentView.frame.size
        [
            clubLabel,
            clubAllButton,
            clubCollectionView,
            studentLabel,
            studentAllButton,
            studentCollectionView
        ].forEach {collectionContentView.addSubview($0)}
        self.collectionScrollView.addSubview(collectionContentView)
        collectionScrollView.contentSize = collectionContentView.frame.size
        addContentScrollView()
        setPageControl()
    }
    
    override func setLayout() {
        clubScrollView.snp.makeConstraints {
            $0.topMargin.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(139)
            $0.width.equalToSuperview()
        }
        clubContentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.width.equalTo(view.frame.width * CGFloat(images.count))
            $0.height.equalToSuperview()
        }
        clubNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(clubScrollView.snp.bottom).offset(4)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(clubNameLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        collectionScrollView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(12)
            $0.left.right.bottom.equalToSuperview()
        }
        collectionContentView.snp.makeConstraints {
            $0.edges.equalTo(collectionScrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
            $0.height.equalTo(790)
        }
        clubLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.left.equalToSuperview().inset(21)
            $0.height.equalTo(30)
        }
        clubAllButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.left.equalTo(clubLabel.snp.right).offset(16)
            $0.height.equalTo(20)
        }
        clubCollectionView.snp.makeConstraints {
            $0.top.equalTo(clubLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(268)
        }   
        studentLabel.snp.makeConstraints {
            $0.top.equalTo(clubCollectionView.snp.bottom).offset(40)
            $0.left.equalToSuperview().inset(22)
            $0.height.equalTo(30)
        }
        studentAllButton.snp.makeConstraints {
            $0.top.equalTo(clubCollectionView.snp.bottom).offset(45)
            $0.left.equalTo(studentLabel.snp.right).offset(16)
            $0.height.equalTo(20)
        }
        studentCollectionView.snp.makeConstraints {
            $0.top.equalTo(studentLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(380)
        }
    }
}
extension MainVC : UIScrollViewDelegate {
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == clubScrollView {
            let value = scrollView.contentOffset.x/scrollView.bounds.size.width
            setPageControlSelectedPage(currentPage: Int(round(value)))
        }
    }
}

extension MainVC :UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clubCollectionView {
            return 10
        } else if collectionView == studentCollectionView {
            return 20
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clubCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClubCollectionViewCell", for: indexPath) as! ClubCollectionViewCell
            cell.clubImageView.image = UIImage(named: "ClubImageMini" )
            cell.clubNameLabel.text = "동아리 이름"
            
            return cell
        } else if collectionView == studentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath) as! StudentCollectionViewCell
            cell.studentImageView.image = UIImage(named: "CellImage")
            return cell
        } else {
            return UICollectionViewCell()
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case clubCollectionView:
            let vc = ClubVC()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("nil")
        }
    }
}
