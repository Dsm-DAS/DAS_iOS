import UIKit

class TabBarViewController : UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let tabOne = UINavigationController(rootViewController: MainViewController())
        
        let tabOneBarItem = UITabBarItem(title: "홈", image: UIImage(named: "Main"), tag: 0)
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: ListViewController())
        let tabTwoBarItem = UITabBarItem(title: "글", image: UIImage(named: "List"), tag: 1)
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThree = UINavigationController(rootViewController: SearchViewController())
        let tabThreeBarItem = UITabBarItem(title: "검색", image: UIImage(named: "Search"), tag: 2)
        tabThree.tabBarItem = tabThreeBarItem
        
        let tabFour = UINavigationController(rootViewController: MenuViewController())
        let tabFourBarItem = UITabBarItem(title: "내 계정", image: UIImage(named: "Menu"), tag: 3)
        tabFour.tabBarItem = tabFourBarItem
        
        
        let tabBar: UITabBar = self.tabBar
        tabBar.backgroundColor = UIColor(named: "TabBarBackGround")
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor(named: "MainColor")
        tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour]
        
    }
    override func viewWillLayoutSubviews() {
        let kBarHeight =  tabBar.frame.size.height
        tabBar.frame.origin.y = view.frame.height - kBarHeight
    }
}
