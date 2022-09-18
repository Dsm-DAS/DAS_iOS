import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "Logo")
    }
    let noticeButton = UIBarButtonItem(
        image: UIImage(named: "Notice"),
        style: .plain,
        target: nil,
        action: #selector(noticeButtonDidTap)
    ).then {
        $0.tintColor = .white
    }

    let clubScrollView = UIScrollView()
    
    let contentView = UIView()
    
    let clubImageView1 = UIImageView().then {
        $0.image = UIImage(named: "ClubImage")
    }
    let clubImageView2 = UIImageView().then {
        $0.image = UIImage(named: "ClubImage")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(named: "topViewBackGround")
        
    }
    override func viewWillLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
        setNavigation()
    }

    @objc
    private func noticeButtonDidTap() {
    }

    private func setNavigation() {
        self.navigationItem.leftBarButtonItem = .init(customView: logoImageView)
        self.navigationItem.rightBarButtonItem = noticeButton
    }
    // MARK: - Layout
    private func addSubviews() {
        [clubScrollView].forEach { view.addSubview($0) }
        self.clubScrollView.addSubview(contentView)
        clubScrollView.contentSize = contentView.frame.size
        [clubImageView1, clubImageView2].forEach {contentView.addSubview($0)}
    }

    private func makeSubviewConstraints() {
        clubScrollView.snp.makeConstraints {
            $0.topMargin.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(139)
            $0.width.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.width.equalTo(view.frame.width * 2)
            $0.height.equalToSuperview()
        }
        clubImageView1.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
        }
        clubImageView2.snp.makeConstraints {
            $0.left.equalTo(clubImageView1.snp.right).offset(20)
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
}
