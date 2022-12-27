import Foundation
import RxSwift
import RxCocoa

class CommentMenuViewModel: BaseVM {
    
    struct Input {
        let commentId: Int
        let deleteButtonDidTap: Signal<Void>
    }
    struct Output {
        let deleteResult: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let deleteResult = PublishRelay<Bool>()
        input.deleteButtonDidTap.asObservable()
            .flatMap { api.commentDelete(input.commentId) }
            .subscribe(onNext: { res in
                switch res {
                case .deleteOk:
                    deleteResult.accept(true)
                default:
                    deleteResult.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(deleteResult: deleteResult)
    }
}
