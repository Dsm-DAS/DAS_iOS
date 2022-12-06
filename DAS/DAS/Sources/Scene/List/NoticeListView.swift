import UIKit
import Then
import SnapKit

class NoticeListView: UIView {
    let noticeListTableView = UITableView().then {
        $0.register(NoticeTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.backgroundColor = .white
        $0.rowHeight = 76
        
    }
    override func layoutSubviews() {
        noticeListTableView.delegate = self
        noticeListTableView.dataSource = self
        addView()
        setLayout()
    }
    private func addView() {
        addSubview(noticeListTableView)
    }
    private func setLayout() {
        noticeListTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview()
        }
    }
}

extension NoticeListView: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoticeTableViewCell {
            cell.titleLabel.text = "어쩌구 저쩌구 모집합니다"
            cell.subTitleLabel.text = "프론트엔드, 백엔드, 인공지능 등"
            return cell
            
        }else{
          return UITableViewCell()
            
        }
    }
}
