import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift
import Kingfisher

class NoticeListVC: BaseVC {
    let viewModel = NoticeListViewModel()
    private var feedId = 0
    var data = BehaviorRelay<[String]>(value: ["동아리", "봉사활동", "기타", "최신순", "조회수순"])
    let feedList = PublishRelay<Void>()
    private let filterLabel = UILabel().then {
        $0.text = "필터"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .darkGray
    }
    
    let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 44, height: 36)
        $0.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "FilterCollectionViewCell")
        $0.collectionViewLayout = layout
    }
    
    let noticeListTableView = UITableView().then {
        $0.register(NoticeTableViewCell.self, forCellReuseIdentifier: "NoticeTableViewCell")
        $0.backgroundColor = .white
        $0.rowHeight = 76
    }
    override func viewWillAppear(_ animated: Bool) {
        feedList.accept(())
        noticeListTableView.reloadData()
    }
    override func bind() {
        let input = NoticeListViewModel.Input(noticeList: feedList.asSignal(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.noticeList.bind(to: noticeListTableView.rx.items(cellIdentifier: "NoticeTableViewCell", cellType: NoticeTableViewCell.self)) { row, item, cell in
            cell.titleLabel.text = item.title
            cell.subTitleLabel.text = item.major
            let url = URL(string: item.writer.profile_image_url)
            cell.clubImageView.kf.setImage(with: url)
            cell.feedId = item.feed_id
        }.disposed(by: disposeBag)
    }
    override func configureVC() {
        filterCollectionView.delegate = self
        noticeListTableView.delegate = self
        data.bind(to: filterCollectionView.rx.items(cellIdentifier: "FilterCollectionViewCell", cellType: FilterCollectionViewCell.self)) { row, item, cell in
            cell.nameLabel.text = item
            cell.backgroundColor = UIColor(named: "SignUpButtonColor")
        }.disposed(by: disposeBag)
    }
    override func addView() {
        [
            filterLabel,
            filterCollectionView,
            noticeListTableView
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        filterLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(28)
        }
        filterCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(220)
            $0.height.equalTo(80)
        }
        noticeListTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(filterCollectionView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
}

extension NoticeListVC: UICollectionViewDelegate, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.text = data.value[indexPath.row]
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            $0.sizeToFit()
        }
        return CGSize(width: label.frame.width + 24, height: 36)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
        if cell.backgroundColor != UIColor(named: "MainColor") {
            cell.backgroundColor = UIColor(named: "MainColor")
            cell.nameLabel.textColor = .white
        } else {
            cell.backgroundColor = UIColor(named: "SignUpButtonColor")
            cell.nameLabel.textColor = .black
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NoticeTableViewCell
        let vc = NoticeListDetailVC()
        vc.feedId = cell.feedId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
