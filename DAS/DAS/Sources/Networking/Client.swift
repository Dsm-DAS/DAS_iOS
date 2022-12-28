import Foundation
import Moya

enum API {
    //user
    case login(email: String, password: String)
    case signUp(email: String, password: String, name: String, grade: Int, classNum: Int, number: Int, sex: String)
    case sentEmailCode(email : String)
    case codecheck(email : String, emailCode : String)
    case loadMyPage
    case refreshToken
    case userListLookUp
    case userDetailList(userId: Int)
    case changePassword(password: String, newPassword: String)
    case changeMyPage(image: String, name: String, introduce: String, major: String, stack: String, region: String, github: String, instagram: String, facebook: String)
    //club
    case clubListLookUp
    case clubDetailList(clubId: Int)
    //feed
    case feedListLookUp
    case feedDetailList(feedId: Int)
    //comment
    case commentDelete(commentId: Int)
    case commentPost(feedID: Int, content: String)
    case commentPatch(commentId: Int, comment: String)
    //notice
    case getNotice
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://52.79.150.23:8080")!
    }
    
    var path: String {
        switch self {
        // user
        case .login:
            return "/user/token"
        case .signUp:
            return "/user/signup"
        case .sentEmailCode:
            return "/user/email"
        case .codecheck:
            return "/user/email"
        case .loadMyPage:
            return "/user/my-page"
        case .refreshToken:
            return "/user/token"
        case .userListLookUp:
            return "/user"
        case .userDetailList(let userId):
            return "/user/\(userId)"
        case .changePassword:
            return "/user/password"
        case .changeMyPage:
            return "/user/my-page"
            
        //club
        case .clubListLookUp:
            return "/club/lists"
        case .clubDetailList(let clubId):
            return "/club/\(clubId)"
            
        //feed
        case .feedListLookUp:
            return "/feed"
        case .feedDetailList(let feedId):
            return "/feed/\(feedId)"
            
        //comment
        case .commentDelete(let commentId):
            return "/comment/\(commentId)"
        case .commentPost(let feedID, _):
            return "/comment/\(feedID)"
        case .commentPatch(let commentId, _):
            return "/comment/\(commentId)"
        //notice
        case .getNotice:
            return "/notice"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        //user
        case .login, .signUp, .sentEmailCode :
            return .post
        case .codecheck, .changeMyPage:
            return .put
        case .loadMyPage, .userListLookUp, .userDetailList:
            return .get
        case .refreshToken, .changePassword:
            return .patch
            
        //club
        case .clubListLookUp, .clubDetailList:
            return .get
            
        //feed
        case .feedListLookUp, .feedDetailList:
            return .get
            
        //comment
        case .commentDelete:
            return .delete
        case .commentPatch:
            return .patch
        case .commentPost:
            return .post
        //notice
        case .getNotice:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "password": password
                                        ],
                                      encoding: JSONEncoding.default)
            
        case .signUp(let email, let password, let name, let grade, let classNum, let number, let sex):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "password": password,
                                            "name": name,
                                            "grade": grade,
                                            "class_num": classNum,
                                            "number": number,
                                            "sex": sex
                                        ],
                                      encoding: JSONEncoding.prettyPrinted)
        case .sentEmailCode(let email):
            return .requestParameters(parameters:
                                        [
                                            "email": email
                                        ],
                                      encoding: JSONEncoding.prettyPrinted)
        case .codecheck(let email, let emailCode):
            return .requestParameters(parameters:
                                        [
                                            "email": email,
                                            "code": emailCode
                                        ],
                                      encoding: JSONEncoding.prettyPrinted)
        case .commentPost(_, let content):
            return .requestParameters(parameters:
                                        [
                                            "content": content
                                        ], encoding: JSONEncoding.prettyPrinted)
        case .commentPatch(_, let comment):
            return .requestParameters(parameters:
                                        [
                                            "comment": comment
                                        ], encoding: JSONEncoding.prettyPrinted)
        case .changePassword(let password, let newPassword):
            return .requestParameters(parameters:
                                        [
                                            "password": password,
                                            "new_password": newPassword
                                        ], encoding: JSONEncoding.prettyPrinted)
        case .changeMyPage(let image, let name, let introduce, let major, let stack, let region, let github, let instagram, let facebook):
            return .requestParameters(parameters:
                                        [
                                            "profile_image_url": image,
                                            "name": name,
                                            "introduce": introduce,
                                            "major": major,
                                            "stack": stack,
                                            "region": region,
                                            "link" : Link.init(github_link: github, facebook_link: facebook, instagram_link: instagram)
//                                                "github": github,
//                                                "instagram": instagram,
//                                                "facebook": facebook
//                                            }
                                        ], encoding: JSONEncoding.prettyPrinted)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .signUp, .sentEmailCode, .codecheck:
            return Header.tokenIsEmpty.header()
        case .refreshToken:
            return Header.refreshToken.header()
        case .loadMyPage, .userListLookUp, .clubListLookUp, .feedListLookUp, .feedDetailList, .commentDelete, .getNotice, .clubDetailList, .userDetailList, .commentPatch, .commentPost, .changePassword, .changeMyPage:
            return Header.accessToken.header()
        }
    }
}
