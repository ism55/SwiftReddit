//
//  MyTableViewCell.swift
//  PopularPosts
//
//  Created by Ismael Bautista on 11/7/22.
//

import UIKit
import SDWebImage


class MyTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subredditLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    
    static let identifier = "MyTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    public func configure (with title:String, subreddit:String, author:String, comments:Int, date:TimeInterval, thumbnailURL: URL?, auxURL: URL?){
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
        if thumbnailURL!.absoluteString == "default" {
            thumbnailView.removeFromSuperview()
            // TO DO: Click Gesture
        }else if thumbnailURL!.absoluteString == "image"{
            thumbnailView.sd_setImage(with: auxURL)
        }else{
            thumbnailView.sd_setImage(with: thumbnailURL)
        }
        titleLabel.textColor = UIColor.black
        subredditLabel.adjustsFontSizeToFitWidth = false
        subredditLabel.lineBreakMode = .byTruncatingTail
        authorLabel.adjustsFontSizeToFitWidth = false
        authorLabel.lineBreakMode = .byTruncatingTail
        authorLabel.textColor = UIColor.redditLightBlue
        subredditLabel.textColor = UIColor.redditOrange
        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.redditGrey.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 8
        containerView.layoutMargins = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        containerView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    @objc func contactUrlTapped(_ sender: UIButton)
    {
        guard let url = URL(string: "https://stackoverflow.com") else { return }
        UIApplication.shared.open(url)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

}
