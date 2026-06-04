
SELECT UyeID, Ad, Soyad, UyelikDurumu 
FROM Uyeler 
WHERE UyeID IN (16, 2)


INSERT INTO Dolaplar (DolapNo, UyeID, TahsisTarihi)
VALUES (55, 16, GETDATE())



INSERT INTO Dolaplar (DolapNo, UyeID, TahsisTarihi)
VALUES (99, 2, GETDATE())




