import Foundation
import RxSwift
import RxCocoa

class CommentPlusViewModel: BaseVM {
    
    struct Input {
        let feedId: Int
        let content: Driver<String>
        let postButtonDidTap: Signal<Void>
    }
    struct Output {
        let postResult: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let postResult = PublishRelay<Bool>()
        input.postButtonDidTap.asObservable()
            .withLatestFrom(input.content)
            .flatMap { content in
                api.commentPost(input.feedId, content)
            }
            .subscribe(onNext: { res in
                switch res {
                case .createOk:
                    postResult.accept(true)
                default:
                    postResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(postResult: postResult)
    }
}
