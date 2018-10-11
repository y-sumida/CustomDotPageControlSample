//
//  ViewController.swift
//  CustomDotPageControlSample
//
//  Created by Yuki Sumida on 2018/10/11.
//  Copyright © 2018年 Yuki Sumida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = 4
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }

    @IBAction func tapLeft(_ sender: Any) {
        if pageControl.currentPage > 0 {
            pageControl.currentPage -= 1
            refresh()
        }
    }

    @IBAction func tapRight(_ sender: Any) {
        if pageControl.currentPage < pageControl.numberOfPages {
            pageControl.currentPage += 1
            refresh()
        }
    }

    private func refresh() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        pageControl.subviews[pageControl.currentPage].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
}

