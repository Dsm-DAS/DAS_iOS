import Foundation
import RxSwift
import RxCocoa

class CommentEditViewModel: BaseVM {
    
    struct Input {
        let commentId: Int
        let content: Driver<String>
        let patchButtonDidTap: Signal<Void>
    }
    struct Output {
        let patchResult: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let patchResult = PublishRelay<Bool>()
        input.patchButtonDidTap.asObservable()
            .withLatestFrom(input.content)
            .flatMap { content in
                api.commentPatch(input.commentId, content)
            }
            .subscribe(onNext: { res in
                switch res {
                case .deleteOk:
                    patchResult.accept(true)
                default:
                    patchResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(patchResult: patchResult)
    }
}
