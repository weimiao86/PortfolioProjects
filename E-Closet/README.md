Project 1 Milestone 3

Wei Miao

Instructions:

- For testing, please use test account to login: (Email)test1@gmail.com  (password)123456

- Creating personal account is welcomed, but you will need to generate your own data.

Implemented features:

1. Firebase storage and Realtime Database uploading /retrieval /filter data.

2. Authentication: users need create their account to login and their data will be saved on the database with their userID. they can login from different devices to access and edit their data.

3. Users can add clothes image from local album or take picture with camera.

4. User can filter the data with UIPickerView, they can use a single tag or combine more tags together to get the images they want.

Defects found in testing:

- Images Editing and Deleting does not work properly. this is caused by incorrect node returned when querying with specific url value. need a little more time to fix.

- The App does not have the "remember me / keep signing in" feature. so users have to input account every time login. need a little more time to add :)

Reference:

https://firebase.google.com/docs/ios/setup

https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2

https://cocoapods.org/

http://sourcefreeze.com/ios-uipickerview-example-using-swift/

https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html

http://helpmecodeswift.com/image-manipulation/saving-loading-images
