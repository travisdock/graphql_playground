class Club < ApplicationRecord
  has_and_belongs_to_many :members
  belongs_to :founder,
             :class_name => 'Member',
             :foreign_key => 'member_id'
end
