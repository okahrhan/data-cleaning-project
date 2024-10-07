-- incorrectly duplicated data
DELETE FROM housing1 
WHERE UniqueID = 'UniqueID';


-- standardizing date dormat SalesData

SELECT STR_TO_DATE(SaleDate, '%M %d, %Y') AS saleDateConverted
FROM housing1;

UPDATE housing1
SET SaleDate = STR_TO_DATE(SaleDate, '%M %d, %Y');



-- NULL address
Select *
From housing1 h 
order by ParcelID;

UPDATE housing1
SET PropertyAddress = NULL
WHERE PropertyAddress = '';


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, COALESCE(a.PropertyAddress, b.PropertyAddress) AS MergedPropertyAddress
FROM housing1 a
JOIN housing1 b
  ON a.ParcelID = b.ParcelID
  AND a.`UniqueID` <> b.`UniqueID`
WHERE a.PropertyAddress IS NULL;


UPDATE housing1 a
JOIN housing1 b
  ON a.ParcelID = b.ParcelID
  AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = COALESCE(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress IS NULL;


--   splitting and updating address

SELECT PropertyAddress
FROM housing1 h ;
-- WHERE PropertyAddress IS NULL
-- ORDER BY ParcelID;

-- Split PropertyAddress two parts
SELECT
SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1) AS Address,
TRIM(SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1)) AS Address
FROM housing1 h ;

-- PropertySplitAddress kolonu ekleme
ALTER TABLE housing1 
ADD PropertySplitAddress NVARCHAR(255);


-- add a new column
UPDATE housing1 
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1);

SELECT *
FROM housing1 h ;

-- update the new column
ALTER TABLE housing1 
ADD PropertySplitCity NVARCHAR(255);


UPDATE housing1 
SET PropertySplitCity = TRIM(SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1));


SELECT *
FROM housing1 h ;


SELECT OwnerAddress
FROM housing1 h ;

-- split ownerAddress three parts
SELECT
SUBSTRING_INDEX(OwnerAddress, ',', 1) AS OwnerSplitAddress,
SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1) AS OwnerSplitCity,
SUBSTRING_INDEX(OwnerAddress, ',', -1) AS OwnerSplitState
FROM housing1 h ;



ALTER TABLE housing1 
ADD OwnerSplitAddress NVARCHAR(255);




UPDATE housing1 
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);


ALTER TABLE housing1 
ADD OwnerSplitCity NVARCHAR(255);


UPDATE housing1 
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1);


ALTER TABLE housing1 
ADD OwnerSplitState NVARCHAR(255);

UPDATE housing1 
SET OwnerSplitState = SUBSTRING_INDEX(OwnerAddress, ',', -1);


SELECT *
FROM housing1 h ;






-- Change Y and N to Yes and No in "Sold as Vacant" field


SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM housing1 h 
GROUP BY SoldAsVacant
ORDER BY 2;

-- 
SELECT SoldAsVacant,
       CASE 
           WHEN SoldAsVacant = 'Y' THEN 'Yes'
           WHEN SoldAsVacant = 'N' THEN 'No'
           ELSE SoldAsVacant
       END AS ConvertedSoldAsVacant
FROM housing1 h ;

-- 
UPDATE housing1 
SET SoldAsVacant = CASE 
                      WHEN SoldAsVacant = 'Y' THEN 'Yes'
                      WHEN SoldAsVacant = 'N' THEN 'No'
                      ELSE SoldAsVacant
                   END;
                  















