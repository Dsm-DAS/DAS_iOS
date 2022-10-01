import Foundation
import Moya

let MY = MoyaProvider<listService>()

enum listService {
    case login(email: String, password: String)
    case signUp(email: String, password: String, name: String, grade: Int, classNum: Int, number: Int)
    case sentEmailCode(email : String)
    case codecheck(email : String, emailCode : String)
}

extension listService: TargetType {
    var baseURL: URL {
        return URL(string: "http://10.156.147.161:8080")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/token"
        case .signUp:
            return "/user/signup"
        case.sentEmailCode:
            return "/user/email"
        case.codecheck:
            return "/user/email"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signUp, .sentEmailCode :
            return .post
        case .codecheck :
            return .put
        }
    }
    
    //["email":"\(email)", "password":"\(password)"]
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters:
                [
                    "email": email,
                    "password": password
                ],
              encoding: JSONEncoding.default)
            
        case .signUp(let email, let password, let name, let grade, let classNum, let number):
            return .requestJSONEncodable(["email":"\(email)", "password":"\(password)", "name":"\(name)","grade": "\(grade)","class_num":"\(classNum)","number":"\(number)"])
        case .sentEmailCode(let email):
            return .requestJSONEncodable(["email":"\(email)"])
        case .codecheck(let email, let emailCode):
            return .requestJSONEncodable(["email":email,"code":emailCode])
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .signUp, .sentEmailCode, .codecheck:
            return Header.tokenIsEmpty.header()
        }
    }
}
