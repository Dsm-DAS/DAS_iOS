import Foundation
import RxSwift
import RxCocoa

class MainViewModel: BaseVM {
    
    struct Input {
        let refreshToken: Signal<Void>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        input.refreshToken.asObservable()
            .flatMap { api.refreshToken() }
            .subscribe(onNext: { res in
                switch res {
                case .ok:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result)
    }
}
