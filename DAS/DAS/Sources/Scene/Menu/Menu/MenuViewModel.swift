import Foundation
import RxSwift
import RxCocoa

class MenuViewModel: BaseVM {


    struct Input {
        let viewAppear: Driver<Void>
    }
    struct Output {
        let myPage: PublishRelay<MyPageModel>
        let result: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let myPage = PublishRelay<MyPageModel>()
        let result = PublishRelay<Bool>()
        input.viewAppear.asObservable()
            .flatMap { api.loadMyPage() }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    myPage.accept(data!)
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(myPage: myPage, result: result)
    }
}
