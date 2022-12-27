import Foundation

// MARK: - ClubListModel
struct ClubListModel: Codable {
    let club_list: [ClubList]
}

// MARK: - ClubList
struct ClubList: Codable {
    let club_id: Int
    let club_name: String
    let club_image_url: String
    let club_introduce: String?
    let club_type: String
    let club_category: String
    let like_counts: Int
}
