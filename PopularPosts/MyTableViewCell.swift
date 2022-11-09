//
//  MyTableViewCell.swift
//  PopularPosts
//
//  Created by Ismael Bautista on 11/7/22.
//

import UIKit
import SDWebImage


class MyTableViewCell: UITableViewCell {
    
    static let identifier = "MyTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    
    
    public func configure (with title:String, subreddit:String, author:String, comments:Int, date:TimeInterval, thumbnailURL: URL?){
        let parseDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = dateFormatter.string(from: parseDate)
        
        
        
        titleLabel.text = title
        authorLabel.text = "\("posted_by"~)" + " u/" + author
        subredditLabel.text = subreddit
        commentsLabel.text = "💬" + comments.roundedWithAbbreviations + " " + "\("comments_str"~)"
        dateLabel.text = strDate
        if thumbnailURL!.absoluteString != "default" {
            thumbnailView.sd_setImage(with: thumbnailURL)
        }else{
            thumbnailView.removeFromSuperview()
        }
        
        titleLabel.textColor = UIColor.black
        subredditLabel.adjustsFontSizeToFitWidth = false
        subredditLabel.lineBreakMode = .byTruncatingTail
        authorLabel.adjustsFontSizeToFitWidth = false
        authorLabel.lineBreakMode = .byTruncatingTail
        
        self.contentView.layer.cornerRadius = 8
        
        
    }
    
    //@IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subredditLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!
    
   

    override func awakeFromNib() {
        super.awakeFromNib()
        //thumbnailView.contentMode = .scaleAspectFit
        // Initialization code
      
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        print("Seleccionada")
//        // Configure the view for the selected state
//    }
    

}
