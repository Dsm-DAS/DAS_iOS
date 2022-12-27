import Foundation
import RxSwift
import RxCocoa

class NoticeListDetailViewModel: BaseVM {
    
    struct Input {
        let feedId: Int
        let noticeDetailList: Signal<Void>
    }
    struct Output {
        let noticeDetailList: PublishRelay<FeedDetailListModel>
        let commentList: BehaviorRelay<[CommentList]>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let noticeDetailList = PublishRelay<FeedDetailListModel>()
        let commentList = BehaviorRelay<[CommentList]>(value: [])
        input.noticeDetailList.asObservable()
            .flatMap { api.feedDetailList(input.feedId) }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    noticeDetailList.accept(data!)
                    commentList.accept(data!.comment_list)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(noticeDetailList: noticeDetailList, commentList: commentList)
    }
}
