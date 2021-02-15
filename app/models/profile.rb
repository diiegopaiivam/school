class Profile < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile_user
  # Aceitar atributos vindos de outra tabela
  accepts_nested_attributes_for :profile_user, reject_if: :all_blank

  after_create :set_statistic

  # Validações
  validates :first_name, presence: true, length: { minimum: 3 }, on: :update       
  validates :last_name, presence: true, length: { minimum: 3 }, on: :update
  # Exibir nome completo do usuário
  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  private 
    def set_statistic
      AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users])
    end
  
end
