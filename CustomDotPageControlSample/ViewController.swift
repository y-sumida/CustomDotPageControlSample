//
//  ViewController.swift
//  CustomDotPageControlSample
//
//  Created by Yuki Sumida on 2018/10/11.
//  Copyright © 2018年 Yuki Sumida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pageControl: CustomPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = 4
        //pageControl.pageIndicatorTintColor = .gray
        //pageControl.currentPageIndicatorTintColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func tapLeft(_ sender: Any) {
        if pageControl.currentPage > 0 {
            pageControl.currentPage -= 1
        }
    }

    @IBAction func tapRight(_ sender: Any) {
        if pageControl.currentPage < pageControl.numberOfPages {
            pageControl.currentPage += 1
        }
    }
}
