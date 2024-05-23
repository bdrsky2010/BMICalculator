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

enum Category {
    case height, weight
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
    @IBOutlet weak var resetButton: UIButton!
    
    private var isSecure = true
    private var isEnabledHeight = false
    private var isEnabledWeight = false
    
    private let nicknameKey = "nickname"
    private let heightKey = "height"
    private let weightKey = "weight"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    private func saveUserDefaultNickname(nickname: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
    
    private func loadUserDefaultNickname() {
        guard let nickname = UserDefaults.standard.string(forKey: nicknameKey) else { return }
        (navigationItem.titleView as! UILabel).text = nickname + " 님 안녕하세요."
    }
    
    private func saveUserDefault() {
        guard let height = heightTextField.text, let weight = weightTextField.text else {
            print("UserDefault 저장 실패")
            return
        }
        UserDefaults.standard.set(height, forKey: heightKey)
        UserDefaults.standard.set(weight, forKey: weightKey)
        print("UserDefault 저장 성공")
    }
    
    private func loadUserDefault() {
        guard let height = UserDefaults.standard.string(forKey: heightKey),
              let weight = UserDefaults.standard.string(forKey: weightKey) else {
            print("UserDefault 불러오기 실패")
            return
        }
        
        self.heightTextField.text = height
        self.weightTextField.text = weight
        print("UserDefault 불러오기 성공")
    }

    private func configUI() {
        configNaviBarNickname()
        configTitleLabel()
        configImage()
        configSubTitle()
        confingTextFieldBackground()
        configUserTextField()
        configRandomButton()
        configSubmitButton()
        configResetButton()
    }
    
    private func configNaviBarNickname() {
        let titleView = UILabel()
        titleView.text = "닉네임"
        titleView.font = .systemFont(ofSize: 17, weight: .semibold)
        titleView.textAlignment = .center
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(naviBarTitleTapped))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(gesture)
        
        navigationItem.titleView = titleView
        
        loadUserDefaultNickname()
    }
    
    @objc
    private func naviBarTitleTapped() {
        print(#function)
        // 1. alert 창 구성
        let title = "프로필 설정"
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        
        alert.addTextField { textField in
            let nickname = UserDefaults.standard.string(forKey: self.nicknameKey)
            
            textField.placeholder = "닉네임을 입력해주세요."
            
            // 저장된 닉네임이 있으면 textField에 해당 닉네임 띄어주기
            if let nickname = nickname, !nickname.isEmpty {
                // " 님 안녕하세요. 만큼의 문자열 제거"
                textField.text = nickname
            }
        }
        
        // 2. alert button 구성
        let save = UIAlertAction(title: "저장", style: .default) { [weak titleView = (self.navigationItem.titleView as! UILabel)] _ in
            if let nickname = alert.textFields![0].text {
                
                self.saveUserDefaultNickname(nickname: nickname)
                
                titleView?.text = nickname + " 님 안녕하세요."
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        // 3. alert에 button 추가
        alert.addAction(cancel)
        alert.addAction(save)
        
        present(alert, animated: true)
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
    
    // TextField의 Text가 사용가능한 상태인지 판단하는 메서드
    @discardableResult
    private func checkTextFieldText(_ text: String, category: Category) -> Bool {
        let pattern: String = "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
        
        if let _ = text.range(of: pattern, options: .regularExpression), !text.isEmpty {
            
            switch category {
            case .height:
                self.isEnabledHeight = true
            case .weight:
                self.isEnabledWeight = true
            }
            self.isEnabledHeight = true
            
            return true
        } else {
            
            switch category {
            case .height:
                self.isEnabledHeight = false
            case .weight:
                self.isEnabledWeight = false
            }
            
            return false
        }
    }
    
    @IBAction func changedTextFieldText(_ sender: UITextField) {
        var warningHeight: Warnig = .failure
        var warningWeight: Warnig = .failure
        
        let height = heightTextField.text ?? ""
        let weight = weightTextField.text ?? ""
        
        if checkTextFieldText(height, category: .height) {
            warningHeight = .success
        } else {
            warningHeight = .failure
        }
        
        if checkTextFieldText(weight, category: .weight) {
            warningWeight = .success
        } else {
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
    
    // 사용가능 유무에 따라 TextField를 감싸는 super view의 border color 세팅
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
        configButton(self.submitButton, title: "결과 확인")
        
        self.submitButton.isEnabled = {
            loadUserDefault()
            
            let height = heightTextField.text ?? ""
            let weight = weightTextField.text ?? ""
            
            checkTextFieldText(height, category: .height)
            checkTextFieldText(weight, category: .weight)
            
            return isEnabledHeight && isEnabledWeight
        }()
    }
    
    private func configResetButton() {
        configButton(self.resetButton, title: "리셋")
    }
    
    private func configButton(_ button: UIButton,
                              title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.tintColor = .white
        button.backgroundColor = .purple
    }
    
    // 소수점 둘째자리에서 반올림하는 메서드
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
        
        saveUserDefault()
        
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
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        self.heightTextField.text = nil
        self.weightTextField.text = nil
        self.submitButton.isEnabled = false
        saveUserDefault()
        view.endEditing(true)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}

