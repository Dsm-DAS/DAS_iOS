import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import ExpyTableView
import Kingfisher

class EditMyPageVC: BaseVC {
    let viewModel = MyPageViewModel()
    private let viewAppear = PublishRelay<Void>()
    private let viewDisAppear = PublishRelay<Void>()
    var skillStack = [String]()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let myImageView = UIImageView().then {
        $0.layer.cornerRadius = 40
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "ClubImageMini")
    }
    private let changeImageButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 8
        $0.setTitle("이미지 변경", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    private let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let nameTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let majorLabel = UILabel().then {
        $0.text = "분야"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let majorTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let introduceLabel = UILabel().then {
        $0.text = "자기소개"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let introduceTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let skillStackLabel = UILabel().then {
        $0.text = "기술 스택"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let skillStackTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let facebookLabel = UILabel().then {
        $0.text = "Facebook"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let facebookTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let instagramLabel = UILabel().then {
        $0.text = "Instagram"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let instagramTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    private let githubLabel = UILabel().then {
        $0.text = "Github"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let githubTextField = UITextField().then {
        $0.addLeftPadding()
        $0.backgroundColor = UIColor(named: "BackGroundColor")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "SignUpButtonColor")?.cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        viewAppear.accept(())
    }
    override func bind() {
        let input = MyPageViewModel.Input(viewAppear: viewAppear.asDriver(onErrorJustReturn: ()))
        let output = viewModel.transform(input)
        output.myPage.subscribe(onNext: { [self] in
            nameTextField.text = $0.name
            if $0.profile_image_url != nil {
                let url = URL(string: $0.profile_image_url ?? "https://test-imag-upload-bucket.s3.ap-northeast-2.amazonaws.com/imag")
                myImageView.kf.setImage(with: url)
            } else {
                myImageView.image = UIImage(named: "Question")
            }
            introduceTextView.text = $0.introduce ?? ""
            majorTextField.text = $0.major ?? ""
            skillStackTextView.text = $0.stack ?? ""
            facebookTextField.text = $0.link_info?.facebook_link ?? ""
            instagramTextField.text = $0.link_info?.instagram_link ?? ""
            githubTextField.text = $0.link_info?.github_link ?? ""
        }).disposed(by: disposeBag)
    }
    
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            myImageView,
            changeImageButton,
            nameLabel,
            nameTextField,
            majorLabel,
            majorTextField,
            introduceLabel,
            introduceTextView,
            skillStackLabel,
            skillStackTextView,
            facebookLabel,
            facebookTextField,
            instagramLabel,
            instagramTextField,
            githubLabel,
            githubTextField
        ].forEach { contentView.addSubview($0) }
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(1064)
            $0.width.equalToSuperview()
        }
        myImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(18)
            $0.width.height.equalTo(80)
        }
        changeImageButton.snp.makeConstraints {
            $0.leading.equalTo(myImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().inset(64)
            $0.height.equalTo(34)
            $0.width.equalTo(119)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(myImageView.snp.bottom).offset(25)
        }
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.height.equalTo(44)
        }
        majorLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(nameTextField.snp.bottom).offset(16)
        }
        majorTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(majorLabel.snp.bottom).offset(4)
            $0.height.equalTo(44)
        }
        introduceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(majorTextField.snp.bottom).offset(16)
        }
        introduceTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(introduceLabel.snp.bottom).offset(4)
            $0.height.equalTo(144)
        }
        skillStackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(introduceTextView.snp.bottom).offset(16)
        }
        skillStackTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(skillStackLabel.snp.bottom).offset(4)
            $0.height.equalTo(100)
        }
        facebookLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(skillStackTextView.snp.bottom).offset(16)
        }
        facebookTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(facebookLabel.snp.bottom).offset(4)
            $0.height.equalTo(44)
        }
        instagramLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(facebookTextField.snp.bottom).offset(16)
        }
        instagramTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(instagramLabel.snp.bottom).offset(4)
            $0.height.equalTo(44)
        }
        githubLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(instagramTextField.snp.bottom).offset(16)
        }
        githubTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(githubLabel.snp.bottom).offset(4)
            $0.height.equalTo(44)
        }
    }
}
