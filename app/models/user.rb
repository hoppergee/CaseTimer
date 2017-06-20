class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :name, presence: true, length: {maximum: 25}

  has_many :identifies

  has_many :cases
  has_many :tasks
  has_many :grades
  has_many :task_groups
  has_many :task_templates_groups
  has_many :favors

  def self.from_github(access_token, signed_in_resource=nil)
    data = access_token["info"]
    identify = Identify.find_by(provider: access_token["provider"], uid: access_token["uid"])

    if identify
      return identify.user
    else
      user = User.find_by(:email => data["email"])

      if !user
        if data["name"].nil?
          name = data["nickname"]
        else
          name = data["name"]
        end

        user = User.create(
            name: name,
            email: data["email"],
            image: data["image"],
            password: Devise.friendly_token[0,20]
        )
      end

      identify = Identify.create(
        provider: access_token["provider"],
        uid: access_token["uid"],
        user: user
      )

      return user
    end
  end

  def is_super_admin?
    self.id == 1
  end

  def grades_of(case_id)
    Grade.where(user: self, case_id: case_id, finish:true).order("updated_at")
  end

  def round_of(case_id)
    grades = self.grades_of(case_id)
    round = grades.count
  end

  def fastest_time_of(case_id)
    grades = self.grades_of(case_id)
    times = grades.map { |g| g.round_time }
    if times.size != 0
      times.min
    else
      0
    end
  end

  def average_time_of(case_id)
    grades = self.grades_of(case_id)
    times = grades.map { |g| g.round_time }
    if times.size != 0
      time = times.sum / times.size
    else
      0
    end
  end

  def total_time_of(case_id)
    grades = self.grades_of(case_id)
    times = grades.map {|g| g.round_time}
    if times.size != 0
      times.sum
    else
      0
    end
  end


end
