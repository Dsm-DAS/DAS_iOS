import UIKit
import SnapKit
import Then

class TabBarViewController: UITabBarController {
    
    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.selectedIndex = defaultIndex
    }
}
extension TabBarViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let firstNavigationController = UINavigationController()
        let firstTabController = MainViewController()
        firstNavigationController.addChild(firstTabController)
        ///기본으로 보여질 이미지
        firstNavigationController.tabBarItem.image = UIImage(named: "Main")
        ///선택되었을 때 보여질 이미지
        firstNavigationController.tabBarItem.selectedImage = UIImage(named: "Main")
        ///탭바 아이템 타이틀
        firstNavigationController.tabBarItem.title = "홈"
        
        let secondNavigationController = UINavigationController()
        let secondTabController = ListViewController()
        secondNavigationController.addChild(secondTabController)
        ///기본으로 보여질 이미지
        secondNavigationController.tabBarItem.image = UIImage(named: "List")
        
        ///선택되었을 때 보여질 이미지
        secondNavigationController.tabBarItem.selectedImage = UIImage(named: "List")
        ///탭바 아이템 타이틀
        secondNavigationController.tabBarItem.title = "글"
        
        
        let thirdNavigationController = UINavigationController()
        let thirdTabController = SearchViewController()
        thirdNavigationController.addChild(thirdTabController)
        ///기본으로 보여질 이미지
        thirdNavigationController.tabBarItem.image = UIImage(named: "Search")
        ///선택되었을 때 보여질 이미지
        thirdNavigationController.tabBarItem.selectedImage = UIImage(named: "Search")
        ///탭바 아이템 타이틀
        thirdNavigationController.tabBarItem.title = "검색"
        
        
        let fourthNavigationController = UINavigationController()
        let fourthTabController = MenuViewController()
        fourthNavigationController.addChild(fourthTabController)
        ///기본으로 보여질 이미지
        fourthNavigationController.tabBarItem.image = UIImage(named: "Menu")
        ///선택되었을 때 보여질 이미지
        fourthNavigationController.tabBarItem.selectedImage = UIImage(named: "Menu")
        ///탭바 아이템 타이틀
        fourthNavigationController.tabBarItem.title = "메뉴"
        
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = UIColor(named: "TabBarBackGround")
        tabBar.barTintColor = UIColor.white
        ///선택되었을 때 타이틀 컬러
        tabBar.tintColor = UIColor(named: "MainColor")
        ///선택안된거 타이틀 컬러
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false
        
        let viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]
        self.setViewControllers(viewControllers, animated: true)
    }
    
}
