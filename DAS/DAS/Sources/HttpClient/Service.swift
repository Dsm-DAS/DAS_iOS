import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

final class Service {
    
    let provider = MoyaProvider<API>(plugins: [MoyaLoggingPlugin()])
    
    func login(_ email: String, _ password: String) -> Single<networkingResult> {
        return provider.rx.request(.login(email: email, password: password))
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map{ response -> networkingResult in
                Token.accessToken = response.access_token
                Token.refreshToken = response.refresh_token
                return .ok
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func refreshToken() -> Single<networkingResult> {
        return provider.rx.request(.refreshToken)
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map{ response -> networkingResult in
                Token.accessToken = response.access_token
                Token.refreshToken = response.refresh_token
                return .ok
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func sendEmailCode(_ email: String) -> Single<networkingResult> {
        return provider.rx.request(.sentEmailCode(email: email))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    
    func codeCheck(_ email: String, _ checkCode: String) -> Single<networkingResult> {
        return provider.rx.request(.codecheck(email: email, emailCode: checkCode))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .ok
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func signup(_ email: String, _ name: String, _ password: String, _ grade: Int, _ classNum: Int, _ number: Int, _ sex: String) -> Single<networkingResult> {
        return provider.rx.request(.signUp(email: email, password: password, name: name, grade: grade, classNum: classNum, number: number, sex:  sex))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func loadMyPage() -> Single<(MyPageModel?, networkingResult)> {
        return provider.rx.request(.loadMyPage)
            .filterSuccessfulStatusCodes()
            .map(MyPageModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    
    func userListLookUp() -> Single<(UserListModel?, networkingResult)> {
        return provider.rx.request(.userListLookUp)
            .filterSuccessfulStatusCodes()
            .map(UserListModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    
    func clubListLookUp() -> Single<(ClubListModel?, networkingResult)> {
        return provider.rx.request(.clubListLookUp)
            .filterSuccessfulStatusCodes()
            .map(ClubListModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func feedListLookUp() -> Single<(FeedListModel?, networkingResult)> {
        return provider.rx.request(.feedListLookUp)
            .filterSuccessfulStatusCodes()
            .map(FeedListModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func feedDetailList(_ feedId: Int) -> Single<(FeedDetailListModel?, networkingResult)> {
        return provider.rx.request(.feedDetailList(feedId: feedId))
            .filterSuccessfulStatusCodes()
            .map(FeedDetailListModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func commentDelete(_ commentId: Int) -> Single<networkingResult> {
        return provider.rx.request(.commentDelete(commentId: commentId))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .deleteOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func getNotice() -> Single<(NoticeResponseListModel?, networkingResult)> {
        return provider.rx.request(.getNotice)
            .filterSuccessfulStatusCodes()
            .map(NoticeResponseListModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func clubDetailList(_ clubId: Int) -> Single<(ClubDetailModel?, networkingResult)> {
        return provider.rx.request(.clubDetailList(clubId: clubId))
            .filterSuccessfulStatusCodes()
            .map(ClubDetailModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func userDetailList(_ userID: Int) -> Single<(UserDetailModel?, networkingResult)> {
        return provider.rx.request(.userDetailList(userId: userID))
            .filterSuccessfulStatusCodes()
            .map(UserDetailModel.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fault))
            }
    }
    func commentPost(_ feedId: Int, _ content: String) -> Single<networkingResult> {
        return provider.rx.request(.commentPost(feedID: feedId, content: content))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .createOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func commentPatch(_ commentId: Int, _ comment: String) -> Single<networkingResult> {
        return provider.rx.request(.commentPatch(commentId: commentId, comment: comment))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .deleteOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func changePassword(_ password: String, _ newPassword: String) -> Single<networkingResult> {
        return provider.rx.request(.changePassword(password: password, newPassword: newPassword))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .deleteOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func changeMyPage(_ image: String, _ name: String, _ major: String, _ intrduce: String, _ stack: String, _ facebook: String, _ github: String, _ instagram: String, _ region: String) -> Single<networkingResult> {
        return provider.rx.request(.changeMyPage(image: image, name: name, introduce: intrduce, major: major, stack: stack, region: region, github: github, instagram: instagram, facebook: facebook))
            .filterSuccessfulStatusCodes()
            .map{ response -> networkingResult in
                return .deleteOk
            }
            .catch {[unowned self] in return .just(setNetworkError($0))}
    }
    func setNetworkError(_ error: Error) -> networkingResult {
            print(error)
            print(error.localizedDescription)
            guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fault) }
            return (networkingResult(rawValue: status) ?? .fault)
    }
}
