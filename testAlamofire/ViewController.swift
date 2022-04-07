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
    
    //显示测试结果的TextView
    @IBOutlet weak var testTextView: UITextView!
    
    @IBOutlet weak var buttonAlamofire: UIButton!
    
    @IBOutlet weak var buttonSwiftyJSON: UIButton!
    
    @IBAction func touchSwiftyJSONListen(_ sender: UIButton) {
        testSwiftyJSON()
    }
    
    @IBAction func touchAlamofireListen(_ sender: Any) {
        testAlamofire()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    func testAlamofire()  {
        // AlamofireでAPIリクエストをする
        AF.request("https://qiita.com/api/v2/items")
        // レスポンスをJSON形式で受け取る
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let decoder: JSONDecoder = JSONDecoder()
                        // decode関数の引数にはJSONからマッピングさせたいクラスをと実際のデータを指定する
                        let articles: [Article] = try decoder.decode([Article].self, from: response.data!)
                        print(articles)
                        
                        //显示测试的结果
                        self.testTextView.text =  articles.first?.title
                        
                        for i in (0 ..< articles.count) {
                            print("articles[i].title:" + articles[i].title)
                            print("articles[i].user.id:" + articles[i].user.id)
                        }
                        
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

    
    func testSwiftyJSON(){
        
        let url = URL(string: "https://pythonchannel.com/media/codecamp/201902/JSON-Sample3.json")

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try? JSON(data: data)
                let jsonData = json!["posts"][0]["name"]
                print("test SwiftyJSON !!!!!")
                print(jsonData)
            }
            }.resume()
    }
}

