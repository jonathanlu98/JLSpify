//
//  JLExtension.swift
//  JLSptfy
//
//  Created by Jonathan Lu on 2020/2/10.
//  Copyright © 2020 Jonathan Lu. All rights reserved.
//

import UIKit
import RxSwift
import MarqueeLabel

extension UITableViewCell {
    var dispose: DisposeBag {
        get {
            return DisposeBag()
        }
    }
    
    func fetchImage(_ url:URL?,imageView:UIImageView) {
        imageView.alpha = 0
        if (url != nil) {
            imageView.sd_setImage(with: url, placeholderImage: nil, options: .retryFailed) { image, error, type, uurl in
                
                if (image != nil) {
                switch type {
                case .none, .disk, .all:
                        UIImageView.animate(withDuration: 0.2) {
                            imageView.alpha = 1
                        }
                case .memory:
                        imageView.alpha = 1

                @unknown default: break
                    }
                }
            }
        } else {
            UIImageView.animate(withDuration: 0.2) {
                imageView.alpha = 1
            }
        }
        
    }
}

extension  MarqueeLabel {
    func shouldCancelAutoresizing(_ bool:Bool) -> MarqueeLabel {
        if bool == true {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
    
    func configLabel(font:UIFont, textColor:UIColor, textAlignment:NSTextAlignment, type:MarqueeType) {
        self.animationDelay = 2
        self.leadingBuffer = 0
        self.trailingBuffer = 60
        self.fadeLength = 13
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.type = type
    }
    
}


extension UIImageView {
    func shouldCancelAutoresizing(_ bool:Bool) -> UIImageView {
        if bool == true {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        return self
    }
}

extension UIViewController {

    func presentAlertController(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true)
        }

    }
}

extension String {
    func widthForComment(font: UIFont, height: CGFloat = 15) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
}