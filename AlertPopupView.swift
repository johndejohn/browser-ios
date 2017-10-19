/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit

class AlertPopupView: PopupView {
    
    fileprivate var dialogImage: UIImageView?
    fileprivate var titleLabel: UILabel!
    fileprivate var messageLabel: UILabel!
    fileprivate var containerView: UIView!
    
    fileprivate let kAlertPopupScreenFraction: CGFloat = 0.8
    fileprivate let kPadding: CGFloat = 20.0
    
    init(image: UIImage?, title: String, message: String) {
        super.init(frame: CGRect.zero)
        
        overlayDismisses = false
        defaultShowType = .normal
        defaultDismissType = .noAnimation
        presentsOverWindow = true
        
        containerView = UIView(frame: CGRect.zero)
        containerView.autoresizingMask = [.flexibleWidth]
        
        if let image = image {
            let di = UIImageView(image: image)
            containerView.addSubview(di)
            dialogImage = di
        }
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightBold)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        containerView.addSubview(titleLabel)
        
        messageLabel = UILabel(frame: CGRect.zero)
        messageLabel.textColor = UIColor(rgb: 0x696969)
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        containerView.addSubview(messageLabel)
        
        updateSubviews()
        
        setPopupContentView(view: containerView)
        setStyle(popupStyle: .dialog)
    }
    
    func updateSubviews() {
        let width: CGFloat = dialogWidth
        
        var imageFrame: CGRect = dialogImage?.frame ?? CGRect.zero
        if let dialogImage = dialogImage {
            imageFrame.origin.x = (width - imageFrame.width) / 2.0
            imageFrame.origin.y = kPadding * 2.0
            dialogImage.frame = imageFrame
        }
        
        let titleLabelSize: CGSize = titleLabel.sizeThatFits(CGSize(width: width - kPadding * 4.0, height: CGFloat.greatestFiniteMagnitude))
        var titleLabelFrame: CGRect = titleLabel.frame
        titleLabelFrame.size = titleLabelSize
        titleLabelFrame.origin.x = rint((width - titleLabelSize.width) / 2.0)
        titleLabelFrame.origin.y = imageFrame.maxY + kPadding
        titleLabel.frame = titleLabelFrame
        
        let messageLabelSize: CGSize = messageLabel.sizeThatFits(CGSize(width: width - kPadding * 4.0, height: CGFloat.greatestFiniteMagnitude))
        var messageLabelFrame: CGRect = messageLabel.frame
        messageLabelFrame.size = messageLabelSize
        messageLabelFrame.origin.x = rint((width - messageLabelSize.width) / 2.0)
        messageLabelFrame.origin.y = rint(titleLabelFrame.maxY + kPadding / 2.0)
        messageLabel.frame = messageLabelFrame
        
        var containerViewFrame: CGRect = containerView.frame
        containerViewFrame.size.width = width
        containerViewFrame.size.height = messageLabelFrame.maxY + kPadding
        containerView.frame = containerViewFrame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
