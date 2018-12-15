import UIKit

// https://stackoverflow.com/questions/50985359/subclassing-the-uipagecontrol-for-customizing-the-active-and-inactive-dot-image
class CustomPageControl: UIPageControl {
    private var currentPageIndicator: UIImage = UIImage.dotImage(color: UIColor.green, size: CGSize(width: 14, height: 14))
    private var pageIndicator: UIImage = UIImage.dotImage(color: UIColor.gray, size: CGSize(width: 10, height: 10))

    private let currentPageIndicatorOffset: CGFloat = 3.5
    private let pageIndicatorOffset: CGFloat = 1.5

    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    override var currentPageIndicatorTintColor: UIColor? {
        didSet {
            if let color = currentPageIndicatorTintColor {
                currentPageIndicator = UIImage.dotImage(color: color, size: CGSize(width: 14, height: 14))
            }
        }
    }

    override var pageIndicatorTintColor: UIColor? {
        didSet {
            if let color = pageIndicatorTintColor {
                pageIndicator = UIImage.dotImage(color: color, size: CGSize(width: 10, height: 10))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        updateDots()

        addTarget(self, action: #selector(didChangeValue(sender:)), for: .valueChanged)
    }

    private func updateDots() {
        var i = 0
        let activeSize = currentPageIndicator.size
        let inactiveSize = pageIndicator.size
        let activeRect = CGRect(x: 0, y: 0, width: activeSize.width, height: activeSize.height)
        let inactiveRect = CGRect(x: 0, y: 0, width: inactiveSize.width, height: inactiveSize.height)

        for view in subviews {
            if let imageView = imageForSubview(view) {
                if i == currentPage {
                    imageView.image = currentPageIndicator
                    imageView.frame = activeRect
                    imageView.frame.origin.y = imageView.frame.origin.y - currentPageIndicatorOffset
                    imageView.frame.origin.x = imageView.frame.origin.x - currentPageIndicatorOffset
                } else {
                    imageView.image = pageIndicator
                    imageView.frame = inactiveRect
                    imageView.frame.origin.y = imageView.frame.origin.y - pageIndicatorOffset
                    imageView.frame.origin.x = imageView.frame.origin.x - pageIndicatorOffset
                }
                i += 1
            } else {
                var dotImage = pageIndicator
                if i == currentPage {
                    dotImage = currentPageIndicator
                }
                view.clipsToBounds = false
                let addedImageView: UIImageView = UIImageView(image: dotImage)
                if dotImage == currentPageIndicator {
                    addedImageView.frame = activeRect
                    addedImageView.frame.origin.y = addedImageView.frame.origin.y - currentPageIndicatorOffset
                    addedImageView.frame.origin.x = addedImageView.frame.origin.x - currentPageIndicatorOffset
                } else {
                    addedImageView.frame.origin.y = addedImageView.frame.origin.y - pageIndicatorOffset
                    addedImageView.frame.origin.x = addedImageView.frame.origin.x - pageIndicatorOffset
                }
                view.addSubview(addedImageView)
                i += 1
            }
        }
    }

    private func imageForSubview(_ view:UIView) -> UIImageView? {
        var dot: UIImageView?
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
    }

    @objc private func didChangeValue(sender: UIPageControl){
        currentPage = sender.currentPage
    }
}
