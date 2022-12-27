import Foundation
import RxSwift
import RxCocoa

class NoticeViewModel: BaseVM {
    
    struct Input {
        let noticeList: Signal<Void>
    }
    struct Output {
        let noticeList: BehaviorRelay<[NoticeList]>
        let count: PublishRelay<Int>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let noticeList = BehaviorRelay<[NoticeList]>(value: [])
        let count = PublishRelay<Int>()
        input.noticeList.asObservable()
            .flatMap { api.getNotice() }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    count.accept(data!.notice_response_list.count)
                    noticeList.accept(data!.notice_response_list)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(noticeList: noticeList, count: count)
    }
}
