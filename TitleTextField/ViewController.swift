//
//  ViewController.swift
//  TitleTextField
//
//  Created by Николай Гринько on 25.12.2023.
//

import UIKit

class ViewController: UIViewController {

    private let mainTextfireld = UITextField()
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureMainTextField()
        configureMainTitleLabel()
        
        
    }
}

private extension ViewController {
    
    func configureMainTextField() {
        mainTextfireld.layer.borderWidth = 2
        mainTextfireld.layer.borderColor = UIColor.darkGray.cgColor
        mainTextfireld.layer.cornerRadius = 10
        mainTextfireld.frame = CGRect(x: 20,
                                      y: 100,
                                      width: view.frame.width - 40,
                                      height: 50)
        mainTextfireld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        mainTextfireld.leftViewMode = .always
        mainTextfireld.returnKeyType = .done
        mainTextfireld.delegate = self
        view.addSubview(mainTextfireld)
    }
    
    func configureMainTitleLabel() {
        titleLabel.text = " Placeholder "
        titleLabel.textColor = .darkGray
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont(name: "Arial", size: 20)
        titleLabel.frame.size = titleLabel.getTextSize()
        titleLabel.anchorPoint = CGPoint(x: 0, y: 0)
        titleLabel.frame.origin = CGPoint(x: mainTextfireld.frame.origin.x + 10,
                                          y: mainTextfireld.frame.midY - titleLabel.frame.size.height / 2)
        view.addSubview(titleLabel)
        
    }
}
// MARK: UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) {
            self.titleLabel.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.titleLabel.frame.origin = CGPoint(x: self.mainTextfireld.frame.origin.x + 15,
                                              y: self.mainTextfireld.frame.minY - self.titleLabel.frame.height / 2)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) {
            self.titleLabel.transform = .identity
            self.titleLabel.frame.origin = CGPoint(x: self.mainTextfireld.frame.origin.x + 10,
                                                   y: self.mainTextfireld.frame.midY - self.titleLabel.frame.size.height / 2)
        }
    }
    // return keyboard next and "Placeholder"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension UILabel {
    
    func getTextSize() -> CGSize {
        guard let text else { return CGSize() }
        
        let fontName = font.fontName
        let fontSize = font.pointSize
        let font = UIFont(name: fontName, size: fontSize)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        return CGSize(width: size.width.rounded(), height: size.height.rounded())
    }
    
}
