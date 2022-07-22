import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State var expression = ""
    @State var fontSizeCalculatorString = UIScreen.main.bounds.width * 0.2
    @State var calculatorDisplay = ""
    
    let fontSizeButton = UIScreen.main.bounds.width * 0.1
    let calculator = CalculatorImplemantation(parser: MathExpressionParser(), converter: RPNExpressionConverter(), evaluator: RPNExpressionEvaluator())
    let buttons: [[CalculatorButton]] = [
            [.clearAll, .openBracket, .closeBracket, .percent, .division],
            [.sinus, .digit("7"), .digit("8"), .digit("9"), .multiply],
            [.cosinus, .digit("4"), .digit("5"), .digit("6"), .substraction],
            [.power, .digit("1"), .digit("2"), .digit("3"), .addition],
            [.factorial, .digit("0"), .point, .clearLast, .equal]
        ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack() {
                    Text(calculatorDisplay)
                        .bold()
                        .font(.system(size: fontSizeCalculatorString))
                        .foregroundColor(.white)
                        .minimumScaleFactor(0.3)
                }
                .padding()
                ForEach(buttons.indices, id: \.self){ index in
                    HStack(spacing: 12) {
                        ForEach(buttons[index], id: \.title) { item in
                            Button(action: {
                                do {
                                    switch item {
                                    case .equal:
                                        expression = try item.action(expression: expression, calculator: calculator)
                                        calculatorDisplay = expression
                                    default:
                                        expression = try item.action(expression: expression, calculator: nil)
                                        calculatorDisplay = expression
                                    }
                                } catch let error {
                                    calculatorDisplay = error.localizedDescription
                                    expression = ""
                                }
                            }, label: {
                                Text(item.title)
                                    .font(.system(size: item.fontSize(defaultFontSize: fontSizeButton)))
                                    .frame(width: 50, height: 70)
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .minimumScaleFactor(0.3)
                            })
                        }
                    }
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
