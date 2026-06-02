SELECT * FROM VucutOlcumleri
WHERE UyeID = 5

SELECT AVG(Boy) AS OrtalamaBoy, AVG(Kilo) AS OrtalamaKilo
FROM VucutOlcumleri

SELECT MIN(YagOrani) AS EnDusukYag, MAX(YagOrani) AS EnYuksekYag
FROM VucutOlcumleri

SELECT * FROM VucutOlcumleri
WHERE Boy > 175 AND Kilo < 80

SELECT u.Ad, u.Soyad, v.Kilo, v.YagOrani
FROM Uyeler AS u
INNER JOIN VucutOlcumleri AS v
ON u.UyeID = v.UyeID

SELECT UyeID, Kilo, Boy, Kilo / ((Boy / 100.0) * (Boy / 100.0)) AS VucutKitleIndeksi
FROM VucutOlcumleri
WHERE Kilo / ((Boy / 100.0) * (Boy / 100.0)) > 25

SELECT UyeID, Kilo, Boy FROM VucutOlcumleri
ORDER BY Kilo DESC

SELECT * FROM VucutOlcumleri
WHERE YEAR(OlcumTarihi) = 2025 AND MONTH(OlcumTarihi) = 12

SELECT UyeID, YagOrani FROM VucutOlcumleri
WHERE YagOrani BETWEEN 12 AND 18

SELECT TOP 3 UyeID, Boy, Kilo, YagOrani
FROM VucutOlcumleri
ORDER BY Boy DESC