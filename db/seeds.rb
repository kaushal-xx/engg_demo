# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if User.find_by_email('admin@engineer.ai').blank?
	secret_code =  SecretCode.get_unuse_code
	if secret_code.blank?
		secret_code = SecretCode.create
	end
	user = User.create({ first_name: 'Admin', last_name: '', email: 'admin@engineer.ai', password: 'password', password_confirmation: 'password', secret_code_id: secret_code.id, temp_secret_number: secret_code.code})
	user.add_role(:admin) 
end
