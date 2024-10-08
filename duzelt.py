import csv

with open('housing(Sheet1).csv', mode='r', encoding='utf-8') as first:
    reader = csv.reader(first, delimiter=';')  
    rows = list(reader)

headers = [
    'UniqueID', 'ParcelID', 'LandUse', 'PropertyAddress', 'SaleDate', 'SalePrice', 'LegalReference',
    'SoldAsVacant', 'OwnerName', 'OwnerAddress', 'Acreage', 'TaxDistrict', 'LandValue', 'BuildingValue',
    'TotalValue', 'YearBuilt', 'Bedrooms', 'FullBath', 'HalfBath'
]

with open('housing1.csv', mode='w', newline='', encoding='utf-8') as second:
    writer = csv.writer(second)
    writer.writerow(headers)  
    
    for row in rows:
        if len(row) == len(headers):
            writer.writerow(row)
        else:
            pass

print("successfully !")
