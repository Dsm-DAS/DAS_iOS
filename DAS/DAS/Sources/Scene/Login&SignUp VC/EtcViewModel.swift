import Foundation
import RxSwift
import RxCocoa

class EtcViewModel: ViewModel {
    struct Input {
        let emailText: String
        let codeText: String
        let passwordText: String
        let gradeText: PublishRelay<Int>
        let classNumText: PublishRelay<Int>
        let numberText: PublishRelay<Int>
        let signupBttonDidTap: Signal<Void>
    }
    struct Output {
        let result : PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = PublishRelay.combineLatest(input.gradeText, input.classNumText, input.numberText)
        input.signupBttonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap{ grade, classNum, number in
                api.signup(input.emailText, input.codeText, input.passwordText, grade, classNum, number)
            }.subscribe(onNext: { res in
                switch res {
                case .createOk:
                    result.accept(true)
                default:
                    result.accept(false)
                }
            }).disposed(by: disposeBag)
        return Output(result: result)
    }
}
