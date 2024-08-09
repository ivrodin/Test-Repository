import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta
from faker import Faker

fake = Faker()

# Define the date range for the last two years
end_date = datetime.now()
start_date = end_date - timedelta(days=2 * 365)

# Generate random dates within the last two years
def random_dates(start, end, n):
    start_u = start.timestamp()
    end_u = end.timestamp()
    return [datetime.fromtimestamp(random.uniform(start_u, end_u)) for _ in range(n)]

emp_dict = {
    'EMP0001': 'JOHN DOE',
    'EMP0002': 'JANE SMITH',
    'EMP0003': 'ROBERT JOHNSON',
    'EMP0004': 'EMILY WILLIAMS',
    'EMP0005': 'MICHAEL BROWN',
    'EMP0006': 'SARAH MILLER',
    'EMP0007': 'WILLIAM WILSON',
    'EMP0008': 'LINDA MOORE',
    'EMP0009': 'DAVID TAYLOR',
    'EMP0010': 'OLIVIA ANDERSON'
}

cust_dict = {
    'CUST0001': 'JAMES SMITH',
    'CUST0002': 'JOHN JOHNSON',
    'CUST0003': 'ROBERT WILLIAMS',
    'CUST0004': 'MICHAEL JONES',
    'CUST0005': 'WILLIAM BROWN',
    'CUST0006': 'DAVID DAVIS',
    'CUST0007': 'RICHARD MILLER',
    'CUST0008': 'CHARLES WILSON',
    'CUST0009': 'JOSEPH MOORE',
    'CUST0010': 'THOMAS TAYLOR',
    'CUST0011': 'CHRISTOPHER ANDERSON',
    'CUST0012': 'DANIEL THOMAS',
    'CUST0013': 'PAUL JACKSON',
    'CUST0014': 'MARK WHITE',
    'CUST0015': 'DONALD HARRIS',
    'CUST0016': 'GEORGE MARTIN',
    'CUST0017': 'KENNETH THOMPSON',
    'CUST0018': 'STEVEN GARCIA',
    'CUST0019': 'EDWARD MARTINEZ',
    'CUST0020': 'BRIAN ROBINSON',
    'CUST0021': 'RONALD CLARK',
    'CUST0022': 'ANTHONY RODRIGUEZ',
    'CUST0023': 'KEVIN LEWIS',
    'CUST0024': 'JASON LEE',
    'CUST0025': 'MATTHEW WALKER',
    'CUST0026': 'GARY HALL',
    'CUST0027': 'TIMOTHY ALLEN',
    'CUST0028': 'JOSE YOUNG',
    'CUST0029': 'LARRY HERNANDEZ',
    'CUST0030': 'JEFFREY KING',
    'CUST0031': 'FRANK WRIGHT',
    'CUST0032': 'SCOTT LOPEZ',
    'CUST0033': 'ERIC HILL',
    'CUST0034': 'STEPHEN SCOTT',
    'CUST0035': 'ANDREW GREEN',
    'CUST0036': 'RAYMOND ADAMS',
    'CUST0037': 'GREGORY BAKER',
    'CUST0038': 'JOSHUA GONZALEZ',
    'CUST0039': 'JERRY NELSON',
    'CUST0040': 'DENNIS CARTER',
    'CUST0041': 'WALTER MITCHELL',
    'CUST0042': 'PATRICK PEREZ',
    'CUST0043': 'PETER ROBERTS',
    'CUST0044': 'HAROLD TURNER',
    'CUST0045': 'DOUGLAS PHILLIPS',
    'CUST0046': 'HENRY CAMPBELL',
    'CUST0047': 'CARL PARKER',
    'CUST0048': 'ARTHUR EVANS',
    'CUST0049': 'RYAN EDWARDS',
    'CUST0050': 'ROGER COLLINS',
    'CUST0051': 'JOE STEWART',
    'CUST0052': 'JUAN SANCHEZ',
    'CUST0053': 'JACK MORRIS',
    'CUST0054': 'ALBERT ROGERS',
    'CUST0055': 'JONATHAN REED',
    'CUST0056': 'JUSTIN COOK',
    'CUST0057': 'TERRY MORGAN',
    'CUST0058': 'GERALD BELL',
    'CUST0059': 'KEITH MURPHY',
    'CUST0060': 'SAMUEL BAILEY',
    'CUST0061': 'WILLIE RIVERA',
    'CUST0062': 'RALPH COOPER',
    'CUST0063': 'LAWRENCE RICHARDSON',
    'CUST0064': 'NICHOLAS COX',
    'CUST0065': 'ROY HOWARD',
    'CUST0066': 'BENJAMIN WARD',
    'CUST0067': 'BRUCE TORRES',
    'CUST0068': 'BRANDON PETERSON',
    'CUST0069': 'ADAM GRAY',
    'CUST0070': 'HARRY RAMIREZ',
    'CUST0071': 'FRED COLLINS',
    'CUST0072': 'WAYNE BELL',
    'CUST0073': 'BILLY GOMEZ',
    'CUST0074': 'STEVE KELLY',
    'CUST0075': 'LOUIS HOWELL',
    'CUST0076': 'JEREMY WOOD',
    'CUST0077': 'AARON WASHINGTON',
    'CUST0078': 'RANDY LONG',
    'CUST0079': 'HOWARD FOSTER',
    'CUST0080': 'EUGENE SANDERS',
    'CUST0081': 'CARLOS PRICE',
    'CUST0082': 'RUSSELL WOODS',
    'CUST0083': 'BOBBY POWELL',
    'CUST0084': 'VICTOR BARNES',
    'CUST0085': 'MARTIN HENDERSON',
    'CUST0086': 'ERNEST COLEMAN',
    'CUST0087': 'PHILLIP SIMMONS',
    'CUST0088': 'TODD SIMPSON',
    'CUST0089': 'JESSE REYNOLDS',
    'CUST0090': 'CRAIG CUNNINGHAM',
    'CUST0091': 'ALAN BRADLEY',
    'CUST0092': 'SHAWN LANE',
    'CUST0093': 'CLARENCE ANDREWS',
    'CUST0094': 'SEAN RUIZ',
    'CUST0095': 'PHILIP HARPER',
    'CUST0096': 'CHRIS FOX',
    'CUST0097': 'JOHNNY RILEY',
    'CUST0098': 'EARL ARMSTRONG',
    'CUST0099': 'JIMMY CARPENTER',
    'CUST0100': 'ANTONIO WEAVER',
    'CUST0101': 'DANNY GREENE',
    'CUST0102': 'BRYAN LAWRENCE',
    'CUST0103': 'TONY ELLIOTT',
    'CUST0104': 'LUIS CHAVEZ',
    'CUST0105': 'MIKE SIMONS',
    'CUST0106': 'STANLEY BURKE',
    'CUST0107': 'LEONARD RICHARDS',
    'CUST0108': 'NATHAN WATSON',
    'CUST0109': 'DALE FIELDS',
    'CUST0110': 'MANUEL WATTS',
    'CUST0111': 'RODNEY HENRY',
    'CUST0112': 'CURTIS TUCKER',
    'CUST0113': 'NORMAN MENDOZA',
    'CUST0114': 'ALLEN DIXON',
    'CUST0115': 'MARVIN RUIZ',
    'CUST0116': 'VINCENT ARMSTRONG',
    'CUST0117': 'GLENN PETERSON',
    'CUST0118': 'JEFFERY EVANS',
    'CUST0119': 'TRAVIS GORDON',
    'CUST0120': 'JEFF BREWER',
    'CUST0121': 'CHAD RUIZ',
    'CUST0122': 'JACOB NICHOLS',
    'CUST0123': 'LEE HERRERA',
    'CUST0124': 'MELVIN MEDINA',
    'CUST0125': 'ALFRED FOWLER',
    'CUST0126': 'KYLE BRENNAN',
    'CUST0127': 'FRANCIS CALDWELL',
    'CUST0128': 'BRADLEY DAY',
    'CUST0129': 'JESUS LUCAS',
    'CUST0130': 'HERBERT BECK',
    'CUST0131': 'FREDERICK GILBERT',
    'CUST0132': 'RAY AUSTIN',
    'CUST0133': 'JOEL GIBSON',
    'CUST0134': 'EDWIN GARDNER',
    'CUST0135': 'DON HARVEY',
    'CUST0136': 'EDDIE CARROLL',
    'CUST0137': 'RICKY PERKINS',
    'CUST0138': 'TROY WILLIAMSON',
    'CUST0139': 'RANDALL JOHNSTON',
    'CUST0140': 'BARRY MARSHALL',
    'CUST0141': 'ALEXANDER OLIVER',
    'CUST0142': 'BERNARD BISHOP',
    'CUST0143': 'MARIO GRANT',
    'CUST0144': 'LEROY WEBSTER',
    'CUST0145': 'FRANCISCO KENNEDY',
    'CUST0146': 'MARCUS BISHOP',
    'CUST0147': 'THEODORE SINGH',
    'CUST0148': 'CLIFFORD BECKER',
    'CUST0149': 'MIGUEL CURTIS',
    'CUST0150': 'OSCAR MORALES',
    'CUST0151': 'JAY MARSH',
    'CUST0152': 'JIM WATKINS',
    'CUST0153': 'TOMMY POPE',
    'CUST0154': 'LEON HOPKINS',
    'CUST0155': 'DEREK FOWLER',
    'CUST0156': 'WARREN SOTO',
    'CUST0157': 'DARRELL BUCKLEY',
    'CUST0158': 'JEROME SERRANO',
    'CUST0159': 'FLOYD REESE',
    'CUST0160': 'LEO WALTER',
    'CUST0161': 'ALVIN BATES',
    'CUST0162': 'TIM KELLER',
    'CUST0163': 'WESLEY LEONARD',
    'CUST0164': 'GORDON CHURCH',
    'CUST0165': 'DEAN HORTON',
    'CUST0166': 'GREG WALSH',
    'CUST0167': 'JORGE LYONS',
    'CUST0168': 'DUSTIN RAMSEY',
    'CUST0169': 'PEDRO WOLFE',
    'CUST0170': 'DERRICK SCHNEIDER',
    'CUST0171': 'DAN WAGNER',
    'CUST0172': 'LEWIS HARRINGTON',
    'CUST0173': 'ZACHARY DANIELS',
    'CUST0174': 'COREY SIMPSON',
    'CUST0175': 'HERMAN ARMSTRONG',
    'CUST0176': 'MAURICE RICHARD',
    'CUST0177': 'VERNON CARR',
    'CUST0178': 'ROBERTO MARTIN',
    'CUST0179': 'CLYDE SOTO',
    'CUST0180': 'GLEN BOWEN',
    'CUST0181': 'HECTOR VAUGHN',
    'CUST0182': 'SHANE FREEMAN',
    'CUST0183': 'RICARDO PRICE',
    'CUST0184': 'SAMMY MCKINNEY',
    'CUST0185': 'RICK MORSE',
    'CUST0186': 'LESTER MCDANIEL',
    'CUST0187': 'BRENT SANCHEZ',
    'CUST0188': 'RAMON POLK',
    'CUST0189': 'CHARLIE SMALL',
    'CUST0190': 'TYLER SALINAS',
    'CUST0191': 'GILBERT RICHMOND',
    'CUST0192': 'GENE STUART',
    'CUST0193': 'MARCOS CRANE',
    'CUST0194': 'LUIS LAMBERT',
    'CUST0195': 'DARRIN PEARSON',
    'CUST0196': 'NEIL HOOK',
    'CUST0197': 'DWAYNE SHARP',
    'CUST0198': 'VICTOR GOULD',
    'CUST0199': 'WADE YATES',
    'CUST0200': 'STUART GRIMES'
}

pizza_type_name_size_price = [
    {'type': 'classic', 'name': 'pepperoni', 'size': 'S', 'price': 8.59},
    {'type': 'classic', 'name': 'pepperoni', 'size': 'M', 'price': 10.39},
    {'type': 'classic', 'name': 'pepperoni', 'size': 'L', 'price': 12.29},
    {'type': 'classic', 'name': 'pepperoni', 'size': 'XL', 'price': 15.69},
    {'type': 'classic', 'name': 'pepperoni', 'size': 'XXL', 'price': 18.49},
    {'type': 'classic', 'name': 'ham and mushrooms', 'size': 'S', 'price': 9.99},
    {'type': 'classic', 'name': 'ham and mushrooms', 'size': 'M', 'price': 11.89},
    {'type': 'classic', 'name': 'ham and mushrooms', 'size': 'L', 'price': 13.79},
    {'type': 'classic', 'name': 'ham and mushrooms', 'size': 'XL', 'price': 16.29},
    {'type': 'classic', 'name': 'ham and mushrooms', 'size': 'XXL', 'price': 19.99},
    {'type': 'classic', 'name': 'teriyaki', 'size': 'S', 'price': 10.69},
    {'type': 'classic', 'name': 'teriyaki', 'size': 'M', 'price': 12.59},
    {'type': 'classic', 'name': 'teriyaki', 'size': 'L', 'price': 14.49},
    {'type': 'classic', 'name': 'teriyaki', 'size': 'XL', 'price': 17.89},
    {'type': 'classic', 'name': 'teriyaki', 'size': 'XXL', 'price': 20.69},
    {'type': 'classic', 'name': 'salami', 'size': 'S', 'price': 8.29},
    {'type': 'classic', 'name': 'salami', 'size': 'M', 'price': 10.19},
    {'type': 'classic', 'name': 'salami', 'size': 'L', 'price': 12.09},
    {'type': 'classic', 'name': 'salami', 'size': 'XL', 'price': 15.49},
    {'type': 'classic', 'name': 'salami', 'size': 'XXL', 'price': 18.29},
    {'type': 'classic', 'name': 'rancho', 'size': 'S', 'price': 9.79},
    {'type': 'classic', 'name': 'rancho', 'size': 'M', 'price': 11.69},
    {'type': 'classic', 'name': 'rancho', 'size': 'L', 'price': 13.59},
    {'type': 'classic', 'name': 'rancho', 'size': 'XL', 'price': 16.09},
    {'type': 'classic', 'name': 'rancho', 'size': 'XXL', 'price': 19.79},
    {'type': 'classic', 'name': 'mexicana', 'size': 'S', 'price': 10.39},
    {'type': 'classic', 'name': 'mexicana', 'size': 'M', 'price': 12.29},
    {'type': 'classic', 'name': 'mexicana', 'size': 'L', 'price': 14.19},
    {'type': 'classic', 'name': 'mexicana', 'size': 'XL', 'price': 17.69},
    {'type': 'classic', 'name': 'mexicana', 'size': 'XXL', 'price': 20.49},
    {'type': 'veggie', 'name': 'four cheese', 'size': 'S', 'price': 9.59},
    {'type': 'veggie', 'name': 'four cheese', 'size': 'M', 'price': 11.49},
    {'type': 'veggie', 'name': 'four cheese', 'size': 'L', 'price': 13.39},
    {'type': 'veggie', 'name': 'four cheese', 'size': 'XL', 'price': 16.89},
    {'type': 'veggie', 'name': 'four cheese', 'size': 'XXL', 'price': 19.69},
    {'type': 'veggie', 'name': 'margarita', 'size': 'S', 'price': 8.89},
    {'type': 'veggie', 'name': 'margarita', 'size': 'M', 'price': 10.79},
    {'type': 'veggie', 'name': 'margarita', 'size': 'L', 'price': 12.69},
    {'type': 'veggie', 'name': 'margarita', 'size': 'XL', 'price': 16.19},
    {'type': 'veggie', 'name': 'margarita', 'size': 'XXL', 'price': 18.99},
    {'type': 'veggie', 'name': 'teriyaki', 'size': 'S', 'price': 10.29},
    {'type': 'veggie', 'name': 'teriyaki', 'size': 'M', 'price': 12.19},
    {'type': 'veggie', 'name': 'teriyaki', 'size': 'L', 'price': 14.09},
    {'type': 'veggie', 'name': 'teriyaki', 'size': 'XL', 'price': 17.59},
    {'type': 'veggie', 'name': 'teriyaki', 'size': 'XXL', 'price': 20.39},
    {'type': 'veggie', 'name': 'mushroom', 'size': 'S', 'price': 9.39},
    {'type': 'veggie', 'name': 'mushroom', 'size': 'M', 'price': 11.29},
    {'type': 'veggie', 'name': 'mushroom', 'size': 'L', 'price': 13.19},
    {'type': 'veggie', 'name': 'mushroom', 'size': 'XL', 'price': 16.69},
    {'type': 'veggie', 'name': 'mushroom', 'size': 'XXL', 'price': 19.49},
    {'type': 'veggie', 'name': 'jalapeno', 'size': 'S', 'price': 8.79},
    {'type': 'veggie', 'name': 'jalapeno', 'size': 'M', 'price': 10.69},
    {'type': 'veggie', 'name': 'jalapeno', 'size': 'L', 'price': 12.59},
    {'type': 'veggie', 'name': 'jalapeno', 'size': 'XL', 'price': 16.09},
    {'type': 'veggie', 'name': 'jalapeno', 'size': 'XXL', 'price': 18.89},
    {'type': 'veggie', 'name': 'rancho', 'size': 'S', 'price': 9.49},
    {'type': 'veggie', 'name': 'rancho', 'size': 'M', 'price': 11.39},
    {'type': 'veggie', 'name': 'rancho', 'size': 'L', 'price': 13.29},
    {'type': 'veggie', 'name': 'rancho', 'size': 'XL', 'price': 16.79},
    {'type': 'veggie', 'name': 'rancho', 'size': 'XXL', 'price': 19.59},
    {'type': 'veggie', 'name': 'mexicana', 'size': 'S', 'price': 10.99},
    {'type': 'veggie', 'name': 'mexicana', 'size': 'M', 'price': 12.89},
    {'type': 'veggie', 'name': 'mexicana', 'size': 'L', 'price': 14.79},
    {'type': 'veggie', 'name': 'mexicana', 'size': 'XL', 'price': 18.29},
    {'type': 'veggie', 'name': 'mexicana', 'size': 'XXL', 'price': 21.09}
]


# Pre-rendered lists of customer names and employee names
pre_rendered_customer_names = list(cust_dict.values())
pre_rendered_employee_names = list(emp_dict.values())

# Generate unique customer IDs
unique_customers = len(cust_dict)
customer_ids = list(cust_dict.keys())

# Generate order IDs
unique_orders = 250000
order_ids = [f'ORD{str(i).zfill(6)}' for i in range(1, unique_orders + 1)]

# Generate employee IDs
unique_employees = len(emp_dict)
employee_ids = list(emp_dict.keys())

# Initialize lists to store data
data = {
    'customer_id': [],
    'customer_full_name': [],
    'order_id': [],
    'timestamp': [],
    'name': [],
    'size': [],
    'type': [],
    'price': [],
    'employee_id': [],
    'employee_full_name': [],
    'in_or_out': []
}

# Populate the data
order_counter = 0
record_counter = 1

for order_id in order_ids:
    # Each order gets one customer, one employee, one date, one time, and one in_or_out status
    customer_id = customer_ids[order_counter % unique_customers]
    customer_full_name = cust_dict[customer_id]
    employee_id = employee_ids[order_counter % unique_employees]
    employee_full_name = emp_dict[employee_id]
    date = random_dates(start_date, end_date, 1)[0]
    timestamp = date.strftime('%Y-%m-%d %H:%M:%S')
    in_or_out = np.random.choice(['IN', 'OUT'])

    # Determine number of pizzas in this order (1 to 5)
    num_pizzas = random.randint(1, 5)

    for _ in range(num_pizzas):
        if record_counter > 500500:
            break

        # Randomly select pizza details ensuring type and name correspond
        pizza_details = random.choice(pizza_type_name_size_price)
        pizza_type = pizza_details['type']
        name = pizza_details['name']
        size = pizza_details['size']
        price = pizza_details['price']

        # Append data to lists
        data['customer_id'].append(customer_id)
        data['customer_full_name'].append(customer_full_name)
        data['order_id'].append(order_id)
        data['timestamp'].append(timestamp)
        data['name'].append(name)
        data['size'].append(size)
        data['type'].append(pizza_type)
        data['price'].append(price)
        data['employee_id'].append(employee_id)
        data['employee_full_name'].append(employee_full_name)
        data['in_or_out'].append(in_or_out)

        record_counter += 1

    if record_counter > 600000:
        break

    order_counter += 1

print(data)
# Create a new DataFrame
new_data = pd.DataFrame(data)

# Sort the data by timestamp from older to newer
new_data.sort_values(by='timestamp', inplace=True)
new_data.drop_duplicates()
# Save the new data to a CSV file
new_file_path = 'pizzaplace_rest_unique.csv'
new_data.to_csv(new_file_path, index=False)

print(f"New dataset saved to {new_file_path}")
