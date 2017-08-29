//
//  ViewController.swift
//  HttpDemoSwift
//
//  Created by Lori Wang on 2017/8/29.
//  Copyright © 2017年 Lori Wang. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myTextView: UITextView!
    
    let urlStrForSampleImg = "http://animal-adoption.coa.gov.tw/uploads/animal_album/91/b83ad71c752c603ce6ca8297b704c25c.png"
    let urlStrForData = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // 1 show Image
        let urlForImg = URL(string: urlStrForSampleImg)
        
        // 非同步ＧＣＤ
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlForImg!)
            guard data != nil else { return }
            
            DispatchQueue.main.async {
                self.myImageView.image = UIImage(data: data!)
            }
        }
        
    // 2 get json data
        getJsonDataByAlamofire(urlString: urlStrForData)
        
    }
    
    func getJsonDataByAlamofire(urlString: String) {
        Alamofire.request(URL(string: urlString)!).responseJSON { (response) in
            // 避免取得資料為nil
            if let json = response.result.value {
                print(json)
                self.myTextView.text = String(describing: json)
                
            }else {
                print("no json data")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

