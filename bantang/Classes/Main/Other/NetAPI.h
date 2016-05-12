
//
//  NetAPI.h
//  bantang
//
//  Created by MS on 15-12-28.
//  Copyright (c) 2015年 ms. All rights reserved.
//


//首页-最新
#define latest_url @"http://open3.bantangapp.com/recommend/index?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20"

//首页通用接口
#define topic_url  @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=%@&v=9"
//主页
#define product_list_url @"http://open.ibantang.com/product/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&v=10&ids="

//首页 topicList
#define topic_list_url @"http://open.ibantang.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&v=10&page=%d&pagesize=10&ids="






//——————>大家都在买<第四期 >
#define homePage_url @"http://open3.bantangapp.com/topic/newInfo?app_installtime=1451058556.841214&app_versions=5.1.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=1782&os_versions=9.1&screensize=750&statistics_uv=1&track_device_info=iPhone8%2C1&track_deviceid=C40EAB7F-235F-40B3-B1CB-C3A2DA50B0EC&v=9"


//——————>ScollerView电器都是生活的智慧
#define pic_url @"http://open3.bantangapp.com/topic/list?app_installtime=1451058556.841214&app_versions=5.1.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&ids=1705%2C1663%2C1613%2C1523%2C1229&os_versions=9.1&page=%d&pagesize=20&screensize=750&track_device_info=iPhone8%2C1&track_deviceid=C40EAB7F-235F-40B3-B1CB-C3A2DA50B0EC&v=9"


//——————>一周之星
#define star_url @"http://open3.bantangapp.com/community/subject/info?&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&subject_id=140&v=9"

//——————>一周之星

//首页-文艺  scene=8
#define literature_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=8&v=9"

//首页-礼物  scene=3
#define gifts_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=3&v=9"


//首页-指南  scene=10
#define guide_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=10&v=9"


//首页-爱美 scene=13
#define dressing_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=13&v=9"

//首页-设计  scene=16
#define design_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=16&v=9"


//首页-吃货  scene=15
#define eat_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=15&v=9"


//首页-格调 scene=17
#define style_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=17&v=9"

//首页-厨房  scene=1
#define kitchen_url  @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=1&v=9"

//首页-上班族  scene=6
#define working_url  @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=6&v=9"

//首页-学生党 scene=5
#define students_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=5&v=9"


//首页-聚会  scene=14
#define party_url  @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=14&v=9"

//首页-节日  scene=9
#define holiday_url  @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=9&v=9"


//首页-宿舍  scene=4
#define studentHome_url @"http://open3.bantangapp.com/topic/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=20&scene=4&v=9"


//第二页-精选
#define carefully_url @"http://open3.bantangapp.com/community/post/editorRec?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&page=%d&pagesize=10&v=9"



//广场-跳转  拼接id
#define jump_url @"http://open3.bantangapp.com/community/group/info?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&group_id=%@&type_id=1&v=10"
//广场
#define plaza_url @"http://open3.bantangapp.com/community/post/communityHome?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=dc5c0444792372e32117eec4feab4abb&v=10"

//消息
#define news_url @"http://open3.bantangapp.com/users/notice/redSpot?app_installtime=1451058556.841214&app_versions=5.1.1&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=dc5c0444792372e32117eec4feab4abb&os_versions=9.1&screensize=750&track_device_info=iPhone8%2C1&track_deviceid=C40EAB7F-235F-40B3-B1CB-C3A2DA50B0EC&track_user_id=1725993&type=1&v=9"

//社区 -广场-点击  拼接extend
#define plaza_btn_url @"http://open3.bantangapp.com/community/subject/listPost?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=5a75c80bc822035b0c0bc02fdf5535b6&subject_id=%@&track_user_id=1725993&type_id=0&v=10"
//详情   ID不一样

#define detail_url @"http://open3.bantangapp.com/topic/newInfo?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&id=%@&v=10"

//用户推荐
#define recommend_url @"http://open3.bantangapp.com/community/post/listByTags?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&pagesize=10&tag_ids=1666%%2C3351%%2C5189&topic_id=%@&type_id=1&v=10"

//用户喜欢列表
#define productNewInfo_url @"http://open3.bantangapp.com/product/newInfo?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&comments_pagesize=10&id=%@&v=10"

//推荐物品详情
#define relation_url  @"http://open3.bantangapp.com/product/relation?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&object_id=%@&type_id=2&v=10"

//搜索详单  拼接
#define searchDetail_url @"http://open3.bantangapp.com/product/productList?app_installtime=1451058556.841214&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=5a75c80bc822035b0c0bc02fdf5535b6&subclass=%d&track_user_id=1725993&v=10"


//单品
#define search_url @"http://open3.bantangapp.com/category/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&is_new=1&oauth_token=5a75c80bc822035b0c0bc02fdf5535b6&track_user_id=1725993&v=10"


//清单
#define list_url @"http://open3.bantangapp.com/category/scene?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&v=10"

//搜索 单品
#define search_list_url @"http://open3.bantangapp.com/base/search/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&keyword=%@&type_id=2&v=10"
//搜索 清单
#define search_scene_url @"http://open3.bantangapp.com/base/search/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&keyword=%@&type_id=1&v=10"
//搜索 帖子
#define search_tiezi_url @"http://open3.bantangapp.com/base/search/list?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&keyword=%@&type_id=4&v=10"

//搜索 用户
#define search_user_url @"http://open.ibantang.com/base/search/user?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&v=10&keyword=%@&page=0&pagesize=20"



//热搜
#define hottags_url @"http://open3.bantangapp.com/base/search/hottags?app_installtime=1451058556.841214&app_versions=5.3&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=5a75c80bc822035b0c0bc02fdf5535b6&os_versions=9.2&screensize=750&track_device_info=iPhone8%2C1&track_deviceid=C40EAB7F-235F-40B3-B1CB-C3A2DA50B0EC&track_user_id=1725993&v=10"

//宜家
#define plaza_yijia_url @"http://open3.bantangapp.com/community/post/listByTag?client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&oauth_token=5a75c80bc822035b0c0bc02fdf5535b6&tag_id=%@&track_deviceid=C40EAB7F-235F-40B3-B1CB-C3A2DA50B0EC&track_user_id=1725993&type_id=1&v=10"