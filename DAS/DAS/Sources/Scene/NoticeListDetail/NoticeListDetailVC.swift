import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import Kingfisher

class NoticeListDetailVC: BaseVC {
    private let viewModel = NoticeListDetailViewModel()
    var feedId = 0
    var commentId = 0
    private let noticeDetailList = PublishRelay<Void>()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private let contentView = UIView()
    private let titleLabel = UILabel().then {
        $0.text = "어쩌구 저쩌구 모집합니다"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    private let clubImageView = UIImageView().then {
        $0.image = UIImage(named: "ClubImageMini")
    }
    private let clubTitleLable = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.text = "멋진로고동아리"
    }
    private let recruitmentMajorLabel = UILabel().then {
        $0.text = "모집 분야"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let recruitmentMajorDataLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.text = "프론트엔드, 백엔드, 인공지능, 안드로이드"
    }
    private let termLabel = UILabel().then {
        $0.text = "기간"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let termDataLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.text = "2022년 13월 33일 까지(D-77)"
    }
    private let urlLabel = UILabel().then {
        $0.text = "URL"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = UIColor(named: "TextColor")
    }
    private let urlDateLabel = UILabel().then {
        $0.text = "https://forms.google.com/form/yo..."
    }
    private let imageDataView = UIImageView()
    private let mainTextView = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        $0.numberOfLines = 1000
    }
    private let commentLabel = UILabel().then {
        $0.text = "댓글"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    private let commentPlusButton = UIButton(type: .system).then {
        $0.setImage(UIImage.add, for: .normal)
        $0.tintColor = .black
    }
    private let commentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: $0.frame.width, height: 86)
        $0.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: "CommentCollectionViewCell")
        $0.collectionViewLayout = layout
    }
    override func bind() {
        let input = NoticeListDetailViewModel.Input(feedId: feedId, noticeDetailList: noticeDetailList.asSignal())
        let output = viewModel.transform(input)
        output.noticeDetailList.subscribe(onNext: { [self] in
            titleLabel.text = $0.title
            clubImageView.kf.setImage(with: URL(string: $0.writer.profile_image_url))
            clubTitleLable.text = $0.writer.name
            recruitmentMajorDataLabel.text = $0.major
            termDataLabel.text = $0.end_at
            urlDateLabel.text = $0.das_url
            mainTextView.text = $0.content
            let count = $0.comment_list.count
            commentCollectionView.snp.updateConstraints {
                $0.height.equalTo(90 * count)
            }
        }).disposed(by: disposeBag)
        output.commentList.bind(to: commentCollectionView.rx.items(cellIdentifier: "CommentCollectionViewCell", cellType: CommentCollectionViewCell.self)) { row, item, cell in
            cell.userNameLabel.text = item.writer.name
            cell.commentLabel.text = item.content
            cell.userImageView.kf.setImage(with: URL(string: item.writer.profile_image_url))
            cell.commentId = item.comment_id
        }.disposed(by: disposeBag)
    }
    override func configureVC() {
        commentCollectionView.delegate = self
        commentPlusButton.rx.tap
            .subscribe(onNext: {
                let vc = CommentPlusVC()
                vc.feedId = self.feedId
                if #available(iOS 16.0, *) {
                    if let sheet = vc.sheetPresentationController {
                        let id = UISheetPresentationController.Detent.Identifier("frist")
                        let detent = UISheetPresentationController.Detent.custom(identifier: id) { _ in
                            return 159
                        }
                        sheet.detents = [detent]
                        sheet.preferredCornerRadius = 12
                        sheet.prefersGrabberVisible = true
                        self.present(vc, animated: true)
                    }
                    vc.isModalInPresentation = true
                }
            }).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            titleLabel,
            clubImageView,
            clubTitleLable,
            recruitmentMajorLabel,
            recruitmentMajorDataLabel,
            termLabel,
            termDataLabel,
            urlLabel,
            urlDateLabel,
            imageDataView,
            mainTextView,
            commentLabel,
            commentPlusButton,
            commentCollectionView
        ].forEach { contentView.addSubview($0)}
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.bottom.equalTo(commentCollectionView.snp.bottom).offset(10)
            $0.width.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        clubImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.height.width.equalTo(36)
        }
        clubTitleLable.snp.makeConstraints {
            $0.leading.equalTo(clubImageView.snp.trailing).offset(8)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
        recruitmentMajorLabel.snp.makeConstraints {
            $0.top.equalTo(clubImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        recruitmentMajorDataLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(recruitmentMajorLabel.snp.bottom)
        }
        termLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(recruitmentMajorDataLabel.snp.bottom).offset(8)
        }
        termDataLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(termLabel.snp.bottom)
        }
        urlLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(termDataLabel.snp.bottom).offset(8)
        }
        urlDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.top.equalTo(urlLabel.snp.bottom)
        }
        imageDataView.snp.makeConstraints {
            $0.top.equalTo(urlDateLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        mainTextView.snp.makeConstraints {
            $0.top.equalTo(imageDataView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        commentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(mainTextView.snp.bottom).offset(24)
        }
        commentPlusButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(mainTextView.snp.bottom).offset(27)
            $0.width.height.equalTo(30)
        }
        commentCollectionView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(450)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        noticeDetailList.accept(())
        commentCollectionView.reloadData()
    }
}

extension NoticeListDetailVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 86)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CommentMenuVC()
        let cell = collectionView.cellForItem(at: indexPath) as! CommentCollectionViewCell
        vc.commentId = cell.commentId
        if #available(iOS 16.0, *) {
            if let sheet = vc.sheetPresentationController {
                let id = UISheetPresentationController.Detent.Identifier("frist")
                let detent = UISheetPresentationController.Detent.custom(identifier: id) { _ in
                    return 131
                }
                sheet.detents = [detent]
                sheet.preferredCornerRadius = 12
                sheet.prefersGrabberVisible = true
                self.present(vc, animated: true)
            }
        }
    }
    
}
