import Foundation
import RxSwift
import RxCocoa

class NoticeListViewModel: BaseVM {
    
    struct Input {
        let noticeList: Signal<Void>
    }
    struct Output {
        let noticeList: BehaviorRelay<[FeedList]>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let noticeList = BehaviorRelay<[FeedList]>(value: [])
        input.noticeList.asObservable()
            .flatMap { api.feedListLookUp() }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    noticeList.accept(data!.feed_list)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(noticeList: noticeList)
    }
}
