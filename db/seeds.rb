# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


u = User.create(name: "超级管理员" ,email: "admin@qq.com", password: "123456")
u.save

case_item = [{title: "Rails101", tasks: [
									{title: "开始吧"},
									{title: "建立一个讨论群"},
									{title: "实作讨论群CRUD"},
									{title: "加入使用者功能"},
									{title: "在讨论群里发布文章"},
									{title: "使用者加入社团"},
									{title: "在后台查看加入社团和发表的文章"},
									{title: "修饰细节，helper，partial"},
									{title: "上传到github和heroku"}
									]
			},
			{title: "JobListing", tasks: [
									{title: "穿衣服"},
									{title: "6-1"},
									{title: "6-2"},
									{title: "6-3"},
									{title: "6-4"},
									{title: "8-2"},
									{title: "10-2"},
									{title: "10-3"},
									{title: "10-4"},
									{title: "11-1"},
									{title: "11-2"},
									{title: "12-2"}
									]
			},
			{title: "JDStore", tasks: [
									{title: "4-1 基础建设"},
									{title: "4-2 上架后台CRUD"},
									{title: "4-3 admin可以登录后台"},
									{title: "4-4 上传图片"},
									{title: "5-2 建立加入购物车的action"},
									{title: "5-3 购物车设计 Part 1"},
									{title: "5-4 购物车设计 Part 2"},
									{title: "5-5 显示购物车明细"},
									{title: "5-6 计算总价"},
									{title: "6-1 购物车练习作业"},
									{title: "8-1 建立结账页"},
									{title: "8-2 建立购买明细"},
									{title: "8-3 将网址改为秘密"},
									{title: "9-1 订单练习作业"},
									{title: "10-1 消费者可以针对订单付款"},
									{title: "10-2 即送订单确认通知信"},
									{title: "11-1 情境和Model准备"},
									{title: "11-2 订单状态切换"},
									{title: "使用云来存储图片"},
									{title: "用Figaro管理密码"},
									{title: "部署到Heroku"}
									]
			},
			{title: "Ajax", tasks: [
									{title: "jQuery 101"},
									{title: "Ajax on Rails"},
									{title: "Ajax on Rails(进阶)"},
									]
			},
			{title: "Rails百宝箱1", tasks: [
									{title: "自定义Model网址"},
									{title: "多语言设置"},
									{title: "时区设置"},
									{title: "格式化日期时间"},
									{title: "表单单选UI"},
									{title: "表单单选 UI 和 Select2 Plugin"},
									{title: " 表单多选 UI 和 Select2 Plugin"},
									{title: "嵌套表单(1-to-1)"},
									{title: "嵌套表单(1-to-many)"}
									]
			},
			{title: "Rails百宝箱2", tasks: [
									{title: "选日期时间的 UI"},
									{title: "拆开前后台的 CSS 和 JS"},
									{title: "Rich Editor 编辑器"},
									{title: "批次编辑 (Bulk Editing)"}
									]
			},
			{title: "Rails百宝箱3", tasks: [
									{title: "自订列表顺序"},
									{title: "多步骤表单"},
									{title: "显示资料验证错误讯息"},
									{title: "资料筛选和搜寻"},
									{title: "多档案上传"},
									{title: "图表资料分析"}
									]
			},
			{title: "Web API 设计", tasks: [
									{title: "抓取第三方资料"},
									{title: "串接第三方 API 服务"},
									{title: "建立 API 服务器"},
									{title: "实作认证 API"},
									{title: "实作注册、登入、登出 API"},
									{title: "实作用户更新资料 API"},
									{title: "Jbuilder 用法"},
									]
			}
]

case_item.each_with_index do |item, index|
	c = Case.create(title: item[:title], user_id: u.id)
	ttg = TaskTemplatesGroup.create(user_id: u.id, case_id: c.id)
	puts("#{index} - 建立Case#{c.title}与Group#{ttg.id}")
	item[:tasks].each_with_index do |task_item, item_index|
		t = TaskTemplate.create(title: task_item[:title], task_templates_group_id: ttg.id)
		puts("#{index}-#{item_index} - 建立Template#{t.title}")
	end
end
