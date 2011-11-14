Factory.define :user do |user|
  user.name "Margaret Beldyk"
  user.robot "databot"
  user.level 1
  user.joules 0
  user.totalbattles 0
  user.totalvictories 0
  user.vegetables 0
  user.password "assword"
  user.password_confirmation "assword"
end

Factory.define :inventory_item do |item|
  item.content "wizardhat"
  item.association :user
end