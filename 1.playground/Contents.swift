//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class Touchable : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panAround(sender:)))
        addGestureRecognizer(panGR)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    @objc func panAround(sender: UIPanGestureRecognizer) {
        super.bringSubviewToFront(self)
        let scale: CGFloat = 1.07
        let scaledTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        let translation = sender.translation(in: self)
        var theTransform = scaledTransform
        theTransform.tx = translation.x
        theTransform.ty = translation.y
        
        transform = theTransform
        
        if sender.state == .ended {
            let newCenter = CGPoint(
                x: center.x + transform.tx,
                y: center.y + transform.ty)
            transform = CGAffineTransform.identity
            center = newCenter
            return
        }
    }
}

class MyViewController : UIViewController {
    let rect = Touchable()
    let label = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        rect.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        rect.frame = CGRect(x: 50, y: 70, width: 100, height: 100)
        
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(rect)
        view.addSubview(label)
        
    }
}

protocol Tol {
    var x: Int { get }
}
struct J: Tol {
    var x: Int = 5
}
func draw(val: JTol) {
    print(val)
}


let vc = MyViewController()
vc.preferredContentSize = CGSize(width: 768, height: 1024)
PlaygroundPage.current.liveView = vc