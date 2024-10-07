import csv

with open('housing(Sheet1).csv', mode='r', encoding='utf-8') as bozuk_dosya:
    reader = csv.reader(bozuk_dosya, delimiter=';')  # Bozuk dosya ; ile ayrılmış
    rows = list(reader)

headers = [
    'UniqueID', 'ParcelID', 'LandUse', 'PropertyAddress', 'SaleDate', 'SalePrice', 'LegalReference',
    'SoldAsVacant', 'OwnerName', 'OwnerAddress', 'Acreage', 'TaxDistrict', 'LandValue', 'BuildingValue',
    'TotalValue', 'YearBuilt', 'Bedrooms', 'FullBath', 'HalfBath'
]

with open('housing1.csv', mode='w', newline='', encoding='utf-8') as duzeltilmis_dosya:
    writer = csv.writer(duzeltilmis_dosya)
    writer.writerow(headers)  # Başlıkları yaz
    
    for row in rows:
        if len(row) == len(headers):
            writer.writerow(row)
        else:
            pass

print("Dosya başarıyla düzeltildi!")
