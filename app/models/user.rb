class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :attendances, foreign_key: 'participant_id'
  has_many :events, through: :attendances
  has_many :organized_events, foreign_key: 'admin_id', class_name: "Event"


  #Active Mailer
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
