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
                    Text(viewModel.calculatorDisplay)
                        .bold()
                        .font(.system(size: LayoutConstants.fontSizeCalculatorString))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.3)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                ForEach(buttons.indices, id: \.self) { index in
                    HStack(spacing: 12) {
                        ForEach(buttons[index], id: \.title) { item in
                            Button(action: {
                                viewModel.addAction(of: item)
                            }, label: {
                                Text(item.title)
                                    .font(.system(size: LayoutConstants.fontSizeButton, weight: .bold))
                                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: item.buttonHeight)
                                    .background(RoundedRectangle(cornerRadius: 25, style: .continuous).fill(item.buttonColor))
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
}
