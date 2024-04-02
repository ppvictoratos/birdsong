//: A UIKit based Playground for presenting user interface
  
import UIKit
import XCTest
import Foundation
import PlaygroundSupport

class Hexagram {
    var id: Int = 0
    var title: String = "Hexagrams"
    var passage: String = "iChing Divinations"    
}

class HexagramSetupTest: XCTestCase {
    var hexagram: Hexagram!
    
    override func setUp() {
        super.setUp()
        hexagram = Hexagram()
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
