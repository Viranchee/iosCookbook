//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class Touchable : UIView, UIGestureRecognizerDelegate {
    
    var previousLocation = CGPoint.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        super.bringSubviewToFront(self)
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(panAround(sender:)))
        addGestureRecognizer(panGR)
        
        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(sender:)))
        addGestureRecognizer(pinchGR)
        
        let rotateGR = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(sender:)))
        addGestureRecognizer(rotateGR)
        
        guard (gestureRecognizers != nil) else { return }
        
        for gr in gestureRecognizers! {
            gr.delegate = self
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        previousLocation = center
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches ended")
    }
    
    /// 1-2 Draggable View without stored variables
    @objc func panAround(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: superview)
        let newCenter = CGPoint (
            x: previousLocation.x + translation.x,
            y: previousLocation.y + translation.y
        )
        /// 1-4 Constraining Movements to superview
        let midPoints = CGPoint (x: bounds.midX, y: bounds.midY)
        let newX = min(
            (superview ?? self).bounds.size.width - midPoints.x,
            max(newCenter.x, midPoints.x)
            )
        let newY = min(
            (superview ?? self).bounds.size.height - midPoints.y,
            max(newCenter.y, midPoints.y)
        )
        center = CGPoint(x: newX, y: newY)
       
    }
    
    @objc func handlePinch(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale > 0.5 ? sender.scale : 0.5
        transform = transform.scaledBy(x: scale, y: scale)
    }
    
    @objc func handleRotate(sender: UIRotationGestureRecognizer) {
        transform = transform.rotated(by: sender.rotation)
    }
 
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class Drawable: UIView, UIGestureRecognizerDelegate {
    
}

class MyViewController : UIViewController {
    let rect = Touchable(frame: CGRect(x: 50, y: 70, width: 100, height: 100))
    let label = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
//        rect.frame = CGRect(x: 50, y: 70, width: 100, height: 100)
        
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(rect)
        view.addSubview(label)
        
    }
}

let vc = MyViewController()
vc.preferredContentSize = CGSize(width: 768, height: 1024)
PlaygroundPage.current.liveView = vc
