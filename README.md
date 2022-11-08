# VIPNewsApp

This project show breaking news from US. to users.
Users can select their favorite news and see that news on favorites page.
If user select a news, it will show the news details on details page.
There is auto-layout on this project. Therefore, news will be shown for every iphone with different size releted with screen size.
When user favorited a new, activityIntaroctor appeared for 0.5 second. Also there is a favorited news counter below.
Some news doesn't have a thumbnail or photo to show.
TableView is created with RxSwift, so it is reactive.
I added two heart to assets file for like and unlike.
I created a color for texts.
Also if users select a favorited news in favorited news page, they route to details page to see details of favorited news.


//It can be used scroll view to show bigger text. I didn't use that in this project, because content text is enought to show in a small label.



# API Reference


GET/ https://newsapi.org/v2/top-headlines?country=us&apiKey=a71736c911b149e9acf84fdd00a7e98d


    //You can send a request with this url to get large amount of content.
    //You need to put news title to "title" and put name to "name" part.
GET/ https://newsapi.org/v2/top-headlines?country=us&q="title"&source"name"&apiKey=a71736c911b149e9acf84fdd00a7e98d



## Third Pary Frameworks

• Alamofire
• SDWebImage
• RxCocoa
• Firebase

## Author

https://www.github.com/onuryah






