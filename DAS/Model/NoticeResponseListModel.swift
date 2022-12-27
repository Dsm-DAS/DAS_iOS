import Foundation

struct NoticeResponseListModel: Codable {
    let notice_response_list: [NoticeList]
}

struct NoticeList: Codable {
    let notice_id: Int
    let title: String
    let created_at: String
    let view_counts: Int
}
