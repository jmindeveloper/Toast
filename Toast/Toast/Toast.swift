//
//  Toast.swift
//  Toast
//
//  Created by J_Min on 2022/10/08.
//

import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
    
    convenience init(text: String) {
        self.init()
        self.numberOfLines = 0
        self.textAlignment = .center
        self.text = text
        let contentSize = intrinsicContentSize
        self.frame.size = contentSize
    }
}

extension UIView {
    /// message: message
    /// bottomPosition: view의 bottom에서 얼마나 떨어질지
    /// showDuration: 보여지고 사라지는 시간
    /// duration: 보여지는 시간
    /// autoHide: 자동으로 사라질지 여부 (해당값이 true일경우 duration은 무의미)
    @discardableResult
    func toast(
        message: String,
        bottomPosition: CGFloat,
        showDuration: TimeInterval,
        duration: TimeInterval = 0,
        autoHide: Bool = true
    ) -> UIView {
        let label = PaddingLabel(text: message)
        label.text = message
        let x = (frame.width / 2) - (label.frame.width / 2)
        label.frame.origin = CGPoint(x: x, y: frame.height - bottomPosition)
        
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textColor = .white
        label.layer.cornerRadius = label.frame.height / 2
        label.layer.masksToBounds = true
        showToast(view: label, showDuration: showDuration, duration: duration, autoHide: autoHide)
        
        return label
    }
    
    /// 토스트 보이기
    func showToast(view: UIView, showDuration: TimeInterval, duration: TimeInterval, autoHide: Bool) {
        addSubview(view)
        view.alpha = 0
        
        UIView.animate(withDuration: showDuration, delay: 0, options: [.curveEaseIn]) {
            view.alpha = 1
        } completion: { [weak self] isFinish in
            guard let self = self else { return }
            if autoHide && isFinish {
                self.hideToast(view: view, hideDuration: showDuration, duration: duration)
            }
        }
    }
    
    /// 토스트 사라지기
    /// (해당 함수를 직접 호출할경우 duration만큼 delay후 사라짐)
    func hideToast(view: UIView, hideDuration: TimeInterval, duration: TimeInterval = 0) {
        UIView.animate(withDuration: hideDuration, delay: duration, options: [.curveEaseOut]) {
            view.alpha = 0
        } completion: { _ in
            view.removeFromSuperview()
        }
    }
}

