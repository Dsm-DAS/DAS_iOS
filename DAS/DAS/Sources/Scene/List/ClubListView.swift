

import UIKit
import Then
import SnapKit
class ClubListView: UIView {

    
    
    let clubListTableView = UITableView().then {
        $0.register(ClubTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.backgroundColor = .white
        $0.rowHeight = 129
    }

    override func layoutSubviews() {
        clubListTableView.delegate = self
        clubListTableView.dataSource = self
        addView()
        setLayout()
    }
    private func addView() {
        addSubview(clubListTableView)
    }
    private func setLayout() {
        clubListTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()

        }

        
    }
    
}
extension ClubListView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ClubTableViewCell {
          
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    
    
}
