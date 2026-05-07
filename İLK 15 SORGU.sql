USE SporSalonu
GO

-- 1) Kredi Kartı ile yapılan toplam ödeme sayısını bulur. COUNT (Saymak)
SELECT COUNT(*) AS 'Kredi kartlı ödeme sayısı'
From Odemeler
Where OdemeTipi = 'Kredi Kartı';

-- 2) Kasaya giren toplam parayı hesaplar.SUM (Toplamak)
SELECT SUM(Miktar) AS 'Toplam Gelir'
From Odemeler;

-- 3) Mevcut üyelik paketlerinin ortalama ücretini bulur.AVG (Ortalama - Average)
SELECT AVG(Ucret) AS 'Ortalama Paket Ücreti'
FROM UyelikPaketleri;

-- 4) En düşük ve En yüksek ödeme miktarını yan yana gösterir.
SELECT MIN(Miktar) AS 'En Düşük Ödeme' , MAX(Miktar) AS 'En Yüksek Ödeme'
FROM Odemeler;

-- 5) Her bir ödeme tipinden kaç adet işlem yapıldığını sayar.
SELECT OdemeTipi, COUNT(*) AS 'İşlem Sayısı'
FROM Odemeler
GROUP BY OdemeTipi;

-- 6) Sadece 'Kredi Kartı' grubunu filtreleyip o gruptaki işlem sayısını getirir.
SELECT OdemeTipi, COUNT(*) AS 'Kredi Kartı İşlem Sayısı'
FROM Odemeler
GROUP BY OdemeTipi
Having OdemeTipi = 'Kredi Kartı';

-- 7) İsminin ikinci harfi 'a' olanları listeler .
SELECT * FROM Uyeler
WHERE Ad LIKE '_a%';

-- 8) İsmi A, B, C, Ç, D harflerinden biriyle başlayan üyeleri getirir.
SELECT * FROM Uyeler 
WHERE Ad LIKE '[A-D]%';

--9) Eğitmenler tablosunda tekrarsız olarak kaç farklı uzmanlık alanı olduğunu sayar.
SELECT COUNT(DISTINCT UzmanlikAlani) AS 'Farklı Uzmanlık Sayısı' 
FROM Egitmenler;

-- 10) Dersleri kontenjan sayısına göre en kalabalıktan en aza doğru sıralar.
SELECT * FROM Dersler 
Order By Kontenjan DESC;

-- 11) Üyelik paketlerini pahalıdan ucuza sıralayıp sadece fiyatı en yüksek olan ilk 3 paketi getirir.
SELECT TOP 3 * FROM UyelikPaketleri
Order By Ucret DESC;

-- 12) Eğitmenler listesindeki kayıtların sadece ilk %50lik kısmını listele .
SELECT TOP 50 PERCENT * FROM Egitmenler; 

-- 13) Sadece eğitmen ID'si 1,3 veya 5 olan dersleri filtreler .
SELECT * FROM Dersler 
WHERE EgitmenID IN (1,3,5);

-- 14) Ücreti 500TL ile 2000TL arasında olan üyelik paketlerini listeler .
SELECT * FROM UyelikPaketleri
WHERE Ucret BETWEEN 500 and 2000;

-- 15) Ödemeler ve Üyeler tablolarını birleştirerek; Hangi üye, ne zaman, ne kadar ödemiş detaylı olarak gösterir.
SELECT U.Ad, U.Soyad, O.Miktar, O.OdemeTarihi, O.OdemeTipi
FROM Odemeler O
INNER JOIN Uyeler U ON O.UyeID = U.UyeID;
GO
