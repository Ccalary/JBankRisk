//
//  PhotoPreviewToolbarView.swift
//  PhotoPicker
//
//  Created by liangqi on 16/3/9.
//  Copyright © 2016年 dailyios. All rights reserved.
//

import UIKit

protocol PhotoPreviewToolbarViewDelegate: class {
    func onToolbarBackArrowClicked();
    func onSelected(select:Bool)
}

class PhotoPreviewToolbarView: UIView {
    
    weak var delegate: PhotoPreviewToolbarViewDelegate?
    weak var sourceDelegate: PhotoPreviewViewController?
    
    private var checkboxBg: UIImageView?
    private var checkbox: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configView()
    }
    
    private func configView(){
        self.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        // back arrow buttton
        let backArrow = UIButton(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        let backArrowImage = UIImage(named: "arrow_back")
        backArrow.setImage(backArrowImage, for: UIControlState.normal)
        backArrow.addTarget(self, action: #selector(PhotoPreviewToolbarView.eventBackArrow), for: .touchUpInside)
        self.addSubview(backArrow)
        
        // right checkbox
        let padding: CGFloat = 10
        let checkboxWidth: CGFloat = 30
        let checkboxHeight = checkboxWidth
        let checkboxPositionX = self.bounds.width - checkboxWidth - padding
        let checkboxPositionY = (self.bounds.height - checkboxHeight) / 2
        
        self.checkbox = UIButton(type: .custom)
        checkbox!.frame = CGRect(x:checkboxPositionX,y: checkboxPositionY,width: checkboxWidth,height: checkboxHeight)
        checkbox!.addTarget(self, action: #selector(PhotoPreviewToolbarView.eventCheckbox(sender:)), for: .touchUpInside)
        
        let checkboxFront = UIImageView(image: UIImage(named: "picture_unselect"))
        checkboxFront.contentMode = .scaleAspectFill
        checkboxFront.frame = checkbox!.bounds
        checkbox!.addSubview(checkboxFront)
        
        self.checkboxBg = UIImageView(image: UIImage(named: "picture_select"))
        checkboxBg!.contentMode = .scaleAspectFill
        checkboxBg!.frame = checkbox!.bounds
        checkboxBg!.isHidden = true
        
        self.checkbox!.addSubview(checkboxBg!)
        
        self.addSubview(checkbox!)
    }
    
    // MARK: -  Event
    func eventBackArrow(){
        if let delegate = self.delegate {
            delegate.onToolbarBackArrowClicked()
        }
    }
    
    func setSelect(select:Bool){
        self.checkboxBg!.isHidden = !select
        self.checkbox!.isSelected = select
    }
    
    func eventCheckbox(sender: UIButton){
        if sender.isSelected {
            sender.isSelected = false
            self.checkboxBg!.isHidden = true
            if let delegate = self.delegate {
                delegate.onSelected(select: false)
            }
        } else {
            if let _ = self.sourceDelegate {
                if PhotoImage.instance.selectedImage.count >= PhotoPickerController.imageMaxSelectedNum - PhotoPickerController.alreadySelectedImageNum {
                    return self.showSelectErrorDialog()
                }
            }
            sender.isSelected = true
            self.checkboxBg!.isHidden = false
            self.checkboxBg!.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 8, options: [UIViewAnimationOptions.curveEaseIn], animations: { () -> Void in
                self.checkboxBg!.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            
            if let delegate = self.delegate {
                delegate.onSelected(select: true)
            }
        }
    }
    
    private func showSelectErrorDialog() {
        if self.sourceDelegate != nil {
            let less = PhotoPickerController.imageMaxSelectedNum - PhotoPickerController.alreadySelectedImageNum
            
            
            let range = PhotoPickerConfig.ErrorImageMaxSelect.range(of:"#")
            var error = PhotoPickerConfig.ErrorImageMaxSelect
            error.replaceSubrange(range!, with: String(less))
            
            let alert = UIAlertController.init(title: nil, message: error, preferredStyle: UIAlertControllerStyle.alert)
            let confirmAction = UIAlertAction(title: PhotoPickerConfig.ButtonConfirmTitle, style: .default, handler: nil)
            alert.addAction(confirmAction)
            self.sourceDelegate?.present(alert, animated: true, completion: nil)
        }
    }

}
