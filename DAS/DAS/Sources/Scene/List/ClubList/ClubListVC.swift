import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import Kingfisher

class ClubListVC: BaseVC {
    let viewModel = ClubListViewModel()
    var clubId = 0
    var data = BehaviorRelay<[String]>(value: ["동아리", "창.체", "자율"])
    let clubList = PublishRelay<Void>()
    private let filterLabel = UILabel().then {
        $0.text = "필터"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .darkGray
    }
    private let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 44, height: 36)
        $0.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCollectionViewCell")
        $0.collectionViewLayout = layout
    }
    
    private let clubListTableView = UITableView().then {
        $0.register(ClubTableViewCell.self, forCellReuseIdentifier: "ClubTableViewCell")
        $0.backgroundColor = .white
        $0.rowHeight = 129
        $0.separatorStyle = .none
    }
    override func viewDidAppear(_ animated: Bool) {
        clubList.accept(())
    }
    override func bind() {
        let input = ClubListViewModel.Input(clubList: clubList.asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.clubList.bind(to: clubListTableView.rx.items(cellIdentifier: "ClubTableViewCell", cellType: ClubTableViewCell.self)) { row, item, cell in
            cell.clubImageView.kf.setImage(with: URL(string: item.club_image_url))
            cell.clubNameLabel.text = item.club_name
            cell.tagLabel.text = "#\(item.club_type) #\(item.club_category)"
            cell.clubId = item.club_id
            cell.heartView.heartCountLabel.text = "\(item.like_counts)"
            let r : CGFloat = CGFloat.random(in: 0.7...1)
            let g : CGFloat = CGFloat.random(in: 0.7...1)
            let b : CGFloat = CGFloat.random(in: 0.7...1)
            UIView.animate(withDuration: 0.5, animations: {
                cell.backView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
            })
        }.disposed(by: disposeBag)
    }
    override func configureVC() {
        filterCollectionView.delegate = self
        clubListTableView.delegate = self
        data.bind(to: filterCollectionView.rx.items(cellIdentifier: "FilterCollectionViewCell", cellType: FilterCollectionViewCell.self)) { row, item, cell in
            cell.nameLabel.text = item
            cell.backgroundColor = UIColor(named: "SignUpButtonColor")
        }.disposed(by: disposeBag)
    }
    override func addView() {
        [
            filterLabel,
            filterCollectionView,
            clubListTableView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(28)
        }
        filterCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        clubListTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()

        }
    }
}

extension ClubListVC: UICollectionViewDelegate, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.text = data.value[indexPath.row]
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            $0.sizeToFit()
        }
        return CGSize(width: label.frame.width + 24, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ClubTableViewCell
        let vc = ClubVC()
        vc.clubId = cell.clubId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
