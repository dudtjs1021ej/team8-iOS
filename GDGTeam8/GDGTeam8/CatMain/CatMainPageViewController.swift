//
//  CatMainPageViewController.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import UIKit

class CatMainPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    var pages = [
        CatMainPageViewController.vcInstance(name: String(describing: CatMainItemViewController.self))
        , CatMainPageViewController.vcInstance(name: String(describing: CatMainItemViewController.self))
        , CatMainPageViewController.vcInstance(name: String(describing: CatMainItemViewController.self))
    ]
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return pages.last as? UIViewController
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex >= 0 else {
            return pages.first as? UIViewController
        }
        
        guard pages.count > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstPage = pages.first as? UIViewController {
            setViewControllers([firstPage], direction: .forward, animated: false)
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard
            let firstPage = viewControllers?.first,
            let indexFirstPage = pages.firstIndex(of: firstPage)
        else {
            return 0
        }
        
        return indexFirstPage
    }
}

extension UIPageViewController {
    static func vcInstance(name: String) -> UIViewController? {
        return UIStoryboard(name: "CatMain", bundle: nil).instantiateViewController(withIdentifier: name)
    }
}
