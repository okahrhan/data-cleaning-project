import csv

# Bozuk CSV dosyasını oku
with open('housing(Sheet1).csv', mode='r', encoding='utf-8') as bozuk_dosya:
    reader = csv.reader(bozuk_dosya, delimiter=';')  # Bozuk dosya ; ile ayrılmış
    rows = list(reader)

# Yeni format için başlıklar
headers = [
    'UniqueID', 'ParcelID', 'LandUse', 'PropertyAddress', 'SaleDate', 'SalePrice', 'LegalReference',
    'SoldAsVacant', 'OwnerName', 'OwnerAddress', 'Acreage', 'TaxDistrict', 'LandValue', 'BuildingValue',
    'TotalValue', 'YearBuilt', 'Bedrooms', 'FullBath', 'HalfBath'
]

# Yeni dosyaya yaz
with open('housing1.csv', mode='w', newline='', encoding='utf-8') as duzeltilmis_dosya:
    writer = csv.writer(duzeltilmis_dosya)
    writer.writerow(headers)  # Başlıkları yaz
    
    # Verileri dönüştürüp yaz
    for row in rows:
        if len(row) == len(headers):  # Satırdaki veri başlık sayısına uyuyorsa yaz
            writer.writerow(row)
        else:
            # Eğer satır eksikse ya da fazlaysa buraya ek dönüşümler yapabilirsin
            pass

print("Dosya başarıyla düzeltildi!")
