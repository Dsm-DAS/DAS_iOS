import Foundation

struct TokenModel: Codable {
    let access_token : String
    let refresh_token : String
    let authority : String?
    let expired_at : String?
}
