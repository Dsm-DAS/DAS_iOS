import Foundation
import RxSwift
import RxCocoa

class EtcViewModel: BaseVM {
    struct Input {
        let emailText: String
        let nameText: PublishRelay<String>
        let passwordText: String
        let gradeText: PublishRelay<Int>
        let classNumText: PublishRelay<Int>
        let numberText: PublishRelay<Int>
        let sexText: PublishRelay<String>
        let signupBttonDidTap: Signal<Void>
    }
    struct Output {
        let result : PublishRelay<Bool>
    }
    private let disposeBag = DisposeBag()
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = PublishRelay.combineLatest(input.nameText ,input.gradeText, input.classNumText, input.numberText, input.sexText)
        input.signupBttonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap{ name, grade, classNum, number, sex in
                api.signup(input.emailText, name, input.passwordText, grade, classNum, number, sex)
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
