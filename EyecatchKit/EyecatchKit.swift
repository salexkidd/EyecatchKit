/*
 The MIT License (MIT)
 
 Copyright (c) 2018 salexkidd.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import Cocoa

public let kDefaultEyecatchFadeoutInterval: TimeInterval = 0.5
public let kDefaultEyecatchFadeoutDulation: TimeInterval = 0.3
public let kDefaultEyecatchImageAlphaValue: CGFloat = CGFloat(1)
public let kDefaultEyecatchXAxisPercentage: Float = Float(0.5)
public let kDefaultEyecatchYAxisPercentage: Float = Float(0.5)


public class ECEyecatch {

    public static func flash(
        sender: Any,
        image: NSImage,
        fadeOutInterval: TimeInterval = kDefaultEyecatchFadeoutInterval,
        fadeoutDulation: TimeInterval = kDefaultEyecatchFadeoutDulation,
        imageAlphaValue: CGFloat = kDefaultEyecatchImageAlphaValue,
        XAxisPercentage: Float = kDefaultEyecatchXAxisPercentage,
        YAxisPercentage: Float = kDefaultEyecatchYAxisPercentage,
        completion: @escaping () -> Void
    ) {
        let bundle = Bundle(identifier: "com.salexkidd.EyecatchKit")
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "EyecatchKit"), bundle: bundle)

        let windowController = storyboard.instantiateInitialController() as! EyecatchWindowController
        let viewController = windowController.contentViewController as! EyecatchViewController
        let window = windowController.window!
        
        // set window size
        window.setFrame(NSRect(origin: NSZeroPoint, size: image.size), display: false)
        // set image
        viewController.imageView.image = image
        viewController.imageView.alphaValue = imageAlphaValue
        
        // find on mouse screen and set frame.
        var screen: NSScreen? = nil
        for s in NSScreen.screens {
            if NSPointInRect(NSEvent.mouseLocation, s.frame) {
                screen = s
                break
            }
        }
        
        if screen == nil { return }
        
        let newPoint = NSPoint(
            x: ((screen!.frame.size.width - window.frame.size.width) / 100) * (CGFloat(XAxisPercentage) * 100) + NSMinX(screen!.frame),
            y: ((screen!.frame.size.height - window.frame.size.height) / 100) * (CGFloat(YAxisPercentage) * 100) + NSMinY(screen!.frame)
        )
        
        window.setFrame(
            NSRect(x: newPoint.x, y: newPoint.y, width: window.frame.width, height: window.frame.height),
            display: false
        )
        
        // Show window and animation.
        window.orderFront(self)
        
        Timer.scheduledTimer(withTimeInterval: fadeOutInterval, repeats: false) { (Timer) in
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = fadeoutDulation
                window.animator().alphaValue = 0
            }, completionHandler: {
                window.orderOut(sender)
                window.alphaValue = 1
                window.close()
                completion()
            })
        }
    }
}

internal class EyecatchWindowController: NSWindowController {
    override public func windowDidLoad() {
        super.windowDidLoad()
        window?.styleMask = .borderless
        window?.level = .screenSaver
        window?.collectionBehavior = .canJoinAllSpaces
        window?.isMovable = false
        window?.backgroundColor = NSColor.clear
        window?.alphaValue = 1.0
        window?.hasShadow = false
        window?.isOpaque = false
        window?.titlebarAppearsTransparent = true
    }
}


public class EyecatchViewController: NSViewController {
    @IBOutlet var imageView: NSImageView!
}
