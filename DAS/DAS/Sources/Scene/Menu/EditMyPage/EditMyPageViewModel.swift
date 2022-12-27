import Foundation
import RxSwift
import RxCocoa

class EditMyPageViewModel: BaseVM {
    
    struct Input {
        let viewDisAppear: Driver<Void>
        let image: Driver<String>
        let name: Driver<String>
        let major: Driver<String>
        let introduce: Driver<String>
        let stack: Driver<String>
        let facebook: Driver<String>
        let instagram: Driver<String>
        let github: Driver<String>
    }
    struct Output {
        let result: PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.image, input.name, input.major, input.introduce, input.stack, input.facebook, input.instagram, input.github)
        let result = PublishRelay<Bool>()
        input.viewDisAppear.asObservable()
            .withLatestFrom(info)
            .flatMap { image, name, major, introduce, stack, facebook, instagram, github in
                api.changeMyPage(image, name, major, instagram, stack, facebook, github, instagram, "")
            }
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
