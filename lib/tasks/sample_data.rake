namespace :db do
	desc "Llena la base de datos con informacion aleatoria"
	task populate: :environment do
		create_admin_user
		make_categories
		make_brands
		make_lines
		make_products
	end
end

def create_admin_user
	admin = User.create!(name: "Eduard L.", 
		email: "autofrioimportaciones@hotmail.com",
		password: "foobar",
		password_confirmation: "foobar")
end

def make_categories
	Category.create!(name: "Compresores")
	Category.create!(name: "Condensadores")
	Category.create!(name: "Evaporadores")
	Category.create!(name: "Filtros")
	Category.create!(name: "Radiadores")
	Category.create!(name: "Valvulas")
	Category.create!(name: "A/A Originales")
	Category.create!(name: "Accesorios")
	Category.create!(name: "Aceites")
	Category.create!(name: "Blower's")
	Category.create!(name: "Electroventiladores")
	Category.create!(name: "Filtros de Cabina")
	Category.create!(name: "Herramientas")
	Category.create!(name: "Mangueras")
	Category.create!(name: "Motores")
	Category.create!(name: "Partes de Compresor")
	Category.create!(name: "Refrigerantes")
	Category.create!(name: "Switches")
	Category.create!(name: "Otros")
end

def make_brands
	Brand.create!(name: "Acura")
	Brand.create!(name: "Alfa Romeo")
	Brand.create!(name: "Aston Martin")
	Brand.create!(name: "Audi")
	Brand.create!(name: "Bentley")
	Brand.create!(name: "Bertone")
	Brand.create!(name: "Brilliance")
	Brand.create!(name: "BMW")
	Brand.create!(name: "Cadilac")
	Brand.create!(name: "Chevrolet")
	Brand.create!(name: "Citroen")
	Brand.create!(name: "GMC")
	Brand.create!(name: "Chrysler")
	Brand.create!(name: "Dodge")
	Brand.create!(name: "Ferrari")
	Brand.create!(name: "Fiat")
	Brand.create!(name: "Ford")
	Brand.create!(name: "Hyundai")
	Brand.create!(name: "Honda")
	Brand.create!(name: "Hummer")
	Brand.create!(name: "Infiniti")
	Brand.create!(name: "Jaguar")
	Brand.create!(name: "Jeep")
	Brand.create!(name: "Kia")
	Brand.create!(name: "Koenisseg")
	Brand.create!(name: "Lamborghini")
	Brand.create!(name: "Lancia")
	Brand.create!(name: "Land Rover")
	Brand.create!(name: "Lexus")
	Brand.create!(name: "Lincoln")
	Brand.create!(name: "Lotus")
	Brand.create!(name: "McLaren")
	Brand.create!(name: "Mahindra")
	Brand.create!(name: "Maserati")
	Brand.create!(name: "Maruti")
	Brand.create!(name: "Mazda")
	Brand.create!(name: "Mercedes Benz")
	Brand.create!(name: "Mercury")
	Brand.create!(name: "Mini")
	Brand.create!(name: "Mitsubishi")
	Brand.create!(name: "Nissan")
	Brand.create!(name: "Opel")
	Brand.create!(name: "Peugot")
	Brand.create!(name: "Pontiac")
	Brand.create!(name: "Porsche")
	Brand.create!(name: "Renault")
	Brand.create!(name: "Rinspeed")
	Brand.create!(name: "Rolls Royce")
	Brand.create!(name: "Ruso Baltique")
	Brand.create!(name: "Saab")
	Brand.create!(name: "Scion")
	Brand.create!(name: "Seat")
	Brand.create!(name: "Smart")
	Brand.create!(name: "Skoda")
	Brand.create!(name: "Subaru")
	Brand.create!(name: "Susuki")
	Brand.create!(name: "Tata")
	Brand.create!(name: "Toyota")
	Brand.create!(name: "Volskswagen")
	Brand.create!(name: "Volvo")
end

def make_lines
	70.times do
		brand = Brand.all.sample
		random_name = Faker::Name.last_name
		brand.lines.create!(name: random_name)
	end
end

def make_products
	270.times do
		product = Product.new
		product.category = Category.all.sample
		3.times do 
			product.lines << Line.all.sample
		end

		product.comments = Faker::Lorem.sentence(5)
		product.reference = Faker::Lorem.sentence(2)

		product.save
	end
end



