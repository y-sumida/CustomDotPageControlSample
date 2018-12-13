import UIKit

// https://stackoverflow.com/questions/50985359/subclassing-the-uipagecontrol-for-customizing-the-active-and-inactive-dot-image
class CustomPageControl: UIPageControl {
    private var imgActive: UIImage = UIImage.dotImage(color: UIColor.green, size: CGSize(width: 14, height: 14))
    private var imgInactive: UIImage = UIImage.dotImage(color: UIColor.gray, size: CGSize(width: 10, height: 10))

    private let activeOffset: CGFloat = 3.5
    private let inactiveOffset: CGFloat = 1.5

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
                imgActive = UIImage.dotImage(color: color, size: CGSize(width: 14, height: 14))
            }
        }
    }

    override var pageIndicatorTintColor: UIColor? {
        didSet {
            if let color = pageIndicatorTintColor {
                imgInactive = UIImage.dotImage(color: color, size: CGSize(width: 10, height: 10))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        updateDots()
    }

    private func updateDots() {
        var i = 0
        let activeSize = imgActive.size
        let inactiveSize = imgInactive.size
        let activeRect = CGRect(x: 0, y: 0, width: activeSize.width, height: activeSize.height)
        let inactiveRect = CGRect(x: 0, y: 0, width: inactiveSize.width, height: inactiveSize.height)

        for view in subviews {
            if let imageView = imageForSubview(view) {
                if i == currentPage {
                    imageView.image = imgActive
                    imageView.frame = activeRect
                    imageView.frame.origin.y = imageView.frame.origin.y - activeOffset
                    imageView.frame.origin.x = imageView.frame.origin.x - activeOffset
                } else {
                    imageView.image = imgInactive
                    imageView.frame = inactiveRect
                    imageView.frame.origin.y = imageView.frame.origin.y - inactiveOffset
                    imageView.frame.origin.x = imageView.frame.origin.x - inactiveOffset
                }
                i = i + 1
            } else {
                var dotImage = imgInactive
                if i == currentPage {
                    dotImage = imgActive
                }
                view.clipsToBounds = false
                let addedImageView: UIImageView = UIImageView(image: dotImage)
                if dotImage == imgActive {
                    addedImageView.frame = activeRect
                    addedImageView.frame.origin.y = addedImageView.frame.origin.y - activeOffset
                    addedImageView.frame.origin.x = addedImageView.frame.origin.x - activeOffset
                } else {
                    addedImageView.frame.origin.y = addedImageView.frame.origin.y - inactiveOffset
                    addedImageView.frame.origin.x = addedImageView.frame.origin.x - inactiveOffset
                    addedImageView.tintColor = pageIndicatorTintColor
                }
                view.addSubview(addedImageView)
                i = i + 1
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
}
