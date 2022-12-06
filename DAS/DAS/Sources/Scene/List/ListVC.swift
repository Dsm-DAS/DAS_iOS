

import UIKit
import Then
import SnapKit

class ListVC: BaseVC {

    let ListSegmentedControl = UISegmentedControl(items: ["모집공고","동아리","학생"]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal)
    }
    
    let noticeList = NoticeListView()
    
    let clubList = ClubListView()
    
    let studentList = StudentListView()
    
    
    
  
    override func configureVC() {
        valueChanged()
        ListSegmentedControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    
    @objc func valueChanged() {
        switch ListSegmentedControl.selectedSegmentIndex {
        case 0:
            noticeList.isHidden = false
            clubList.isHidden = true
            studentList.isHidden = true
        case 1:
            noticeList.isHidden = true
            clubList.isHidden = false
            studentList.isHidden = true
            
        default:
            clubList.isHidden = true
            noticeList.isHidden = true
            studentList.isHidden = false
        }
    }
    
    
    override func addView() {
        [
            ListSegmentedControl,
            noticeList,
            clubList,
            studentList
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        ListSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.top.equalToSuperview().inset(44)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(44)
            $0.width.equalTo(358)
        }
        noticeList.snp.makeConstraints {
            $0.top.equalTo(ListSegmentedControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        clubList.snp.makeConstraints {
            $0.top.equalTo(ListSegmentedControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        studentList.snp.makeConstraints {
            $0.top.equalTo(ListSegmentedControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    
    
    
    
    
    
}
