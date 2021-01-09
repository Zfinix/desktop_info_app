import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    var flutterViewController = FlutterViewController.init()
    var windowFrame = self.frame
         
    self.minSize = NSSize(width: 590, height: 590)
    self.maxSize = self.minSize
    windowFrame.size = self.minSize
    
    self.contentViewController = flutterViewController
    
    self.setFrame(windowFrame, display: true)
    
    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
