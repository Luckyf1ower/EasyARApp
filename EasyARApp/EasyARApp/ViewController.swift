//
//  ViewController.swift
//  EasyARApp
//
//  Created by kaho ito on 2023/04/14.
//

import UIKit
import ARKit
import WebKit

class ViewController: UIViewController,ARSCNViewDelegate,WKNavigationDelegate  {
    
    @IBOutlet weak var arscnView: ARSCNView!
    @IBOutlet weak var webView: WKWebView!
    
    // 表示したいWebアプリケーションのURL
    let websiteURL: String = "https://sampleappi.web.app/"
    // ARコンテンツを表示する範囲（m）
    var ARsightRange:Float = 1.0
    // ARコンテンツにアクションできる範囲（m）
    var ARproximityRange:Float = 1.5
    
    let node = SCNNode()
    let material = SCNMaterial()
    var webImage: UIImage!
    var inSightARisAppear = true
    var inProximityARisAppear = true
    var prePosition:SCNVector3 = SCNVector3(0,0,0)
    
    private var getWebContentsTimer = Timer()
    private var loadARActionTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scn = SCNScene()
        arscnView.scene = scn
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arscnView.session.run(configuration)
        arscnView.showsStatistics = true
        
        webView.navigationDelegate = self
        let siteURL = URL(string: websiteURL)
        let request = URLRequest(url: siteURL!)
        webView.load(request)
        
    }
    
    func calcdist(A:SCNVector3, B:SCNVector3)->Float {
        let x = A.x - B.x
        let y = A.y - B.y
        let z = A.z - B.z
        let dist = sqrt(x*x+y*y+z*z)
        //print("dist:",dist)
        return dist
    }
    
    func Nodeset(node: SCNNode, image:UIImage, width: CGFloat, height: CGFloat){
        node.geometry = SCNBox(width: width, height: height, length: 0.0001, chamferRadius: 0)
        material.diffuse.contents = image
        node.geometry?.materials = [material]
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        repeatCapture()
        let imageSize = webImage.size
        let imageWidth = (imageSize.width)*0.001
        let imageHeight = (imageSize.height)*0.001
        
        Nodeset(node: node, image: webImage, width: imageWidth, height: imageHeight)
        node.position = SCNVector3(0,0,-0.3)
        prePosition = node.position
        arscnView.scene.rootNode.addChildNode(node)
//        print("9999999999999999999999")
        
        getWebContentsTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(repeatCapture), userInfo: nil, repeats: true)
        loadARActionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(events), userInfo: nil, repeats: true)
    }
    
    @objc func repeatCapture(){
        webImage = getWebImage(Web: webView)
        self.material.diffuse.contents = webImage
        self.node.geometry?.materials = [self.material]
    }
    
    func getWebImage(Web : WKWebView) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(Web.frame.size, true, 0)
        Web.drawHierarchy(in: Web.bounds, afterScreenUpdates: false)
            
        let renderedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        return renderedImage;
    }
    
    @objc func events(){
        let nodePosition = node.position
        
        let position = SCNVector3(0,0,0)
        var currentUserPosition = SCNVector3()
        if let camera = arscnView.pointOfView {
              currentUserPosition = camera.convertPosition(position, to: nil)
        }
        
        let dist = calcdist(A: nodePosition, B: currentUserPosition)
        if inProximityARisAppear == false{
            if dist < ARproximityRange{
                webView.evaluateJavaScript("ARWorld.doHandler('ARProximityEnter')"){(result, error) in
//                    self.node.isHidden = (result != nil)
                }
                inProximityARisAppear = true
            }
        }else{
            if dist > ARproximityRange{
                webView.evaluateJavaScript("ARWorld.doHandler('ARProximityLeave')"){(result, error) in
//                    self.node.isHidden = (result != nil)
                }
                inProximityARisAppear = false
            }else{
                let movedist = calcdist(A: currentUserPosition, B: prePosition)
                if movedist > 0.5{
                    webView.evaluateJavaScript("ARWorld.doHandler('ARProximityMove')"){(result, error) in
//                        self.node.isHidden = (result != nil)
                    }
                }
            }
        }
        
        if inSightARisAppear == false{
            if dist < ARsightRange{
                webView.evaluateJavaScript("ARWorld.doHandler('ARSightEnter')"){(result, error) in
//                    self.node.isHidden = (result != nil)
                }
                inSightARisAppear = true
            }
        }else{
            if dist > ARsightRange{
                webView.evaluateJavaScript("ARWorld.doHandler('ARSightLeave')", completionHandler: {(result, error) in
//                    self.node.isHidden = (result != nil)
                })
                inSightARisAppear = false
            }else{
                let movedist = calcdist(A: currentUserPosition, B: prePosition)
                if movedist > 0.1{
                    webView.evaluateJavaScript("ARWorld.doHandler('ARSightMove')"){(result, error) in
//                        self.node.isHidden = (result != nil)
                    }
                }
            }
        }
        prePosition = currentUserPosition
    }
}
