import UIKit

// https://stackoverflow.com/questions/50985359/subclassing-the-uipagecontrol-for-customizing-the-active-and-inactive-dot-image
class CustomPageControl: UIPageControl {
    private lazy var currentPageIndicator: UIImage = UIImage.dotImage(color: UIColor.green, size: CGSize(width: currentPageIndicatorSize, height: currentPageIndicatorSize))
    private lazy var pageIndicator: UIImage = UIImage.dotImage(color: UIColor.gray, size: CGSize(width: pageIndicatorSize, height: pageIndicatorSize))

    private var currentPageIndicatorOffset: CGFloat = 1.5
    private var pageIndicatorOffset: CGFloat = 0

    var currentPageIndicatorSize: CGFloat = 10 {
        didSet {
            currentPageIndicatorOffset = abs(currentPageIndicatorSize - 7) / 2
            currentPageIndicator = UIImage.dotImage(color: currentPageIndicatorTintColor ?? .gray, size: CGSize(width: currentPageIndicatorSize, height: currentPageIndicatorSize))
            updateDots()
        }
    }
    var pageIndicatorSize: CGFloat = 7 {
        didSet {
            pageIndicatorOffset = abs(pageIndicatorSize - 7) / 2
            pageIndicator = UIImage.dotImage(color: pageIndicatorTintColor ?? .gray, size: CGSize(width: pageIndicatorSize, height: pageIndicatorSize))
            updateDots()
        }
    }

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
                currentPageIndicator = UIImage.dotImage(color: color, size: CGSize(width: currentPageIndicatorSize, height: currentPageIndicatorSize))
            }
        }
    }

    override var pageIndicatorTintColor: UIColor? {
        didSet {
            if let color = pageIndicatorTintColor {
                pageIndicator = UIImage.dotImage(color: color, size: CGSize(width: pageIndicatorSize, height: pageIndicatorSize))
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
