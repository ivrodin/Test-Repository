#
# import pandas as pd
# import numpy as np
# import random
# from datetime import datetime, timedelta
# from faker import Faker
#
# fake = Faker()
#
# # Define the date range for the last two years
# end_date = datetime.now()
# start_date = end_date - timedelta(days=2 * 365)
#
#
# # Generate random dates within the last two years
# def random_dates(start, end, n):
#     start_u = start.timestamp()
#     end_u = end.timestamp()
#     return [datetime.fromtimestamp(random.uniform(start_u, end_u)) for _ in range(n)]
#
#
# cust_dict = {
#     'CUST0001': 'JAMES SMITH',
#     'CUST0002': 'JOHN JOHNSON',
#     'CUST0003': 'ROBERT WILLIAMS',
#     'CUST0004': 'MICHAEL JONES',
#     'CUST0005': 'WILLIAM BROWN',
#     'CUST0006': 'DAVID DAVIS',
#     'CUST0007': 'RICHARD MILLER',
#     'CUST0008': 'CHARLES WILSON',
#     'CUST0009': 'JOSEPH MOORE',
#     'CUST0010': 'THOMAS TAYLOR',
#     'CUST0011': 'CHRISTOPHER ANDERSON',
#     'CUST0012': 'DANIEL THOMAS',
#     'CUST0013': 'PAUL JACKSON',
#     'CUST0014': 'MARK WHITE',
#     'CUST0015': 'DONALD HARRIS',
#     'CUST0016': 'GEORGE MARTIN',
#     'CUST0017': 'KENNETH THOMPSON',
#     'CUST0018': 'STEVEN GARCIA',
#     'CUST0019': 'EDWARD MARTINEZ',
#     'CUST0020': 'BRIAN ROBINSON',
#     'CUST0021': 'RONALD CLARK',
#     'CUST0022': 'ANTHONY RODRIGUEZ',
#     'CUST0023': 'KEVIN LEWIS',
#     'CUST0024': 'JASON LEE',
#     'CUST0025': 'MATTHEW WALKER',
#     'CUST0026': 'GARY HALL',
#     'CUST0027': 'TIMOTHY ALLEN',
#     'CUST0028': 'JOSE YOUNG',
#     'CUST0029': 'LARRY HERNANDEZ',
#     'CUST0030': 'JEFFREY KING',
#     'CUST0031': 'FRANK WRIGHT',
#     'CUST0032': 'SCOTT LOPEZ',
#     'CUST0033': 'ERIC HILL',
#     'CUST0034': 'STEPHEN SCOTT',
#     'CUST0035': 'ANDREW GREEN',
#     'CUST0036': 'RAYMOND ADAMS',
#     'CUST0037': 'GREGORY BAKER',
#     'CUST0038': 'JOSHUA GONZALEZ',
#     'CUST0039': 'JERRY NELSON',
#     'CUST0040': 'DENNIS CARTER',
#     'CUST0041': 'WALTER MITCHELL',
#     'CUST0042': 'PATRICK PEREZ',
#     'CUST0043': 'PETER ROBERTS',
#     'CUST0044': 'HAROLD TURNER',
#     'CUST0045': 'DOUGLAS PHILLIPS',
#     'CUST0046': 'HENRY CAMPBELL',
#     'CUST0047': 'CARL PARKER',
#     'CUST0048': 'ARTHUR EVANS',
#     'CUST0049': 'RYAN EDWARDS',
#     'CUST0050': 'ROGER COLLINS',
#     'CUST0051': 'JOE STEWART',
#     'CUST0052': 'JUAN SANCHEZ',
#     'CUST0053': 'JACK MORRIS',
#     'CUST0054': 'ALBERT ROGERS',
#     'CUST0055': 'JONATHAN REED',
#     'CUST0056': 'JUSTIN COOK',
#     'CUST0057': 'TERRY MORGAN',
#     'CUST0058': 'GERALD BELL',
#     'CUST0059': 'KEITH MURPHY',
#     'CUST0060': 'SAMUEL BAILEY',
#     'CUST0061': 'WILLIE RIVERA',
#     'CUST0062': 'RALPH COOPER',
#     'CUST0063': 'LAWRENCE RICHARDSON',
#     'CUST0064': 'NICHOLAS COX',
#     'CUST0065': 'ROY HOWARD',
#     'CUST0066': 'BENJAMIN WARD',
#     'CUST0067': 'BRUCE TORRES',
#     'CUST0068': 'BRANDON PETERSON',
#     'CUST0069': 'ADAM GRAY',
#     'CUST0070': 'HARRY RAMIREZ',
#     'CUST0071': 'FRED COLLINS',
#     'CUST0072': 'WAYNE BELL',
#     'CUST0073': 'BILLY GOMEZ',
#     'CUST0074': 'STEVE KELLY',
#     'CUST0075': 'LOUIS HOWELL',
#     'CUST0076': 'JEREMY WOOD',
#     'CUST0077': 'AARON WASHINGTON',
#     'CUST0078': 'RANDY LONG',
#     'CUST0079': 'HOWARD FOSTER',
#     'CUST0080': 'EUGENE SANDERS',
#     'CUST0081': 'CARLOS PRICE',
#     'CUST0082': 'RUSSELL WOODS',
#     'CUST0083': 'BOBBY POWELL',
#     'CUST0084': 'VICTOR BARNES',
#     'CUST0085': 'MARTIN HENDERSON',
#     'CUST0086': 'ERNEST COLEMAN',
#     'CUST0087': 'PHILLIP SIMMONS',
#     'CUST0088': 'TODD SIMPSON',
#     'CUST0089': 'JESSE REYNOLDS',
#     'CUST0090': 'CRAIG CUNNINGHAM',
#     'CUST0091': 'ALAN BRADLEY',
#     'CUST0092': 'SHAWN LANE',
#     'CUST0093': 'CLARENCE ANDREWS',
#     'CUST0094': 'SEAN RUIZ',
#     'CUST0095': 'PHILIP HARPER',
#     'CUST0096': 'CHRIS FOX',
#     'CUST0097': 'JOHNNY RILEY',
#     'CUST0098': 'EARL ARMSTRONG',
#     'CUST0099': 'JIMMY CARPENTER',
#     'CUST0100': 'ANTONIO WEAVER',
#     'CUST0101': 'DANNY GREENE',
#     'CUST0102': 'BRYAN LAWRENCE',
#     'CUST0103': 'TONY ELLIOTT',
#     'CUST0104': 'LUIS CHAVEZ',
#     'CUST0105': 'MIKE SIMONS',
#     'CUST0106': 'STANLEY BURKE',
#     'CUST0107': 'LEONARD RICHARDS',
#     'CUST0108': 'NATHAN WATSON',
#     'CUST0109': 'DALE FIELDS',
#     'CUST0110': 'MANUEL WATTS',
#     'CUST0111': 'RODNEY HENRY',
#     'CUST0112': 'CURTIS TUCKER',
#     'CUST0113': 'NORMAN MENDOZA',
#     'CUST0114': 'ALLEN DIXON',
#     'CUST0115': 'MARVIN RUIZ',
#     'CUST0116': 'VINCENT ARMSTRONG',
#     'CUST0117': 'GLENN PETERSON',
#     'CUST0118': 'JEFFERY EVANS',
#     'CUST0119': 'TRAVIS GORDON',
#     'CUST0120': 'JEFF BREWER',
#     'CUST0121': 'CHAD RUIZ',
#     'CUST0122': 'JACOB NICHOLS',
#     'CUST0123': 'LEE HERRERA',
#     'CUST0124': 'MELVIN MEDINA',
#     'CUST0125': 'ALFRED FOWLER',
#     'CUST0126': 'KYLE BRENNAN',
#     'CUST0127': 'FRANCIS CALDWELL',
#     'CUST0128': 'BRADLEY DAY',
#     'CUST0129': 'JESUS LUCAS',
#     'CUST0130': 'HERBERT BECK',
#     'CUST0131': 'FREDERICK GILBERT',
#     'CUST0132': 'RAY AUSTIN',
#     'CUST0133': 'JOEL GIBSON',
#     'CUST0134': 'EDWIN GARDNER',
#     'CUST0135': 'DON HARVEY',
#     'CUST0136': 'EDDIE CARROLL',
#     'CUST0137': 'RICKY PERKINS',
#     'CUST0138': 'TROY WILLIAMSON',
#     'CUST0139': 'RANDALL JOHNSTON',
#     'CUST0140': 'BARRY MARSHALL',
#     'CUST0141': 'ALEXANDER OLIVER',
#     'CUST0142': 'BERNARD BISHOP',
#     'CUST0143': 'MARIO GRANT',
#     'CUST0144': 'LEROY WEBSTER',
#     'CUST0145': 'FRANCISCO KENNEDY',
#     'CUST0146': 'MARCUS BISHOP',
#     'CUST0147': 'THEODORE SINGH',
#     'CUST0148': 'CLIFFORD BECKER',
#     'CUST0149': 'MIGUEL CURTIS',
#     'CUST0150': 'OSCAR MORALES',
#     'CUST0151': 'JAY MARSH',
#     'CUST0152': 'JIM WATKINS',
#     'CUST0153': 'TOMMY POPE',
#     'CUST0154': 'LEON HOPKINS',
#     'CUST0155': 'DEREK FOWLER',
#     'CUST0156': 'WARREN SOTO',
#     'CUST0157': 'DARRELL BUCKLEY',
#     'CUST0158': 'JEROME SERRANO',
#     'CUST0159': 'FLOYD REESE',
#     'CUST0160': 'LEO WALTER',
#     'CUST0161': 'ALVIN BATES',
#     'CUST0162': 'TIM KELLER',
#     'CUST0163': 'WESLEY LEONARD',
#     'CUST0164': 'GORDON CHURCH',
#     'CUST0165': 'DEAN HORTON',
#     'CUST0166': 'GREG WALSH',
#     'CUST0167': 'JORGE LYONS',
#     'CUST0168': 'DUSTIN RAMSEY',
#     'CUST0169': 'PEDRO WOLFE',
#     'CUST0170': 'DERRICK SCHNEIDER',
#     'CUST0171': 'DAN WAGNER',
#     'CUST0172': 'LEWIS HARRINGTON',
#     'CUST0173': 'ZACHARY DANIELS',
#     'CUST0174': 'COREY SIMPSON',
#     'CUST0175': 'HERMAN ARMSTRONG',
#     'CUST0176': 'MAURICE RICHARD',
#     'CUST0177': 'VERNON CARR',
#     'CUST0178': 'ROBERTO MARTIN',
#     'CUST0179': 'CLYDE SOTO',
#     'CUST0180': 'GLEN BOWEN',
#     'CUST0181': 'HECTOR VAUGHN',
#     'CUST0182': 'SHANE FREEMAN',
#     'CUST0183': 'RICARDO PRICE',
#     'CUST0184': 'SAMMY MCKINNEY',
#     'CUST0185': 'RICK MORSE',
#     'CUST0186': 'LESTER MCDANIEL',
#     'CUST0187': 'BRENT SANCHEZ',
#     'CUST0188': 'RAMON POLK',
#     'CUST0189': 'CHARLIE SMALL',
#     'CUST0190': 'TYLER SALINAS',
#     'CUST0191': 'GILBERT RICHMOND',
#     'CUST0192': 'GENE STUART',
#     'CUST0193': 'MARCOS CRANE',
#     'CUST0194': 'LUIS LAMBERT',
#     'CUST0195': 'DARRIN PEARSON',
#     'CUST0196': 'NEIL HOOK',
#     'CUST0197': 'DWAYNE SHARP',
#     'CUST0198': 'VICTOR GOULD',
#     'CUST0199': 'WADE YATES',
#     'CUST0200': 'STUART GRIMES'
# }
#
#
# cour_dict = {
#     'CR0001': 'JAMES SMITH',
#     'CR0002': 'JOHN JOHNSON',
#     'CR0003': 'ROBERT WILLIAMS',
#     'CR0004': 'MICHAEL JONES',
#     'CR0005': 'WILLIAM BROWN',
#     'CR0006': 'DAVID DAVIS',
#     'CR0007': 'RICHARD MILLER',
#     'CR0008': 'CHARLES WILSON',
#     'CR0009': 'JOSEPH MOORE',
#     'CR0010': 'THOMAS TAYLOR',
#     'CR0011': 'CHRISTOPHER ANDERSON',
#     'CR0012': 'DANIEL THOMAS',
#     'CR0013': 'PAUL JACKSON',
#     'CR0014': 'MARK WHITE',
#     'CR0015': 'DONALD HARRIS',
#     'CR0016': 'GEORGE MARTIN',
#     'CR0017': 'KENNETH THOMPSON',
#     'CR0018': 'STEVEN GARCIA',
#     'CR0019': 'EDWARD MARTINEZ',
#     'CR0020': 'BRIAN ROBINSON',
#     'CR0021': 'RONALD CLARK',
#     'CR0022': 'ANTHONY RODRIGUEZ',
#     'CR0023': 'KEVIN LEWIS',
#     'CR0024': 'JASON LEE',
#     'CR0025': 'MATTHEW WALKER',
#     'CR0026': 'GARY HALL',
#     'CR0027': 'TIMOTHY ALLEN',
#     'CR0028': 'JOSE YOUNG',
#     'CR0029': 'LARRY HERNANDEZ',
#     'CR0030': 'JEFFREY KING'
# }
#
#
# # Pre-rendered lists of customer names and courier names
# pre_rendered_customer_names = list(cust_dict.values())
# pre_rendered_courier_names = list(cour_dict.values())
#
# # Generate order IDs
# unique_orders = 250000
# order_ids = [f'ORD{str(i).zfill(6)}' for i in range(1, unique_orders + 1)]
#
# # Define possible values for name, size, type
# names = ['hawaiian', 'classic_dlx', 'mexicana', 'thai_ckn', 'five_cheese']  # Add more names as needed
# sizes = ['S', 'M', 'L', 'XL', 'XXL']
# types = ['classic', 'veggie', 'chicken']
#
# # Initialize lists to store data
# data = {
#     'record_id': [],
#     'customer_id': [],
#     'customer_full_name': [],
#     'order_id': [],
#     'timestamp': [],
#     'name': [],
#     'size': [],
#     'type': [],
#     'price': [],
#     'delivery_id': [],
#     'delivery_name': [],
#     'courier_id': [],
#     'courier_full_name': []
# }
#
# # Generate random prices based on size (this is an approximation)
# size_price_map = {
#     'S': np.random.uniform(5, 15, 500000),
#     'M': np.random.uniform(10, 20, 500000),
#     'L': np.random.uniform(15, 25, 500000),
#     'XL': np.random.uniform(20, 30, 500000),
#     'XXL': np.random.uniform(25, 35, 500000)
# }
#
# # Assign delivery and courier details to orders
# delivery_names = ['Tornado', 'Clovo', 'Panda']
#
# order_counter = 0
# record_counter = 500501  # Start record_id from 500501
#
# for order_id in order_ids:
#     customer_id = list(cust_dict.keys())[order_counter % len(cust_dict)]
#     customer_full_name = cust_dict[customer_id]
#
#     date = random_dates(start_date, end_date, 1)[0]
#     timestamp = date.strftime('%Y-%m-%d %H:%M:%S')
#
#     # Randomly select delivery and courier for the order
#     delivery_id = order_counter % 3 + 1  # Assign delivery_id (1, 2, 3)
#     delivery_name = delivery_names[delivery_id - 1]
#
#     courier_id = list(cour_dict.keys())[(order_counter // 3) % len(cour_dict)]  # Assign courier_id cyclically
#     courier_full_name = cour_dict[courier_id]
#
#     num_pizzas = random.randint(1, 5)
#
#     for _ in range(num_pizzas):
#         # Randomly select pizza details
#         name = np.random.choice(names)
#         size = np.random.choice(sizes)
#         type = np.random.choice(types)
#         price = size_price_map[size][order_counter % 500000]
#         price = round(price, 2)  # Round price to two decimal places
#
#         # Append data to lists
#         data['record_id'].append(record_counter)
#         data['customer_id'].append(customer_id)
#         data['customer_full_name'].append(customer_full_name)
#         data['order_id'].append(order_id)
#         data['timestamp'].append(timestamp)
#         data['name'].append(name)
#         data['size'].append(size)
#         data['type'].append(type)
#         data['price'].append(price)
#         data['delivery_id'].append(delivery_id)
#         data['delivery_name'].append(delivery_name)
#         data['courier_id'].append(courier_id)
#         data['courier_full_name'].append(courier_full_name)
#
#         record_counter += 1
#
#     order_counter += 1
#
# # Create a new DataFrame
# new_data = pd.DataFrame(data)
#
# # Sort the data by timestamp from older to newer
# new_data.sort_values(by='timestamp', inplace=True)
#
# # Save the new data to a CSV file
# new_file_path = 'pizzaplace_online.csv'
# new_data.to_csv(new_file_path, index=False)
#
# print(f"New dataset saved to {new_file_path}")

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


cour_dict = {
    'CR0001': 'JAMES SMITH',
    'CR0002': 'JOHN JOHNSON',
    'CR0003': 'ROBERT WILLIAMS',
    'CR0004': 'MICHAEL JONES',
    'CR0005': 'WILLIAM BROWN',
    'CR0006': 'DAVID DAVIS',
    'CR0007': 'RICHARD MILLER',
    'CR0008': 'CHARLES WILSON',
    'CR0009': 'JOSEPH MOORE',
    'CR0010': 'THOMAS TAYLOR',
    'CR0011': 'CHRISTOPHER ANDERSON',
    'CR0012': 'DANIEL THOMAS',
    'CR0013': 'PAUL JACKSON',
    'CR0014': 'MARK WHITE',
    'CR0015': 'DONALD HARRIS',
    'CR0016': 'GEORGE MARTIN',
    'CR0017': 'KENNETH THOMPSON',
    'CR0018': 'STEVEN GARCIA',
    'CR0019': 'EDWARD MARTINEZ',
    'CR0020': 'BRIAN ROBINSON',
    'CR0021': 'RONALD CLARK',
    'CR0022': 'ANTHONY RODRIGUEZ',
    'CR0023': 'KEVIN LEWIS',
    'CR0024': 'JASON LEE',
    'CR0025': 'MATTHEW WALKER',
    'CR0026': 'GARY HALL',
    'CR0027': 'TIMOTHY ALLEN',
    'CR0028': 'JOSE YOUNG',
    'CR0029': 'LARRY HERNANDEZ',
    'CR0030': 'JEFFREY KING'
}

# Pre-rendered lists of customer names and courier names
pre_rendered_customer_names = list(cust_dict.values())
pre_rendered_courier_names = list(cour_dict.values())

# Generate order IDs
unique_orders = 250000
order_ids = [f'ORD{str(i).zfill(6)}' for i in range(1, unique_orders + 1)]

# Define possible values for pizza type and name
pizza_type_name = {
    'classic': ['pepperoni', 'ham and mushrooms', 'teriyaki', 'salami', 'rancho', 'mexicana'],
    'veggie': ['four cheese', 'margarita', 'teriyaki', 'mushroom', 'jalapeno', 'rancho', 'mexicana']
}
sizes = ['S', 'M', 'L', 'XL', 'XXL']

# Initialize lists to store data
data = {
    'record_id': [],
    'customer_id': [],
    'customer_full_name': [],
    'order_id': [],
    'timestamp': [],
    'pizza_type': [],
    'pizza_name': [],
    'size': [],
    'price': [],
    'delivery_id': [],
    'delivery_name': [],
    'courier_id': [],
    'courier_full_name': []
}

# Generate a fixed price for each unique combination of pizza type, name, and size
price_map = {}
for pizza_type, names in pizza_type_name.items():
    for name in names:
        for size in sizes:
            price_map[(pizza_type, name, size)] = round(np.random.uniform(5, 35), 2)

# Assign delivery and courier details to orders
delivery_names = ['Tornado', 'Clovo', 'Panda']

order_counter = 0
record_counter = 500501  # Start record_id from 500501

for order_id in order_ids:
    customer_id = list(cust_dict.keys())[order_counter % len(cust_dict)]
    customer_full_name = cust_dict[customer_id]

    date = random_dates(start_date, end_date, 1)[0]
    timestamp = date.strftime('%Y-%m-%d %H:%M:%S')

    # Randomly select delivery and courier for the order
    delivery_id = order_counter % 3 + 1  # Assign delivery_id (1, 2, 3)
    delivery_name = delivery_names[delivery_id - 1]

    courier_id = list(cour_dict.keys())[(order_counter // 3) % len(cour_dict)]  # Assign courier_id cyclically
    courier_full_name = cour_dict[courier_id]

    num_pizzas = random.randint(1, 5)

    for _ in range(num_pizzas):
        # Randomly select pizza details
        pizza_type = np.random.choice(list(pizza_type_name.keys()))
        pizza_name = np.random.choice(pizza_type_name[pizza_type])
        size = np.random.choice(sizes)
        price = price_map[(pizza_type, pizza_name, size)]

        # Append data to lists
        data['record_id'].append(record_counter)
        data['customer_id'].append(customer_id)
        data['customer_full_name'].append(customer_full_name)
        data['order_id'].append(order_id)
        data['timestamp'].append(timestamp)
        data['pizza_type'].append(pizza_type)
        data['pizza_name'].append(pizza_name)
        data['size'].append(size)
        data['price'].append(price)
        data['delivery_id'].append(delivery_id)
        data['delivery_name'].append(delivery_name)
        data['courier_id'].append(courier_id)
        data['courier_full_name'].append(courier_full_name)

        record_counter += 1

    order_counter += 1

# Create a new DataFrame
new_data = pd.DataFrame(data)

# Sort the data by timestamp from older to newer
new_data.sort_values(by='timestamp', inplace=True)

# Save the new data to a CSV file
new_file_path = 'pizzaplace_online.csv'
new_data.to_csv(new_file_path, index=False)

print(f"New dataset saved to {new_file_path}")
