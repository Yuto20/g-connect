class Platform < ActiveHash::Base
  self.data = [
    { id: 1,  name: '--' },
    { id: 2,  name: 'PlayStation4/5' },
    { id: 3,  name: 'Nintendo Switch' },
    { id: 4,  name: 'PC' }
  ]

  include ActiveHash::Associations
  has_many :users
end