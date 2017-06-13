# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(email: "admin@qq.com", password: "123456")
u.save

case_item = [{title: "Rails101", description: "Rails入门"},
			{title: "Job Listing", description: "招聘网站"},
			{title: "JDStore", description: "商店网站"},
			{title: "Ajax", description: "Ajax课程"},
			{title: "Rails百宝箱1", description: "白版型"},
			{title: "Rails百宝箱2", description: "百宝箱2酷酷"}]

jd_tasks = [{title: "第一步", description: "项目准备"},
			{title: "第二步", description: "Landingpage"},
			{title: "第三步", description: "后台搭建"}]

case_item.each do |item|
	c = Case.create(title: item[:title], description: item[:description])
	if c.title == "JDStore"
		jd_tasks.each do |task_item|
			Task.create(title: task_item[:title],
					description: task_item[:description],
					user_id: u.id,
					case_id: c.id
					)
		end
	end
end
