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


}

