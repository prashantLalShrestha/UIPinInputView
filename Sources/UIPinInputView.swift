//
//  UIPinInputView.swift
//  UIPinInputView
//
//  Created by Prashant Shrestha on 5/20/20.
//  Copyright © 2020 Inficare. All rights reserved.
//

import UIKit
import DeviceX

public final class UIPinInputView: UIView {
    public struct BaseDimension {
        public static var inset: CGFloat {
            switch DeviceX.current.size {
            case .screen4Inches:
                return 14
            case .screen4Dot7Inches, .screen5Dot5Inches:
                return 16
            case .screen5Dot8Inches, .screen6Dot1Inches, .screen6Dot5Inches:
                return 16
            default:
                return 16
            }
        }

        public static var height: CGFloat {
            switch DeviceX.current.size {
            case .screen4Inches:
                return 48
            case .screen4Dot7Inches, .screen5Dot5Inches:
                return 56
            case .screen5Dot8Inches, .screen6Dot1Inches, .screen6Dot5Inches:
                return 64
            default:
                return 64
            }
        }
    }


    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: textFields)
        view.axis = .horizontal
        view.spacing = BaseDimension.inset
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    private var textFields: [UITextField] = []
    private var pinCount: Int = 4

    private var textArray: [String] = []

    public var text: String? {
        return textArray.joined().count != pinCount ? nil : textArray.joined()
    }

    public init(pinCount: Int) {
        super.init(frame: .zero)
        if pinCount < 4 {
            self.pinCount = 4
        } else if pinCount > 6 {
            self.pinCount = 6
        } else {
            self.pinCount = pinCount
        }
        makeUI()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }


    private func makeUI() {
        for tag in 0...pinCount-1 {
            textFields.append(createInputTextField(tag: tag))
            textArray.append("")
        }
        stackView.spacing = BaseDimension.inset * (pinCount == 6 ? 2 : pinCount == 5 ? 4 : 6) / CGFloat(pinCount)


        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: BaseDimension.height).isActive = true

        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    private func createInputTextField(tag: Int) -> UITextField {
        let textField = CustomTextField()
        textField.tag = tag
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.delegate = self
        textField.backSpaceDelegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }


}


extension UIPinInputView: UITextFieldDelegate, UITextFieldBackSpaceDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFields.forEach { (arrayTextFieldValue) in
            if textField == arrayTextFieldValue {
                textField.layer.borderColor = UIColor.systemGreen.cgColor
                textField.backgroundColor = UIColor.green.withAlphaComponent(0.05)
            } else {
                arrayTextFieldValue.layer.borderColor = UIColor.lightGray.cgColor
                arrayTextFieldValue.backgroundColor = UIColor.clear
            }
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        textFields.forEach { (arrayTextFieldValue) in
            arrayTextFieldValue.layer.borderColor = UIColor.lightGray.cgColor
            arrayTextFieldValue.backgroundColor = UIColor.clear
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {

        for i in 0...textFields.count-1 {
            if textField == textFields[i] {
                if textField.text != "" && textField.text != nil {
                    textArray[i] = textField.text?.last.map({ String($0) }) ?? ""
                    textField.text = ""
                    textField.text = textArray[i]
                    if i < textFields.count-1 {
                        textFields[i+1].becomeFirstResponder()
                    }
                }
            }
        }
    }

    func deleteBackward(_ textField: UITextField) {
        for i in 0...textFields.count-1 {
            if textField == textFields[i] {
                if textField.text == "" || textField.text == nil {
                    if textArray[i] == "" {
                        if i > 0 {
                            textFields[i-1].text = ""
                            textArray[i-1] = ""
                            textFields[i-1].becomeFirstResponder()
                        }
                    } else {
                        textArray[i] = ""
                    }
                }
            }
        }
    }
}

fileprivate protocol UITextFieldBackSpaceDelegate {
    func deleteBackward(_ textField: UITextField)
}

fileprivate class CustomTextField: UITextField {



    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.count ?? 0)
        return end
    }

    var backSpaceDelegate: UITextFieldBackSpaceDelegate?
    override func deleteBackward() {
        super.deleteBackward()
        if text?.isEmpty ?? false {
            self.backSpaceDelegate?.deleteBackward(self)
        }
    }
}
