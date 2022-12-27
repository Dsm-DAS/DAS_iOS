import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class ListVC: BaseVC {

    let ListSegmentedControl = UISegmentedControl(items: ["모집공고","동아리","학생"]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .normal)
    }
    
    let noticeList = NoticeListVC()
    
    let clubList = ClubListVC()
    
    let studentList = StudentListVC()
    
    override func configureVC() {
        ListSegmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [self] in
            switch $0 {
            case 0:
                noticeList.view.isHidden = false
                clubList.view.isHidden = true
                studentList.view.isHidden = true
            case 1:
                noticeList.view.isHidden = true
                clubList.view.isHidden = false
                studentList.view.isHidden = true
                
            default:
                clubList.view.isHidden = true
                noticeList.view.isHidden = true
                studentList.view.isHidden = false
            }
            }).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func addView() {
        [
            noticeList,
            clubList,
            studentList
        ].forEach { self.addChild($0) }
        [
            ListSegmentedControl,
            noticeList.view,
            clubList.view,
            studentList.view
        ].forEach { view.addSubview($0) }
    }
    override func setLayout() {
        ListSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        noticeList.view.snp.makeConstraints {
            $0.top.equalTo(ListSegmentedControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        clubList.view.snp.makeConstraints {
            $0.top.equalTo(ListSegmentedControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        studentList.view.snp.makeConstraints {
            $0.top.equalTo(ListSegmentedControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
