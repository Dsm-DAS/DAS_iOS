import Foundation
import RxSwift
import RxCocoa

class ClubListViewModel: BaseVM {
    
    struct Input {
        let clubList: Signal<Void>
    }
    struct Output {
        let clubList: BehaviorRelay<[ClubList]>
    }
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let api = Service()
        let clubList = BehaviorRelay<[ClubList]>(value: [])
        input.clubList.asObservable()
            .flatMap { api.clubListLookUp() }
            .subscribe(onNext: { data, res in
                switch res {
                case .ok:
                    clubList.accept(data!.club_list)
                default:
                    return
                }
            }).disposed(by: disposeBag)
        return Output(clubList: clubList)
    }
}
