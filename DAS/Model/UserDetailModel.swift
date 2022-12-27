import Foundation

// MARK: - UserDetailModel
struct UserDetailModel: Codable {
    let user_id: Int
    let email, name: String
    let grade, class_num, number: Int
    let introduce: String?
    let profile_image_url: String?
    let view_counts: Int?
    let major, stack: String?
    let link_info: Link?
    let sex: String
    let region: String?
    let club: [club]?
}
