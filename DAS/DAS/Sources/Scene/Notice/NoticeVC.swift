import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
class NoticeVC: BaseVC {
    private let viewModel = NoticeViewModel()
    private let noticeList = PublishRelay<Void>()
    private let alarmTableView = UITableView().then {
        $0.rowHeight = 76
        $0.register(AlarmTableViewCell.self, forCellReuseIdentifier: "AlarmTableViewCell")
        $0.showsVerticalScrollIndicator = false
    }
    private let emptyView = EmptyView().then {
        $0.isHidden = true
        $0.emptyImageView.image = UIImage(named: "NoticeEmpty")
        $0.emptyLabel.text = "알림이 없습니다"
    }
    override func configureVC() {
        alarmTableView.delegate = self
    }
    override func bind() {
        let input = NoticeViewModel.Input(noticeList: noticeList.asSignal())
        let output = viewModel.transform(input)
        output.noticeList.bind(to: alarmTableView.rx.items(cellIdentifier: "AlarmTableViewCell", cellType: AlarmTableViewCell.self)) { row, item, cell in
            cell.titleLabel.text = item.title
         
            let nowDate = item.created_at
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let str = dateFormatter.date(from: nowDate)
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "MM/dd HH:mma"
            let created_at = myDateFormatter.string(from: str ?? Date())
            cell.timeLabel.text = created_at
        }.disposed(by: disposeBag)
        output.count.subscribe(onNext: {
            if $0 == 0 {
                self.emptyView.isHidden = false
            } else {
                self.emptyView.isHidden = true
            }
        }).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubview(alarmTableView)
        view.addSubview(emptyView)
    }
    override func setLayout() {
        alarmTableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        noticeList.accept(())
    }
    
}

extension NoticeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AlarmTableViewCell
        cell.isTouch = true
        if cell.isTouch {
            cell.imageBackView.backgroundColor = UIColor(named: "NoticeSeleted")
            
        } else {
            cell.imageBackView.backgroundColor = UIColor(named: "MainColor")
        }
    }
}
