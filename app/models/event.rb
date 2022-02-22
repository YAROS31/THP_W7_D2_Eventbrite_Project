class Event < ApplicationRecord
  has_many :attendances #, foreign_key: 'organized_event_id' #si erreur supprimer cette FK
  has_many :participants, class_name: "User", through: :attendances
  belongs_to :admin, class_name: "User"

  #Validates en v5.2.6 : https://guides.rubyonrails.org/v5.2.6/active_record_validations.html#confirmation

  # Une start_date, qui est un datetime.
  # Validations : sa présence est obligatoire, et il est impossible de créer ou modifier un événement dans le passé.
  validates :start_date, presence: true
  def cant_be_in_the_past 
    if start_date < Time.now #https://stackoverflow.com/questions/27210793/rails-getting-datetime-select-into-user-timezone-for-model-validation
    errors.add(:start_date, "can't be in the past")
    end
  end
  validate :cant_be_in_the_past #attention c'est validate sans "s" car il s'agit d'une méthode


  # Une duration, qui est un integer représentant le nombre de minutes que cet événement va durer.
  # Validations : Sa présence est obligatoire et le nombre de minutes doit être un multiple de 5, et est strictement positif
  validates :duration, presence: true
  
  def be_multiple_of_5 
    unless duration > 0 && duration % 5 == 0 #https://stackoverflow.com/questions/51274453/ruby-round-integer-to-nearest-multiple-of-5/51292434
    errors.add(:duration, "must be multiple of 5")
    end
  end
  validate :be_multiple_of_5 #attention c'est validate sans "s" car il s'agit d'une méthode

  # Un title qui est un string.
  # Validations : Sa présence est obligatoire et doit faire au moins 5 caractères et maxi 140 caractères.
  validates :title, presence: true, length: { in: 5..140 }

  # Une description qui est un text.
  # Validations : Sa présence est obligatoire et la description doit faire entre 20 et 1000 caractères.
  validates :description, presence: true, length: { in: 20..1000 }
  
  # Un price qui est un integer. Ce price correspond au nombre d'euros que coûte l'événement.
  # Validations : Sa présence est obligatoire et cet integer doit être compris entre 1 et 1000. (pas d'événement gratuit pour cette première version de l'application)
  validates :price, presence: true, length: { in: 1..1000 }
  
  # Une location, qui est un string.
  # Validations : Sa présence est obligatoire
  validates :location, presence:true
end
