//
//  ViewController.swift
//  BMICalculator
//
//  Created by Minjae Kim on 5/21/24.
//

import UIKit

enum Warnig {
    case success, failure
}

class ViewController: UIViewController {

    @IBOutlet var mainTitleLabelList: [UILabel]!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet var subTitleLabelList: [UILabel]!
    
    
    @IBOutlet var textFieldBackgroudViewList: [UIView]!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var weightSecureButton: UIButton!
    
    @IBOutlet var warnigLabelList: [UILabel]!
    
    
    @IBOutlet weak var randomBMICalcButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    private var isSecure = true
    private var isEnabledHeight = false
    private var isEnabledWeight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        configTitleLabel()
        configImage()
        configSubTitle()
        confingTextFieldBackground()
        configUserTextField()
        configRandomButton()
        configSubmitButton()
    }
    
    private func configTitleLabel() {
        let textList = ["BMI Calculator", "당신의 BMI 지수를", "알려드릴게요."]
        let fontList = [UIFont.systemFont(ofSize: 25, weight: .bold), UIFont.systemFont(ofSize: 17, weight: .semibold), UIFont.systemFont(ofSize: 17, weight: .semibold)]
        
        for i in 0..<mainTitleLabelList.count {
            let label = self.mainTitleLabelList[i]
            
            let text = textList[i]
            let font = fontList[i]
            
            configLabel(label: label, text: text, font: font)
        }
    }
    
    private func configLabel(label: UILabel, text: String, font: UIFont) {
        label.text = text
        label.font = font
        
    }
    
    private func configImage() {
        let image = UIImage.image.withRenderingMode(.alwaysOriginal)
        self.mainImageView.image = image
        self.mainImageView.contentMode = .scaleAspectFit
    }
    
    private func configSubTitle() {
        let textList = ["키가 어떻게 되시나요?", "몸무게는 어떻게 되시나요?"]
        
        for i in 0..<textList.count {
            let label = self.subTitleLabelList[i]
            
            let text = textList[i]
            let font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            
            configLabel(label: label, text: text, font: font)
        }
    }
    
    private func confingTextFieldBackground() {
        for i in 0..<textFieldBackgroudViewList.count {
            let view = self.textFieldBackgroudViewList[i]
            let cornerRadius: CGFloat = 15
            let borderWidth: CGFloat = 2
            let borderColor: CGColor = UIColor.darkGray.cgColor
            
            configBackgroundView(view: view,
                                 cornerRadius: cornerRadius,
                                 borderWidth: borderWidth,
                                 borderColor: borderColor)
        }
    }
    
    private func configBackgroundView(view: UIView, 
                                      cornerRadius: CGFloat,
                                      borderWidth: CGFloat,
                                      borderColor: CGColor) {
        view.layer.cornerRadius = cornerRadius
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor
    }
    
    private func configUserTextField() {
        configTextField(textField: self.heightTextField,
                        borderStyle: .none)
        configTextField(textField: self.weightTextField,
                        borderStyle: .none)
        
        configSecureButton()
    }
    
    private func configTextField(textField: UITextField,
                                 borderStyle: UITextField.BorderStyle) {
        textField.borderStyle = borderStyle
        textField.placeholder = "(단위: cm, 소수점 입력 가능)"
        
        for i in 0..<warnigLabelList.count {
            let label = self.warnigLabelList[i]
            
            configWarningLabel(label: label,
                               warningType: .success)
        }
    }
    
    private func configSecureButton() {
        self.weightTextField.isSecureTextEntry = isSecure
        let image = isSecure ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        self.weightSecureButton.setImage(image, for: .normal)
        self.weightSecureButton.tintColor = .lightGray
    }
    
    @IBAction func secureButtonClicked(_ sender: UIButton) {
        self.isSecure.toggle()
        configSecureButton()
    }
    
    @IBAction func changedTextFieldText(_ sender: UITextField) {
        var warningHeight: Warnig = .failure
        var warningWeight: Warnig = .failure
        
        let height = heightTextField.text ?? ""
        let weight = weightTextField.text ?? ""
        
        let pattern: String = "^[0-9]*$"
        
        if let _ = height.range(of: pattern, options: .regularExpression) {
            self.isEnabledHeight = height.isEmpty ? false : true
            warningHeight = height.isEmpty ? .failure : .success
        } else {
            self.isEnabledHeight = false
            warningHeight = .failure
        }
        
        if let _ = weight.range(of: pattern, options: .regularExpression) {
            self.isEnabledWeight = weight.isEmpty ? false : true
            warningWeight = weight.isEmpty ? .failure : .success
        } else {
            self.isEnabledWeight = false
            warningWeight = .failure
        }
        
        configWarningTextField(view: self.textFieldBackgroudViewList[0], isEnabled: isEnabledHeight)
        
        configWarningLabel(label: warnigLabelList[0],
                           warningType: warningHeight)
        
        configWarningTextField(view: self.textFieldBackgroudViewList[1], isEnabled: isEnabledWeight)
        
        configWarningLabel(label: warnigLabelList[1],
                           warningType: warningWeight)
        
        self.submitButton.isEnabled = isEnabledHeight && isEnabledWeight
    }
    
    private func configWarningTextField(view: UIView, isEnabled: Bool) {
        view.layer.borderColor = isEnabled ? UIColor.darkGray.cgColor : UIColor.red.cgColor
    }
    
    private func configWarningLabel(label: UILabel,
                                    warningType: Warnig) {
        switch warningType {
        case .success:
            label.text = nil
        case .failure:
            label.text = "공백없이 숫자만 입력해주세요."
            label.font = .systemFont(ofSize: 12)
            label.textColor = .red
        }
    }
    
    
    private func configRandomButton() {
        let title = "랜덤으로 BMI 계산하기"
        self.randomBMICalcButton.setTitle(title, for: .normal)
        self.randomBMICalcButton.titleLabel?.font = .systemFont(ofSize: 15)
        self.randomBMICalcButton.tintColor = .brown
    }
    
    private func configSubmitButton() {
        self.submitButton.setTitle("결과 확인", for: .normal)
        self.submitButton.titleLabel?.font = .systemFont(ofSize: 20)
        self.submitButton.titleLabel?.textColor = .white
        self.submitButton.layer.cornerRadius = 15
        self.submitButton.tintColor = .white
        self.submitButton.backgroundColor = .purple
        self.submitButton.isEnabled = false
    }
    
    private func roundTwo(num: Double) -> Double {
        let digit: Double = 10.0
        return round(num * digit) / digit
    }
    
    private func calculateBMI(height: Double, weight: Double) -> Double {
        return (weight / pow(height, 2)) * pow(10, 4)
    }
    
    @IBAction func calculateBMIButtonClicked(_ sender: UIButton) {
        let title = "BMI 계산"
        var message = ""
        var bmi: Double?
        
        if sender.tag == 0 {
            let stringHeight = heightTextField.text ?? ""
            let stringWeight = weightTextField.text ?? ""
            
            if let doubleHeight = Double(stringHeight),
                let doubleWeight = Double(stringWeight) {
                
                bmi = roundTwo(num: calculateBMI(height: doubleHeight, weight: doubleWeight))
            }
        } else {
            let doubleHeight = roundTwo(num: Double.random(in: 140.0...200.0))
            let doubleWeight = roundTwo(num: Double.random(in: 40.0...200.0))
            
            self.heightTextField.text = "\(doubleHeight)"
            self.weightTextField.text = "\(doubleWeight)"
            bmi = roundTwo(num: calculateBMI(height: doubleHeight, weight: doubleWeight))
            
            configWarningTextField(view: self.textFieldBackgroudViewList[0], isEnabled: true)
            
            configWarningLabel(label: warnigLabelList[0],
                               warningType: .success)
            
            configWarningTextField(view: self.textFieldBackgroudViewList[1], isEnabled: true)
            
            configWarningLabel(label: warnigLabelList[1],
                               warningType: .success)
            
            self.submitButton.isEnabled = true
            view.endEditing(true)
        }
        
        if let bmi {
            switch bmi {
            case ..<18.6:
                message = "bmi 측정 결과: \(bmi)\n저체중입니다."
            case 18.5..<23.1:
                message = "bmi 측정 결과: \(bmi)\n정상입니다."
            case 23.0..<25.1:
                message = "bmi 측정 결과: \(bmi)\n과체중입니다."
            default:
                message = "bmi 측정 결과: \(bmi)\n비만입니다."
            }
        }
        
        // 1. alert 창 구성
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        // 2. alert button 구성
        let check = UIAlertAction(title: "확인", style: .cancel)
        
        // 3. alert에 button 추가
        alert.addAction(check)
        
        present(alert, animated: true)
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}

