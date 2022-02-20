//
//  SetupApiSettingsView.swift
//  SpaceNewsApp
//
//  Created by Руслан Осмаев on 01.02.2022.
//

import UIKit

class SetupApiSettingsView: UIView {
    
    weak var delegate: SetupApiDelegate?

	// MARK: - Radius
	lazy var radiusSlider: UISlider = {
		var slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.value = 25
        return slider
	}()
    
    lazy var radiusLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Radius"
        return label
    }()
    
    lazy var radiusHorizontalStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            radiusLabel,
            radiusSlider
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 32
        return stack
    }()
    
    // MARK: - Min population
    lazy var minPopulationTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter min population"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var minPopulationLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Min population"
        return label
    }()
    
    lazy var minPopulationHorizontalStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            minPopulationLabel,
            minPopulationTextField
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 32
        return stack
    }()
    
    // MARK: - Max population
    lazy var maxPopulationTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter max population"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var maxPopulationLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max population"
        return label
    }()
    
    lazy var maxPopulationHorizontalStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [
            maxPopulationLabel,
            maxPopulationTextField
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 32
        return stack
    }()
    
    // MARK: - Submit Button
    lazy var submitButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(submitButtonHandler), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Vertical Stack
    lazy var verticalStackView: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [
        radiusHorizontalStack,
        minPopulationHorizontalStack,
        maxPopulationHorizontalStack
       ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 32
        return stack
    }()
	
		/// Метод для добавления constraints
	private func addConstraints() {
		NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            verticalStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            verticalStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            verticalStackView.heightAnchor.constraint(equalToConstant: 160),
            maxPopulationTextField.heightAnchor.constraint(equalTo: minPopulationTextField.heightAnchor),
            radiusSlider.widthAnchor.constraint(equalTo: minPopulationTextField.widthAnchor),
            minPopulationTextField.widthAnchor.constraint(equalTo: maxPopulationTextField.widthAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
            submitButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            submitButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            submitButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16)
		])
	}
	
	// MARK: - Initialize
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(verticalStackView)
        addSubview(submitButton)
		addConstraints()
        backgroundColor = .systemBackground
        removeKeyboard()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    private func removeKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UITextField.endEditing(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func submitButtonHandler() {
        delegate?.submitButtonHandler()
    }
}
