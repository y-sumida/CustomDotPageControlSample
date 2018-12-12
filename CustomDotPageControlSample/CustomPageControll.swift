import UIKit

// https://stackoverflow.com/questions/50985359/subclassing-the-uipagecontrol-for-customizing-the-active-and-inactive-dot-image
class CustomPageControl: UIPageControl {
    let imgActive: UIImage = dotImage(color: UIColor.green, size: CGSize(width: 14, height: 14))
    let imgInactive: UIImage = dotImage(color: UIColor.gray, size: CGSize(width: 10, height: 10))

    let customActiveYOffset: CGFloat = 2.0
    let customInactiveYOffset: CGFloat = 0.0

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

    override func awakeFromNib() {
        super.awakeFromNib()
        pageIndicatorTintColor = .clear
        currentPageIndicatorTintColor = .clear
        clipsToBounds = false
        updateDots()
    }

    func updateDots() {
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
                    imageView.frame.origin.y = imageView.frame.origin.y - customActiveYOffset
                    imageView.frame.origin.x = imageView.frame.origin.x - 2
                } else {
                    imageView.image = imgInactive
                    imageView.frame = inactiveRect
                    imageView.frame.origin.y = imageView.frame.origin.y - customInactiveYOffset
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
                    addedImageView.frame.origin.y = addedImageView.frame.origin.y - customActiveYOffset
                    addedImageView.frame.origin.x = addedImageView.frame.origin.x - 2
                } else {
                    addedImageView.frame.origin.y = addedImageView.frame.origin.y - customInactiveYOffset
                }
                view.addSubview(addedImageView)
                i = i + 1
            }
        }
    }

    func imageForSubview(_ view:UIView) -> UIImageView? {
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

    static func dotImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)

        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fillEllipse(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image!
    }
}