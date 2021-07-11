# The Ultimate Test Mobile Application

## Description
- This application was inspired by a famous professional climber Magnus Midtbø, where he tried the ultimate climber test. This application incorporated the idea and included some extra challenges as well.

## Purpose of Application
- This application aims to not only improve my understanding for application development, but also encourages people to set and maintain fitness goals in the long run.

## Learning Points
* Mobile application development
* Firebase firestore data storing and reading
* Widget lifecycles
* Animation and ticks
* UI / UX designs
* Google Sign in

### Splash Feature
> https://user-images.githubusercontent.com/54731174/125184483-d42e5780-e250-11eb-8f3f-7ed70edf2a6b.mp4
>> A ticker was used to animate the bouncing animation image and changes to another image after some time. This is just an example that I used to capture attention.

### Google Sign-in > Profile Features
> https://user-images.githubusercontent.com/54731174/125184488-e27c7380-e250-11eb-9747-5502ad677dd8.mp4
>> Google Sign-in page allows sign in via only google account and user will be brought to the profile page. Auto login feature is also implemented so if user did not log out, he would not need to sign in again after he restart the application.
>> The Profile page displays some of user's google account information such as display picture and the email user used to sign in. Sign out feature is included here as well.

### Test Feature
> https://user-images.githubusercontent.com/54731174/125184632-068c8480-e252-11eb-8cd3-82e334cca418.mp4
>> Test tab first brings user choose a test user wants to take. Then, upon starting the test, user will need to carry out the test. Only the Ultimate Climber Test is available and there are 4 parts to it. After filling in the results, an overall results page will be generated for the user which shows the user what is the maximum potential climbing grade user is actually able to accomplish. Then, user can choose to redo the test or save the test.

### Achievements Page & Firestore
> https://user-images.githubusercontent.com/54731174/125184740-ea3d1780-e252-11eb-8859-51158a890bc8.mp4
>> User is able to see their past test results sorted by date.

### Settings Feature
> https://user-images.githubusercontent.com/54731174/125184816-6fc0c780-e253-11eb-86e6-305fd4875eee.mp4
>> User is able to configure their personal details and even set test dates that comes with
 reminders.

### Workout Recommendations Feature
> https://user-images.githubusercontent.com/54731174/125184909-15743680-e254-11eb-99d5-fbf293a3b432.mp4
>> User is able to check out this page for workout challenges or workout lifestyles or workout progressions. This is to let user achieve their intended results in the tests at a faster and a more consistent manner.

### About Us Feature
> https://user-images.githubusercontent.com/54731174/125184959-700d9280-e254-11eb-90d9-c65b317fcb1c.mp4
>> Presents behind the scenes information about the application, and gives user a way to contact in case there are any queries.

## Tech Stack
* Flutter SDK (with null-safety)
    - firebase_core: ^1.3.0
    - firebase_auth: ^1.4.1
    - google_sign_in: ^5.0.4
    - flutter_svg: ^0.22.0
    - cloud_firestore: ^2.2.2
    - intro_slider: ^3.0.1
    - syncfusion_flutter_gauges: ^19.1.69
    - intl: ^0.17.0
    - url_launcher: ^6.0.8
    - flutter_switch: ^0.3.2
* Dart SDK: ">=2.12.0 <3.0.0"
* Flutter Fire (google firebase firestore)
* Google Authentication (google sign-in)
