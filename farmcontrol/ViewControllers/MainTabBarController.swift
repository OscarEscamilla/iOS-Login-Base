//
//  TabBarViewController.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 25/06/24.
//

import UIKit

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change tab bar background color
        tabBar.barTintColor = UIColor.systemGreen
        
        // Change tab bar item selected color
        tabBar.tintColor = UIColor.systemGreen
        
        // Change tab bar item unselected color
        tabBar.unselectedItemTintColor = UIColor.gray
        
        // Optional: Change the style of the tab bar
        tabBar.isTranslucent = false
        
        
        let firstViewController = HomeViewControler()
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let secondViewController = ProfileViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        let thirdViewController = SettingsViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        thirdViewController.tabBarItem.title = "settings"
        viewControllers = [firstViewController, secondViewController, thirdViewController]
        
             
        
    }
    
}
