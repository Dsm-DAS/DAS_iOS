import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Kingfisher

class UserProFilVC: BaseVC {
    var skillStack = [String]()
    var userId = 0
    private let viewModel = UserProFilViewModel()
    private let viewAppear = PublishRelay<Void>()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    private let profilImageView = UIImageView().then {
        $0.layer.cornerRadius = 40
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "ClubImageMini")
    }
    private let nameLabel = UILabel().then {
        $0.text = "김박이름"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    private let etcLabel = UILabel().then {
        $0.text = "4학년 3반 5번"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }
    private let majorLabel = UILabel().then {
        $0.text = "웹 프론트엔드"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let lookUpLabel = UILabel().then {
        $0.backgroundColor = UIColor(named: "SignUpButtonColor")
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
        $0.text = "31 조회"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textAlignment = .center
    }
    
    private let linkView = LinkView()
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
    override func bind() {
        let input = UserProFilViewModel.Input(viewAppear: viewAppear.asSignal(), userId: userId)
        let output = viewModel.transform(input)
        output.user.subscribe(onNext: { [self] in
            nameLabel.text = $0.name
            etcLabel.text = "\($0.grade)학년 \($0.class_num)반 \($0.number)번"
            if $0.profile_image_url != nil {
                let url = URL(string: $0.profile_image_url ?? "https://test-imag-upload-bucket.s3.ap-northeast-2.amazonaws.com/imag")
                profilImageView.kf.setImage(with: url)
            } else {
                profilImageView.image = UIImage(named: "Question")
            }
            introduceView.proFilLabel.text = $0.introduce ?? "자기소개 미기입"
            lookUpChartsView.lookUpCountLabel.text = "오늘 \($0.view_counts ?? 0)"
            majorLabel.text = $0.major
            if skillStack.count == 0 && $0.stack != nil{
                skillStack.removeAll()
                for i in $0.stack!.split(separator: " ") {
                    skillStack.append(String(i))
                }
            }
            lookUpLabel.text = "\($0.view_counts ?? 0) 조회" 
            skillStackView.skillStack.accept(skillStack)
            linkView.link[0] = $0.link_info?.github_link ?? "미기입"
            linkView.link[1] = $0.link_info?.instagram_link ?? "미기입"
            linkView.link[2] = $0.link_info?.facebook_link ?? "미기입"
            linkView.linkCollectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewAppear.accept(())
    }
    
    override func addView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            profilImageView,
            nameLabel,
            etcLabel,
            majorLabel,
            lookUpLabel,
            linkView,
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
        lookUpLabel.snp.makeConstraints {
            let label = UILabel().then {
                $0.text = lookUpLabel.text
                $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                $0.sizeToFit()
            }
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(majorLabel.snp.bottom).offset(8)
            $0.height.equalTo(28)
            $0.width.equalTo(label.frame.width + 16)
        }
        linkView.snp.makeConstraints {
            $0.top.equalTo(lookUpLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(28)
        }
        introduceView.snp.makeConstraints {
            $0.top.equalTo(linkView.snp.bottom).offset(16)
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
