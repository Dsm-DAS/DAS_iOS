import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Kingfisher

class MyPageVC: BaseVC {
    let viewModel = MyPageViewModel()
    private let viewAppear = PublishRelay<Void>()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    private let profilImageView = UIImageView().then {
        $0.image = UIImage(named: "ClubImageMini")
    }
    private let nameLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    private let etcLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }
    private let majorLabel = UILabel().then {
        $0.text = "웹 프론트엔드"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let editButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.setTitle("계정 정보 수정", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    private let introduceView = IntroduceView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let skillStackView = SkillStackView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let myClubView = MyClubView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let lookUpChartsView = LookUpChartsView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    override func configureVC() {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewAppear.accept(())
    }
    override func bind() {
        let input = MyPageViewModel.Input(viewAppear: viewAppear.asDriver(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.myPage.subscribe(onNext: { [self] in
            nameLabel.text = $0.name
            etcLabel.text = "\($0.grade)학년 \($0.class_num)반 \($0.number)번"
            if $0.profile_image_url != nil {
                let url = URL(string: $0.profile_image_url ?? "")
                profilImageView.kf.setImage(with: url)
            }
            introduceView.proFilLabel.text = $0.introduce
            lookUpChartsView.lookUpCountLabel.text = "오늘 \($0.view_counts)"
        }).disposed(by: disposeBag)
    }
    
    override func addView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            profilImageView,
            nameLabel,
            etcLabel,
            majorLabel,
            editButton,
            introduceView,
            skillStackView,
            myClubView,
            lookUpChartsView
        ].forEach { contentView.addSubview($0) }
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(912)
            $0.width.equalToSuperview()
        }
        profilImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(80)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(profilImageView.snp.bottom).offset(12)
        }
        etcLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(12)
            $0.top.equalTo(profilImageView.snp.bottom).offset(15)
        }
        majorLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        editButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(139)
            $0.height.equalTo(34)
            $0.top.equalTo(majorLabel.snp.bottom).offset(12)
        }
        introduceView.snp.makeConstraints {
            $0.top.equalTo(editButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(108)
        }
        skillStackView.snp.makeConstraints {
            $0.top.equalTo(introduceView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(132)
        }
        myClubView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(skillStackView.snp.bottom).offset(20)
            $0.height.equalTo(118)
        }
        lookUpChartsView.snp.makeConstraints {
            $0.height.equalTo(202)
            $0.top.equalTo(myClubView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
