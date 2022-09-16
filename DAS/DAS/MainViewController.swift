import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    let topView = UIView().then {
        $0.backgroundColor = UIColor(named: "topViewBackGround")
    }
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
        $0.sizeToFit()
    }
    let noticeButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "Notice"), for: .normal)
        $0.tintColor = .white
    }
    let clubScrollView = UIScrollView().then {
        $0.backgroundColor = UIColor(named: "topViewBackGround")
    }
    
    let clubImageView1 = UIImageView().then {
        $0.image = UIImage(named: "ClubImage")
    }
    let clubImageView2 = UIImageView().then {
        $0.image = UIImage(named: "ClubImage")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillLayoutSubviews() {
        makeSubviewConstraints()
        makeTopViewConstraints()
        makeClubScrollViewConstraints()
    }
    
    private func makeSubviewConstraints() {
        [topView].forEach {view.addSubview($0)}
        topView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
    private func makeTopViewConstraints() {
        [logoImageView, noticeButton, clubScrollView].forEach {topView.addSubview($0)}
        logoImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(70)
        }
        noticeButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(70)
        }
        clubScrollView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    private func makeClubScrollViewConstraints() {
        [clubImageView1,clubImageView2].forEach {clubScrollView.addSubview($0)}
        clubImageView1.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30)
            $0.width.equalTo(366)
            $0.height.equalTo(139)
        }
        clubImageView2.snp.makeConstraints {
            $0.width.equalTo(366)
            $0.height.equalTo(139)
        }
    }
}
