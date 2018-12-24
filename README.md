# Course Select [![Build Status](https://travis-ci.org/PENGZhaoqing/CourseSelect.svg?branch=master)](https://travis-ci.org/PENGZhaoqing/CourseSelect)

### 本机部署：
以下的部署步骤在Mac和Linux环境下均可执行：

* [ ] 如果不使用MiniTest进行代码覆盖率测试可以忽略这条。首先自行安装postsql数据库9.6版本以下的，如果大于9.6会导致MiniTest出错。
* [ ] ruby版本使用2.4.4   rails 版本使用4.2.8
接着执行以下代码：
```
$ git clone https://github.com/chengmonk/Courses.git
$ cd Courses
$ bundle install
$ rake db:migrate
$ rake db:seed
$ rails s 
```
* * *

### Heroku云部署
本项目已经在Heroku上进行了部署 ([演示Demo戳这里](https://csiie.herokuapp.com/ ))

tips：Heroku的注册和登录可能需要科学上网，请自备梯子。

1.将编好的程序托管在github上

2.创建Heroku账号以及Heroku app

3.`heroku login` 以后添加新`app：heroku creat [appname]`

4.heroku会自动将自己添加进git的remote仓库中，如果没有的话可以手动添加heroku分支：`heroku git:remote -a csiie`

5.运行`git push heroku master` 向heroku云端进行部署，稍等片刻。从各种环境都会自动进行部署。

6.运行`heroku open`，就可以从heroku域名去访问我们所创建的网站了。


* * *

### 目前功能：

* 多角色登陆（学生，老师，管理员）
* 学生动态选课，退课
* 老师动态增加，删除课程
* 老师对课程下的学生添加、修改成绩
* 权限控制：老师和学生只能看到自己相关课程信息

* * *

### 添加功能：
* 处理选课冲突
* 控制选课人数
* 设置/删除学位课
* 统计选课学分
* 根据选课结果显示课程表 
* 增加选课时间段的控制功能
* 系统公告
* 绑定用户邮箱（实现注册激活，忘记密码等）
* 采用国科大真实选课数据，共有1100+条课程记录。
* * *
### 总体测试结果截图
<img src="/lib/screenshot1.png" width="700"> 
* * *

### 截图

<img src="/lib/screenshot1.png" width="700">  

<img src="/lib/screenshot2.png" width="700">

<img src="/lib/screenshot3.png" width="700">   

<img src="/lib/screenshot4.png" width="700">

* * *

## 使用

1.学生登陆：

账号：`student1@test.com`

密码：`password`

2.老师登陆：

账号：`teacher1@test.com`

密码：`password`


3.管理员登陆：

账号：`admin@qq.com`

密码：`password`

账号中数字都可以替换成2,3...等等







