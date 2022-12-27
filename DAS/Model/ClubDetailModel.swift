import Foundation

struct ClubDetailModel: Codable {
    let club_id: Int
    let club_name: String
    let club_image_url: String
    let club_introduce: String?
    let club_type: String
    let club_category: String
    let club_views: Int
    let like_counts: Int
    let users_list: [ClubUserList]
}

struct ClubUserList: Codable {
    let user_id: Int
    let name: String
    let profile_image_url: String
}
