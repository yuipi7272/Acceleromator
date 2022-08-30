//
//  GameViewController.swift
//  Acceleromator
//
//  Created by Yui Ogawa on 2022/08/30.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {

    @IBOutlet var awaImageView: UIImageView!
    let motionManager = CMMotionManager()
    var accelerationX: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 加速度が使用できる状態か判断
        if motionManager.isAccelerometerAvailable {
            // 加速度の取得感覚を設定
            motionManager.accelerometerUpdateInterval = 0.01
            // 加速度が更新された時に呼ばれる
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
               // 現在の加速度を取得し、その値に基づきawaImageViewの座標を更新
                self.accelerationX = (data?.acceleration.x)!
                self.awaImageView.center.x += CGFloat(self.accelerationX * 20)
                
                // awaImageViewが水平器からはみ出さないようにX座標の限界値を設定
                if self.awaImageView.frame.origin.x < 40 {
                    self.awaImageView.frame.origin.x = 40
                }
                
                if self.awaImageView.frame.origin.x > 260 {
                    self.awaImageView.frame.origin.x = 260
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController: ResultViewController = segue.destination as! ResultViewController
        resultViewController.accelerationX = self.accelerationX
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
