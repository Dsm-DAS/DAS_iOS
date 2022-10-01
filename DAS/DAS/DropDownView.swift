//
//  DropDownView.swift
//  DAS
//
//  Created by 박주영 on 2022/09/22.
//

import UIKit
import SnapKit
import Then
import DropDown
class DropDownView: UIView {
    var itemList = ["1","2","3"]
    let dropDown = DropDown()
    let textFiledView = UITextField().then {
        $0.text = "선택해주세요"
    }
    let ivIcon = UIImageView().then {
        $0.image = UIImage(systemName: "heart")
        $0.tintColor = UIColor.gray
    }
    let btnSelect = UIButton()
    
    override func layoutSubviews() {
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic
        setDropdown()
    }
    func setDropdown() {
        dropDown.dataSource = itemList
        
        // anchorView를 통해 UI와 연결
        dropDown.anchorView = self
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropDown.bottomOffset = CGPoint(x: 0, y: self.bounds.height)
        
        // Item 선택 시 처리
        dropDown.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self!.textFiledView.text = item
            self!.ivIcon.image = UIImage.init(named: "ico_triangle_bottom")
        }
        
        // 취소 시 처리
        dropDown.cancelAction = { [weak self] in
            //빈 화면 터치 시 DropDown이 사라지고 아이콘을 원래대로 변경
            self!.ivIcon.image = UIImage.init(named: "ico_triangle_bottom")
        }
    }
}
