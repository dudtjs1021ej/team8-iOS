//
//  CatMainPageViewController.swift
//  GDGTeam8
//
//  Created by 백상휘 on 2022/06/25.
//

import UIKit

class CatMainPageViewController: UIPageViewController {
    
    private var pages = [CatMainItemViewController]()
    
    private var cats = [CatModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 10, width: view.frame.width, height: 10)).cgPath
        view.layer.shadowOffset = CGSize(width: 0, height: -5)
        
        for view in self.view.subviews {
            if let pageControl = view as? UIPageControl {
                pageControl.isHidden = true
            }
        }
        
        self.dataSource = self
    }
    
    func reloadPage(_ cats: [CatModel]) {
        self.cats = cats
        
        for cat in cats {
            if let vc = CatMainPageViewController.vcInstance(name: String(describing: CatMainItemViewController.self)) as? CatMainItemViewController {
                vc.setData(cat)
                pages.append(vc)
            }
        }
        
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: false)
        }
    }
}

extension CatMainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let vc = viewController as? CatMainItemViewController,
            let viewControllerIndex = pages.firstIndex(of: vc)
        else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 { return nil}
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let vc = viewController as? CatMainItemViewController,
            let viewControllerIndex = pages.firstIndex(of: vc)
        else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex == pages.count { return nil}
        
        return pages[nextIndex]
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        pages.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard
//            let firstPage = viewControllers?.first as? CatMainItemViewController,
//            let indexFirstPage = pages.firstIndex(of: firstPage)
//        else {
//            return 0
//        }
//
//        return indexFirstPage
//    }
}

extension UIPageViewController {
    static func vcInstance(name: String) -> UIViewController? {
        return UIStoryboard(name: "CatMain", bundle: nil).instantiateViewController(withIdentifier: name)
    }
}
