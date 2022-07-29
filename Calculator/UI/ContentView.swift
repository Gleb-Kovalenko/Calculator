import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = ViewModel()
    
    let buttons: [[CalculatorButton]] = [
        [.clearAll, .openBracket, .closeBracket, .percent],
        [.sinus, .cosinus, .tangens, .arctan],
        [.power, .factorial, .squart, .division],
        [.digit("7"), .digit("8"), .digit("9"), .multiply],
        [.digit("4"), .digit("5"), .digit("6"), .substraction],
        [.digit("1"), .digit("2"), .digit("3"), .addition],
        [.digit("0"), .point, .clearLast, .equal]
    ]
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack(alignment: .trailing) {
                    viewModel.displayTextView()
                        .bold()
                        .font(.system(size: LayoutConstants.fontSizeCalculatorString))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.3)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                ForEach(buttons.indices, id: \.self) { index in
                    HStack(spacing: 12) {
                        ForEach(buttons[index], id: \.title) { button in
                            Button(action: {
                                viewModel.buttonTapped(button: button)
                            }, label: {
                                Text(button.title)
                                    .font(.system(size: LayoutConstants.fontSizeButton, weight: .bold))
                                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: buttonHeight(shape: viewModel.buttonShape))
                                    .background(buttonBackgroundStyle(shape: viewModel.buttonShape, button: button))
                                    .foregroundColor(.white)
                                    .cornerRadius(50)
                                    .minimumScaleFactor(0.3)
                            })
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func buttonBackgroundStyle(shape: ButtonShape, button: CalculatorButton) -> some View {
        switch shape {
        case .circle:
            return AnyView(Circle().fill(LayoutConstants.buttonColor(button: button)))
        case .rounded:
            return AnyView(RoundedRectangle(cornerRadius: 25, style: .continuous).fill(LayoutConstants.buttonColor(button: button)))
        }
    }
    
    private func buttonHeight(shape: ButtonShape) -> CGFloat {
        switch shape {
        case .circle:
            return (UIScreen.main.bounds.height / 2.4 - 5 * 10) / 4
        case .rounded:
            return (UIScreen.main.bounds.height / 2.7 - 5 * 10) / 4
        }
    }
    
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - LayoutConstants

private enum LayoutConstants {
    static let fontSizeButton = UIScreen.main.bounds.width * 0.06
    static let fontSizeCalculatorString = UIScreen.main.bounds.width * 0.2
    
    static func buttonColor(button: CalculatorButton) -> Color {
        switch button {
        case .equal, .addition, .multiply, .substraction, .division:
            return .orange
        case .clearAll, .percent, .openBracket, .closeBracket:
            return Color(UIColor.darkGray)
        case .sinus, .cosinus, .power, .factorial, .tangens, .squart, .arctan:
            return .lightDarkGray
        case .point, .digit, .clearLast:
            return .gray
        }
    }
}
