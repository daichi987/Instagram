//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Mika on 2019/07/06.
//  Copyright © 2019 daichi987. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    
    var commentUserNamesArray = [String]()
    var commentsArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        commentTableView.dataSource = self
        commentTableView.delegate = self
        commentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "commentTableCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        if postData.comments.isEmpty {
            commentUserNamesArray = []
            commentsArray = []
        } else {
            commentUserNamesArray = postData.comments["name"]!
            commentsArray = postData.comments["comment"]!
        }
    }
}

extension PostTableViewCell: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentUserNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentTableCell", for: indexPath)
        
        let commentUserName = commentUserNamesArray[indexPath.row]
        let comment = commentsArray[indexPath.row]
        cell.textLabel?.text = "\(commentUserName) : \(comment)"
                
        return cell
    }    
}

extension PostTableViewCell: UITableViewDelegate {
}
