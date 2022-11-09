//
//  ViewController.swift
//  PopularPosts
//
//  Created by Ismael Bautista on 11/7/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var table: UITableView!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    

    var resultsReddit:ResultsPosts?
    var rowCounter:Int = 0
    var isLoaded:Bool = false
    
    var redditURL:String = "https://www.reddit.com/r/all/top.json"
    
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print("Loading")
        
        table.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.sectionFooterHeight = 10.0;
        nextButton.setTitle("\("next"~)", for: .normal)
        prevButton.setTitle("\("prev"~)", for: .normal)
        table.backgroundColor = UIColor.redditLightestBlue
        table.layer.cornerRadius = 10
        table.rowHeight = UITableView.automaticDimension
        
        
        //resultsReddit = self.parseJSON()
        
        AF.request(redditURL, method: .get).responseData {
            (response) in
            if case .success(let value) = response.result {
                print("Got the info")
                print(value)
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                   // let dict: [String: Any] = getDictionarySomehow()
                    

                    self.resultsReddit = try decoder.decode(ResultsPosts.self, from: value)
                    self.isLoaded = true
                    //self.table. = 5
                    //self
                    self.table.numberOfRows(inSection: 1)
                    self.table.reloadData()
                    //self.resultsReddit = try decoder.decode(ResultsPosts.self,from:getData)
                } catch  {
                    print("Invalid result \(error)")
                }
                
                
                
                
            }else{
                print("Not working")
            }
        }
        
//         AF.request(redditURL).responseJSON {
//            response in
//
//            print("Respuesta \(response)")
//             self.isLoaded = true
//
////                do {
////                    if case .success (let value) = response.result {
////                        let decoder = JSONDecoder()
////                        decoder.keyDecodingStrategy = .convertFromSnakeCase
////                        result = try decoder.decode(ResultsPosts.self,from:response.data!)
////                    }
////                }catch{
////                    print ("Error: \(error)")
////                }
//        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Espacio que deseas tener.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        //let customCell = Bundle.main.loadNibNamed("MyTableViewCell", owner: self, options: nil)?.first as! MyTableViewCell
       
        let customCell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell

        customCell.layer.borderColor = UIColor.orange.cgColor
        customCell.layer.borderWidth = 1
        customCell.layer.cornerRadius = 8
        customCell.layoutMargins = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        customCell.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        customCell.separatorInset = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                
        
        if (self.isLoaded){
            let totalRows = resultsReddit!.data.children.count
            let row:Int = indexPath.section + rowCounter > totalRows ?  indexPath.section : indexPath.section + rowCounter
            print("index row \(row)")
            
            customCell.configure(with: resultsReddit!.data.children[row].data.title, subreddit: resultsReddit!.data.children[row].data.subredditNamePrefixed, author: resultsReddit!.data.children[row].data.author, comments: resultsReddit!.data.children[row].data.numComments, date: TimeInterval(resultsReddit!.data.children[row].data.created), thumbnailURL: resultsReddit!.data.children[row].data.thumbnail)
            
           

        }
        return customCell
    }
    
    
    @IBAction func susCounter(sender:UIButton){
        rowCounter -= 6
        let alertController = UIAlertController(title: "\("alert_title"~)", message: "\("first_page"~)", preferredStyle: UIAlertController.Style.alert)
        
        
        alertController.addAction(UIAlertAction(title:"ok", style: UIAlertAction.Style.default, handler: nil))
        
        if rowCounter <= 0 {
            rowCounter = 0
            
            present(alertController,animated: true,completion: nil)
        }
        
        print("susCounter \(rowCounter)")
        table.setContentOffset(CGPoint.zero, animated: true)
        table.reloadData()
    }
    
    @IBAction func addCounter(sender:UIButton){
        let totalRows = resultsReddit!.data.children.count
        rowCounter += 6
        let alertController = UIAlertController(title: "\("alert_title"~)", message: "\("last_page"~)", preferredStyle: UIAlertController.Style.alert)
        
        
        alertController.addAction(UIAlertAction(title:"ok", style: UIAlertAction.Style.default, handler: nil))
        
        if rowCounter >= totalRows {
            rowCounter = totalRows-1
            
            present(alertController,animated: true,completion: nil)
        }
        print("addCounter \(rowCounter)")
        table.setContentOffset(CGPoint.zero, animated: true)
        table.reloadData()
    }
   
    @IBAction func showAlert(sender: UIButton){
        
        
        let buttonSender = sender
        
        let wordToRead = buttonSender.titleLabel?.text
        
        let alertController = UIAlertController(title: "Alerta titulo", message: wordToRead!, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title:"ok", style: UIAlertAction.Style.default, handler: nil))
        present(alertController,animated: true,completion: nil)
        
    }
    
    
    
    private func parseJSON() -> ResultsPosts?{
        var result: ResultsPosts?
        guard let path = Bundle.main.path(forResource: "all", ofType: "json") else {
            return result
        }
        let url = URL(fileURLWithPath: path)
        
        
//        await AF.request(redditURL).responseJSON {
//            response in
//            print("Respuesta \(response)")
//
////                do {
////                    if case .success (let value) = response.result {
////                        let decoder = JSONDecoder()
////                        decoder.keyDecodingStrategy = .convertFromSnakeCase
////                        result = try decoder.decode(ResultsPosts.self,from:response.data!)
////                    }
////                }catch{
////                    print ("Error: \(error)")
////                }
//        }
        
        do {
            
                
                
                
//                .response { response in
//                //debugPrint(response.response)
//                jsonData = response.response
//            }
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                
            result = try decoder.decode(ResultsPosts.self,from:jsonData)
            
            if let result = result {
                print(result)
            }else{
                print("Failed to parse")
            }
        }
        catch{
            print ("Error: \(error)")
        }
            
        //var jsonData:AnyObject
       
        return result
    }
}

extension UIColor {

    // Light Blue (95, 153, 207)
    static let redditLightBlue = UIColor(red: 95/255.0, green: 153/255.0, blue: 207/255.0, alpha: 1)
    
    //Lightest Blue (206, 227, 248)
    static let redditLightestBlue = UIColor(red: 206/255.0, green: 227/255.0, blue: 248/255.0, alpha: 1)
    
    // Blue (51, 102, 153)
    static let redditBlue = UIColor(red: 82/255.0, green: 150/255.0, blue: 221/255.0, alpha: 1)
    
    //Red (255, 69, 0)
    static let redditRed = UIColor(red: 255/255.0, green: 69/255.0, blue: 0/255.0, alpha: 1)

    //Orange (255, 87, 0)
    static let redditOrange = UIColor(red: 255/255.0, green: 87/255.0, blue: 0/255.0, alpha: 1)

    // Grey (215,215,215)
    static let redditGrey = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1)

}


extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

postfix operator ~
postfix func ~ (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}
