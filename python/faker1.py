from faker import Faker

fake = Faker()
print("Name:", fake.name())
print("Email:", fake.email())
print("Address:", fake.address())
print("Country:", fake.country())
print("URL:", fake.url())
