import random
import string
import csv

def generate_register_data(num_users):
    with open(f'data_{num_users}.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['First Name', 'Last Name', 'Email', 'Password', 'Confirm Password', 'Company', 'Street Address', 'City', 'State', 'Zip Code', 'Phone'])

        for i in range(num_users):
            first_name = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=8))
            last_name = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=8))
            email = f'{first_name}.{last_name}@example.com'
            password = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase + string.digits, k=10))
            confirm_password = password
            company = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=8))
            street_address = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=10))
            city = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=8))
            state = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=6))
            zip_code = ''.join(random.choices(string.digits, k=5))
            phone = ''.join(random.choices(string.digits, k=10))

            data = [first_name, last_name, email, password, confirm_password, company, street_address, city, state, zip_code, phone]
            writer.writerow(data)

    return f'{num_users} users generated and saved to data_{num_users}.csv'
