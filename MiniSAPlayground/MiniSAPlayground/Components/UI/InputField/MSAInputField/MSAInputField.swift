//
//  MSAInputField.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import SwiftUI
import Combine

enum InputType {
    case text
    case email
    case number
    case password

    var keyboardType: UIKeyboardType {
        switch self {
        case .text:
            return .default
        case .email:
            return .emailAddress
        case .number:
            return .numberPad
        case .password:
            return .default
        }
    }

    var autocapitalization: TextInputAutocapitalization {
        switch self {
        case .email:
            return .never
        default:
            return .sentences
        }
    }

    func validate(_ text: String) -> Bool {
        switch self {
        case .email:
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: text)
        case .number:
            return text.allSatisfy { $0.isNumber }
        default:
            return true
        }
    }
}

struct MSAInputField: View {
    // MARK: - Properties
    @Binding var text: String
    var placeholder: String
    var inputType: InputType
    var onSubmit: (() -> Void)?

    // MARK: - Optional Properties
    var cornerRadius: CGFloat = 8
    var borderWidth: CGFloat = 1
    var showValidation: Bool = true

    // MARK: - State Properties
    @State var isError: Bool = false
    @State var errorMessage: String = ""
    @State private var isSecured: Bool = true
    @State private var shakeAmount: CGFloat = 0

    // MARK: - Init
    init(
        text: Binding<String>,
        placeholder: String,
        inputType: InputType = .text,
        onSubmit: (() -> Void)? = nil,
        cornerRadius: CGFloat = 8,
        borderWidth: CGFloat = 1,
        showValidation: Bool = true
    ) {
        self._text = text
        self.placeholder = placeholder
        self.inputType = inputType
        self.onSubmit = onSubmit
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.showValidation = showValidation
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            // Text field or Secure field based on type
            ZStack(alignment: .trailing) {
                Group {
                    if inputType == .password && isSecured {
                        SecureField(placeholder, text: $text)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(inputType.autocapitalization)
                    } else {
                        TextField(placeholder, text: $text)
                            .keyboardType(inputType.keyboardType)
                            .autocorrectionDisabled(inputType == .email || inputType == .password)
                            .textInputAutocapitalization(inputType.autocapitalization)
                    }
                }
                .padding()
                .background(ColorToken.backgroundDefault.color.opacity(0.2))
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(isError ? ColorToken.buttonNegative.color : ColorToken.borderDefault.color,
                                lineWidth: borderWidth)
                )
                .onChange(of: text) { oldValue, newValue in
                    validateInput(newValue)
                }
                .offset(x: shakeAmount)
                .animation(.spring(response: 0.3, dampingFraction: 0.3), value: shakeAmount)

                // Show toggle button for password fields
                if inputType == .password {
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: isSecured ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 16)
                }
            }

            // Error message
            if isError && !errorMessage.isEmpty {
                Text(errorMessage)
                    .typography(.captionRegular)
                    .colorToken(.buttonNegative)
                    .padding(.leading, Spacing.default)
            }
        }
    }

    // MARK: - Private Methods
    private func validateInput(_ input: String) {
        guard showValidation else { return }

        if input.isEmpty {
            isError = false
            errorMessage = ""
            return
        }

        switch inputType {
        case .email:
            isError = !inputType.validate(input)
            errorMessage = isError ? "Please enter a valid email address" : ""
        case .number:
            isError = !inputType.validate(input)
            errorMessage = isError ? "Please enter numbers only" : ""
        case .password:
            isError = input.count < 6
            errorMessage = isError ? "Password must be at least 6 characters" : ""
        default:
            isError = false
            errorMessage = ""
        }

        if isError {
            triggerShakeAnimation()
        }
    }

    private func triggerShakeAnimation() {
        withAnimation(.default) {
            shakeAmount = 10
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.default) {
                shakeAmount = -10
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.default) {
                shakeAmount = 5
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.default) {
                shakeAmount = -5
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.default) {
                shakeAmount = 0
            }
        }
    }

    // MARK: - Public Methods
    func validate() -> Bool {
        let isValid = inputType.validate(text)
        isError = !isValid

        if !isValid {
            switch inputType {
            case .email:
                errorMessage = "Please enter a valid email address"
            case .number:
                errorMessage = "Please enter numbers only"
            case .password:
                errorMessage = "Password must be at least 6 characters"
            default:
                errorMessage = "Invalid input"
            }

            triggerShakeAnimation()
        }

        return isValid
    }

    // TODO: need to work on the error handling
    func setError(message: String) -> MSAInputField {
        var field = self
        field.isError = true
        field.errorMessage = message
        return field
    }

    func clearError() -> MSAInputField {
        var field = self
        field.isError = false
        field.errorMessage = ""
        return field
    }
}

// MARK: - Preview
struct MSAInputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            MSAInputField(
                text: .constant(""),
                placeholder: "Text input"
            )

            MSAInputField(
                text: .constant("yourname@company.com"),
                placeholder: "Email address",
                inputType: .email
            )
            .setError(message: "Invalid email address")

            MSAInputField(
                text: .constant("123"),
                placeholder: "Number only",
                inputType: .number
            )

            MSAInputField(
                text: .constant("password"),
                placeholder: "Password",
                inputType: .password
            )
        }
        .padding()
    }
}
