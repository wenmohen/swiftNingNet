//
//  MainViewController.swift
//  swiftNetTry
//
//  Created by nhl on 2017/9/26.
//  Copyright © 2017年 nhl. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIPageViewControllerDelegate {
var pageViewController: UIPageViewController!
    var movieController: MovieViewController!
    var musicController: MusicViewController!
    var bookController: BookViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        获取到嵌入的UIPageViewController
        pageViewController = self.childViewControllers.first as! UIPageViewController
        //根据Storyboard ID来创建一个View Controller
        let  storyboard:UIStoryboard=UIStoryboard.init(name: "Main", bundle: nil)
        movieController = storyboard.instantiateViewController(withIdentifier: "MovieControllerID") as! MovieViewController
        musicController = storyboard.instantiateViewController(withIdentifier: "MusicControllerID") as! MusicViewController
        bookController = storyboard.instantiateViewController(withIdentifier: "BookControllerID") as! BookViewController
        
      
        //设置pageViewController的数据源代理为当前Controller
        pageViewController.dataSource = self
        
        //手动为pageViewController提供提一个页面
        pageViewController.setViewControllers([movieController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
  
}
extension MainViewController: UIPageViewControllerDataSource {
    
    //返回当前页面的下一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of:MovieViewController.self) {
            return musicController
        }
        else if viewController.isKind(of:BookViewController.self) {
            return bookController
        }
        return nil
        
    }
    
    //返回当前页面的上一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: MusicViewController.self) {
            return movieController
        }
        else if viewController.isKind(of:BookViewController.self) {
            return musicController
        }
        return nil
    }
}
