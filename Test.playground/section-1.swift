// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//var image = UIImage(named:"shake.png")

let imageView = UIImageView(image: UIImage(named:"shake"))
imageView.frame = CGRectMake(0,0,100,100)

let view = UIView()
view.frame = CGRectMake(0, 0, 200, 200)
view.backgroundColor = UIColor.blackColor()
view.addSubview(imageView)



