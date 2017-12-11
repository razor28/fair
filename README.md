# Coding assignment
## Installation
* Download Key files from [HERE](https://drive.google.com/open?id=1_ja0PGHjJ6mccg_Q_39Ll7Q5RF-yMC_0) and put them into .../Fair/Configuration . This files are stored outside of version control for security reason
* Download Assets from [HERE](https://drive.google.com/open?id=1BaUcrDF4YfTYee-JEx-_srNxNuo7bhB0) and put them into ../Fair folder . Assets are not tracked in version control to keep repository small and avoid possible merging problems.
* So finall app structure should look like image below:

![Keys and assets](https://user-images.githubusercontent.com/537530/33810857-2fd7647c-ddbf-11e7-9471-1d9aaf9c47fc.jpg)
* Install [Carthage](https://github.com/Carthage/Carthage) for dependency manager. Then type `carthage update --platform iOS` in terminal from root folder of the project to download all dependencies. This operation might take several minutes
* Now you should be able to run a project
* In addition you may need to install [SwiftLint](https://github.com/realm/SwiftLint) - a tool to enforce Swift style and conventions
* Please pay attention to multiple schemes and targets. Unit test is available only for **FairDev** target
## Icons
* App icon([Speed car racing](https://www.vexels.com/vectors/preview/139460/speed-car-racing)) designed by Vexels. 
* Tab icons provided by [Iconbeast](http://www.iconbeast.com)
* Please respect copyright
## Notes
* The main application architecture pattern is based on [Coordinators](http://khanlou.com/2015/10/coordinators-redux/)
## Screenshots
### Makes
![Makes](https://user-images.githubusercontent.com/537530/33810834-f2555640-ddbe-11e7-9f0c-0315a5866914.png)
### Details
![Details](https://user-images.githubusercontent.com/537530/33807609-5ec6f95e-dd8e-11e7-831c-29d4912eb510.png)
### Loading
![Loading](https://user-images.githubusercontent.com/537530/33810833-f239e6ee-ddbe-11e7-992d-25bfd427bb3c.png)
### Model
![Model](https://user-images.githubusercontent.com/537530/33810835-f26d1776-ddbe-11e7-8012-d9eeb54ce557.png)
### Year
![Year](https://user-images.githubusercontent.com/537530/33810836-f298ce98-ddbe-11e7-8a13-e2f4977ed6f2.png)
