//
//  ViewController.swift
//  testAlamofire
//
//  Created by chenzhizs on 2022/04/06.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    //test
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AlamofireでAPIリクエストをする
        AF.request("https://qiita.com/api/v2/items")
            // レスポンスをJSON形式で受け取る
            .responseJSON { response in
                switch response.result {
                case .success:
                    let decoder: JSONDecoder = JSONDecoder()
                    do {
                        // decode関数の引数にはJSONからマッピングさせたいクラスをと実際のデータを指定する
                        let articles: [Article] = try decoder.decode([Article].self, from: response.data!)
                        print(articles)
                    } catch {
                        // JSONの形式とクラスのプロパティが異なっている場合には失敗する
                        print("failed")
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("error", error)
                }
        }
    }

}

