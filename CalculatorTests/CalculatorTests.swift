import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {
    
    private let mathParser = MathExpressionParser()
    private let mathConverter = RPNExpressionConverter()
    private let mathEvaluator = RPNExpressionEvaluator()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testParser() throws {
        let testParserDictionary: [String: [MathExpressionToken]] = [
            "sin(cos(5)) + (1 + (-5) - 2.6)*3.9": [
                .mathFunction(.sin),
                .bracket(.open),
                .mathFunction(.cos),
                .bracket(.open),
                .number(5.0),
                .bracket(.close),
                .bracket(.close),
                .binaryOperation(.addition),
                .bracket(.open),
                .number(1.0),
                .binaryOperation(.addition),
                .bracket(.open),
                .unaryOperation(.negative), 
                .number(5.0),
                .bracket(.close),
                .binaryOperation(.substraction),
                .number(2.6),
                .bracket(.close),
                .binaryOperation(.multiply),
                .number(3.9)
            ],
            "5 + (-3) / 2" : [
                .number(5.0),
                .binaryOperation(.addition),
                .bracket(.open),
                .unaryOperation(.negative),
                .number(3.0),
                .bracket(.close),
                .binaryOperation(.division),
                .number(2.0)
            ],
            "sin(cos(sin(cos(5 * 3 ^ 3 - (-3)))))" : [
                .mathFunction(.sin),
                .bracket(.open),
                .mathFunction(.cos),
                .bracket(.open),
                .mathFunction(.sin),
                .bracket(.open),
                .mathFunction(.cos),
                .bracket(.open),
                .number(5.0),
                .binaryOperation(.multiply),
                .number(3.0),
                .binaryOperation(.power),
                .number(3.0),
                .binaryOperation(.substraction),
                .bracket(.open),
                .unaryOperation(.negative),
                .number(3.0),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close)
            ],
            "(-5) + 4.21 * 0.941 / 2.3151": [
                .bracket(.open),
                .unaryOperation(.negative),
                .number(5.0),
                .bracket(.close),
                .binaryOperation(.addition),
                .number(4.21),
                .binaryOperation(.multiply),
                .number(0.941),
                .binaryOperation(.division),
                .number(2.3151)
            ],
            "sin((-5)) + 5 * 2.33 / 5.12 ^ 3.32": [
                .mathFunction(.sin),
                .bracket(.open),
                .bracket(.open),
                .unaryOperation(.negative),
                .number(5.0),
                .bracket(.close),
                .bracket(.close),
                .binaryOperation(.addition),
                .number(5.0),
                .binaryOperation(.multiply),
                .number(2.33),
                .binaryOperation(.division),
                .number(5.12),
                .binaryOperation(.power),
                .number(3.32)
            ],
            "9.44 * (sin(5.21) / cos(3.21)) / 5 ^ 2.3": [
                .number(9.44),
                .binaryOperation(.multiply),
                .bracket(.open),
                .mathFunction(.sin),
                .bracket(.open),
                .number(5.21),
                .bracket(.close),
                .binaryOperation(.division),
                .mathFunction(.cos),
                .bracket(.open),
                .number(3.21),
                .bracket(.close),
                .bracket(.close),
                .binaryOperation(.division),
                .number(5.0),
                .binaryOperation(.power),
                .number(2.3)
            ],
            "tg(3) - (-5.21) * 8.4 / 9.12": [
                .mathFunction(.tg),
                .bracket(.open),
                .number(3.0),
                .bracket(.close),
                .binaryOperation(.substraction),
                .bracket(.open),
                .unaryOperation(.negative),
                .number(5.21),
                .bracket(.close),
                .binaryOperation(.multiply),
                .number(8.4),
                .binaryOperation(.division),
                .number(9.12)
            ],
            "5.1 ^ 5.3 * 1.23 - 9.5 / 7.6 * cos((-1.2))": [
                .number(5.1),
                .binaryOperation(.power),
                .number(5.3),
                .binaryOperation(.multiply),
                .number(1.23),
                .binaryOperation(.substraction),
                .number(9.5),
                .binaryOperation(.division),
                .number(7.6),
                .binaryOperation(.multiply),
                .mathFunction(.cos),
                .bracket(.open),
                .bracket(.open),
                .unaryOperation(.negative),
                .number(1.2),
                .bracket(.close),
                .bracket(.close)
            ],
            "5.12 + 3.4  - 1.2   / COS(4.1) * sin(CoS((-9.1)))": [
                .number(5.12),
                .binaryOperation(.addition),
                .number(3.4),
                .binaryOperation(.substraction),
                .number(1.2),
                .binaryOperation(.division),
                .mathFunction(.cos),
                .bracket(.open),
                .number(4.1),
                .bracket(.close),
                .binaryOperation(.multiply),
                .mathFunction(.sin),
                .bracket(.open),
                .mathFunction(.cos),
                .bracket(.open),
                .bracket(.open),
                .unaryOperation(.negative),
                .number(9.1),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close)
            ],
            "cos(sin(tg(9.152))) * 1.23 / 4.3": [
                .mathFunction(.cos),
                .bracket(.open),
                .mathFunction(.sin),
                .bracket(.open),
                .mathFunction(.tg),
                .bracket(.open),
                .number(9.152),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close),
                .binaryOperation(.multiply),
                .number(1.23),
                .binaryOperation(.division),
                .number(4.3)
            ]
        ]
        for (expression, expectedResult) in testParserDictionary {
            let parserResult = try mathParser.parse(expression: expression)
            XCTAssertEqual(parserResult.count, expectedResult.count)
            for (parserToken, expectedToken) in zip(parserResult, expectedResult) {
                XCTAssertEqual(parserToken, expectedToken)
            }
        }
    }
    
    func testConverter() throws {
        let testConverterDictionary: [String: [MathExpressionToken]] = [
            "sin(cos(5)) + (1 + (-5) - 2.6)*3.9": [
                .number(5.0),
                .mathFunction(.cos),
                .mathFunction(.sin),
                .number(1.0),
                .number(5.0),
                .unaryOperation(.negative),
                .binaryOperation(.addition),
                .number(2.6),
                .binaryOperation(.substraction),
                .number(3.9),
                .binaryOperation(.multiply),
                .binaryOperation(.addition)
            ],
            "5 + (-3) / 2": [
                .number(5.0),
                .number(3.0),
                .unaryOperation(.negative),
                .number(2.0),
                .binaryOperation(.division),
                .binaryOperation(.addition)
            ],
            "sin(cos(sin(cos(5 * 3 ^ 3 - (-3)))))" : [
                .number(5.0),
                .number(3.0),
                .number(3.0),
                .binaryOperation(.power),
                .binaryOperation(.multiply),
                .number(3.0),
                .unaryOperation(.negative),
                .binaryOperation(.substraction),
                .mathFunction(.cos),
                .mathFunction(.sin),
                .mathFunction(.cos),
                .mathFunction(.sin)
            ],
            "(-5) + 4.21 * 0.941 / 2.3151": [
                .number(5.0),
                .unaryOperation(.negative),
                .number(4.21),
                .number(0.941),
                .binaryOperation(.multiply),
                .number(2.3151),
                .binaryOperation(.division),
                .binaryOperation(.addition)
            ],
            "sin((-5)) + 5 * 2.33 / 5.12 ^ 3.32": [
                .number(5.0),
                .unaryOperation(.negative),
                .mathFunction(.sin),
                .number(5.0),
                .number(2.33),
                .binaryOperation(.multiply),
                .number(5.12),
                .number(3.32),
                .binaryOperation(.power),
                .binaryOperation(.division),
                .binaryOperation(.addition)
            ],
            "9.44 * (sin(5.21) / cos(3.21)) / 5 ^ 2.3": [
                .number(9.44),
                .number(5.21),
                .mathFunction(.sin),
                .number(3.21),
                .mathFunction(.cos),
                .binaryOperation(.division),
                .binaryOperation(.multiply),
                .number(5.0),
                .number(2.3),
                .binaryOperation(.power),
                .binaryOperation(.division)
            ],
            "tg(3) - (-5.21) * 8.4 / 9.12": [
                .number(3.0),
                .mathFunction(.tg),
                .number(5.21),
                .unaryOperation(.negative),
                .number(8.4),
                .binaryOperation(.multiply),
                .number(9.12),
                .binaryOperation(.division),
                .binaryOperation(.substraction)
            ],
            "5.1 ^ 5.3 * 1.23 - 9.5 / 7.6 * cos((-1.2))": [
                .number(5.1),
                .number(5.3),
                .binaryOperation(.power),
                .number(1.23),
                .binaryOperation(.multiply),
                .number(9.5),
                .number(7.6),
                .binaryOperation(.division),
                .number(1.2),
                .unaryOperation(.negative),
                .mathFunction(.cos),
                .binaryOperation(.multiply),
                .binaryOperation(.substraction)
            ],
            "5.12 + 3.4  - 1.2   / COS(4.1) * sin(CoS((-9.1)))": [
                .number(5.12),
                .number(3.4),
                .binaryOperation(.addition),
                .number(1.2),
                .number(4.1),
                .mathFunction(.cos),
                .binaryOperation(.division),
                .number(9.1),
                .unaryOperation(.negative),
                .mathFunction(.cos),
                .mathFunction(.sin),
                .binaryOperation(.multiply),
                .binaryOperation(.substraction)
            ],
            "cos(sin(tg(9.152))) * 1.23 / 4.3": [
                .number(9.152),
                .mathFunction(.tg),
                .mathFunction(.sin),
                .mathFunction(.cos),
                .number(1.23),
                .binaryOperation(.multiply),
                .number(4.3),
                .binaryOperation(.division)
            ]
        ]
        
        for (expression, expectedResult) in testConverterDictionary {
            let parserResult = try mathParser.parse(expression: expression)
            let conveterResult = try mathConverter.convert(expression: parserResult)
            XCTAssertEqual(conveterResult.count, expectedResult.count)
            for (converterToken, expectedToken) in zip(conveterResult, expectedResult) {
                XCTAssertEqual(converterToken, expectedToken)
            }
        }
    }
    
    func testEvaluator() throws {
        let testEvaluatorDictionary: [String: Double] = [
            "sin(cos(5)) + (1 + (-5) - 2.6)*3.9": -25.46013,
            "5 + (-3) / 2": 3.5,
            "sin(cos(sin(cos(5 * 3 ^ 3 - (-3)))))": 0.62656,
            "(-5) + 4.21 * 0.941 / 2.3151": -3.28880,
            "sin((-5)) + 5 * 2.33 / 5.12 ^ 3.32": 1.01039,
            "9.44 * (sin(5.21) / cos(3.21)) / 5 ^ 2.3": 0.20522,
            "tg(3) - (-5.21) * 8.4 / 9.12": 4.65614,
            "5.1 ^ 5.3 * 1.23 - 9.5 / 7.6 * cos((-1.2))": 6918.28760,
            "5.12 + 3.4  - 1.2   / COS(4.1) * sin(CoS((-9.1)))": 6.82469,
            "cos(sin(tg(9.152))) * 1.23 / 4.3": 0.27521
        ]
        for (expression, expectedResult) in testEvaluatorDictionary {
            let parserResult = try mathParser.parse(expression: expression)
            let conveterResult = try mathConverter.convert(expression: parserResult)
            let evaluatorResult = try mathEvaluator.evaluate(expression: conveterResult)
            XCTAssertEqual(evaluatorResult, expectedResult)
        }
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
