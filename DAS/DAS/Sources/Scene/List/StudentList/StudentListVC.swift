import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class StudentListVC: BaseVC {
    let viewModel = StudentListViewModel()
    var data = BehaviorRelay<[String]>(value: ["1학년", "2학년", "3학년", "1반", "2반", "3반", "4반"])
    let userList = PublishRelay<Void>()
    private let filterLabel = UILabel().then {
        $0.text = "필터"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .darkGray
    }
    private let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 44, height: 36)
        $0.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCollectionViewCell")
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
    override func viewDidAppear(_ animated: Bool) {
        userList.accept(())
    }
    override func bind() {
        let input = StudentListViewModel.Input(userList: userList.asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.userList.bind(to: studentCollectionView.rx.items(cellIdentifier: "StudentCollectionViewCell", cellType: StudentCollectionViewCell.self)) { row, item, cell in
            let url = URL(string: item.profile_image_url)
            cell.studentImageView.kf.setImage(with: url)
            cell.studentNameLabel.text = item.name
            cell.lookUpCount.text = "\(item.view_counts) 조회"
            cell.userId = item.user_id
        }.disposed(by: disposeBag)
    }
    override func configureVC() {
        filterCollectionView.delegate = self
        studentCollectionView.delegate = self
        data.bind(to: filterCollectionView.rx.items(cellIdentifier: "FilterCollectionViewCell", cellType: FilterCollectionViewCell.self)) { row, item, cell in
            cell.nameLabel.text = item
            cell.backgroundColor = UIColor(named: "SignUpButtonColor")
        }.disposed(by: disposeBag)
    }
    override func addView() {
        [
            studentCollectionView,
            filterCollectionView,
            filterLabel
        ].forEach{ view.addSubview($0) }
    
    }
    override func setLayout() {
        filterCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(220)
            $0.height.equalTo(80)
        }
        studentCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(790)
        }
        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(28)
            
        }
    }
}

extension StudentListVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case studentCollectionView:
            return CGSize(width: 170, height: 60)
        case filterCollectionView:
            let label = UILabel().then {
                $0.text = data.value[indexPath.row]
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
            let cell = collectionView.cellForItem(at: indexPath) as!
            StudentCollectionViewCell
            let vc = UserProFilVC()
            vc.userId = cell.userId
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let cell = collectionView.cellForItem(at: indexPath) as!
            FilterCollectionViewCell
            
            if cell.backgroundColor != UIColor(named: "MainColor") {
                cell.backgroundColor = .init(named: "MainColor")
                cell.nameLabel.textColor = .white
            } else{
                cell.backgroundColor = UIColor(named: "SignUpButtonColor")
                cell.nameLabel.textColor = .black
            }
        }
    }
}

