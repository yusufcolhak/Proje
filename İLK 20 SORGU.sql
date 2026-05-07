USE [SporSalonu]
GO

-- 1. COUNT: Kredi Kartı ile yapılan toplam ödeme sayısını bulur.
SELECT COUNT(*) AS 'Kredi Kartlı Ödeme Sayısı' 
FROM Odemeler 
WHERE OdemeTipi = 'Kredi Kartı';

-- 2. SUM: Kasaya giren toplam geliri hesaplar.
SELECT SUM(Miktar) AS 'Toplam Gelir' 
FROM Odemeler;

-- 3. AVG: Mevcut üyelik paketlerinin ortalama ücretini bulur.
SELECT AVG(Ucret) AS 'Ortalama Paket Ücreti' 
FROM UyelikPaketleri;

-- 4. MIN ve MAX: En düşük ve en yüksek ödeme miktarını yan yana gösterir.
SELECT MIN(Miktar) AS 'En Düşük Ödeme', MAX(Miktar) AS 'En Yüksek Ödeme' 
FROM Odemeler;

-- 5. GROUP BY: Her bir ödeme tipinden kaç adet işlem yapıldığını sayar.
SELECT OdemeTipi, COUNT(*) AS 'İşlem Sayısı' 
FROM Odemeler 
GROUP BY OdemeTipi;

-- 6. GROUP BY ve HAVING: Sadece 'Kredi Kartı' grubunu filtreleyip o gruptaki işlem sayısını getirir.
SELECT OdemeTipi, COUNT(*) AS 'Kredi Kartı İşlem Sayısı' 
FROM Odemeler 
GROUP BY OdemeTipi 
HAVING OdemeTipi = 'Kredi Kartı';

-- 7. LIKE '_': İsminin ikinci harfi 'a' olan üyeleri listeler.
SELECT * FROM Uyeler 
WHERE Ad LIKE '_a%';

-- 8. LIKE '[ ]': İsmi A, B, C, Ç, D harflerinden biriyle başlayan üyeleri getirir.
SELECT * FROM Uyeler 
WHERE Ad LIKE '[A-D]%';

-- 9. DISTINCT ve COUNT: Eğitmenler tablosunda tekrarsız olarak kaç farklı uzmanlık alanı olduğunu sayar.
SELECT COUNT(DISTINCT UzmanlikAlani) AS 'Farklı Uzmanlık Sayısı' 
FROM Egitmenler;

-- 10. ORDER BY: Dersleri kontenjan sayısına göre en kalabalıktan en aza doğru sıralar.
SELECT * FROM Dersler 
ORDER BY Kontenjan DESC;

-- 11. TOP: Üyelik paketlerini pahalıdan ucuza sıralayıp sadece fiyatı en yüksek olan ilk 3 paketi getirir.
SELECT TOP 3 * FROM UyelikPaketleri 
ORDER BY Ucret DESC;

-- 12. TOP PERCENT: Eğitmenler listesindeki kayıtların sadece ilk %50'lik kısmını listele.
SELECT TOP 50 PERCENT * FROM Egitmenler;

-- 13. IN: Sadece Eğitmen ID'si 1, 3 veya 5 olan dersleri filtreler.
SELECT * FROM Dersler 
WHERE EgitmenID IN (1, 3, 5);

-- 14. BETWEEN: Ücreti 500 ile 2000 TL arasında olan üyelik paketlerini listeler.
SELECT * FROM UyelikPaketleri 
WHERE Ucret BETWEEN 500 AND 2000;

-- 15. INNER JOIN: Ödemeler ve Üyeler tablolarını birleştirerek; Hangi üye, ne zaman, ne kadar ödemiş detaylı olarak gösterir.
SELECT U.Ad, U.Soyad, O.Miktar, O.OdemeTarihi, O.OdemeTipi
FROM Odemeler O
INNER JOIN Uyeler U ON O.UyeID = U.UyeID;

-- 16. Adı 'a' Soyadı 'y' ile başlayan üyeler.
SELECT Ad, Soyad, TelefonNumarasi
FROM Uyeler
WHERE Ad LIKE 'A%' OR Soyad LIKE 'Y%'

-- 17. Adının içinde 'e' harfi bulunmayan üyeler.
SELECT Ad, Soyad 
FROM Uyeler 
WHERE Ad NOT LIKE '%e%';

-- 18. Çoklu ORDER BY: Önce ders saatine , sonra kontenjana sıralar.
SELECT DersAdi, DersSaati, Kontenjan 
FROM Dersler 
ORDER BY DersSaati ASC, Kontenjan DESC;

-- 19. Çoklu İstatistik: Min, Max ve Avg komutlarını tek sorguda kullanarak fiyat analizi yapar.
SELECT MIN(Ucret) AS 'En Ucuz Paket', MAX(Ucret) AS 'En Pahali Paket', AVG(Ucret) AS 'Ortalama Fiyat' 
FROM UyelikPaketleri;

-- 20. 3 Tablolu INNER JOIN: Hangi üye, hangi derse, ne zaman katıldı.
SELECT U.Ad, U.Soyad, D.DersAdi, K.KatilimTarihi
FROM KatilimKayitlari K
INNER JOIN Uyeler U ON K.UyeID = U.UyeID
INNER JOIN Dersler D ON K.DersID = D.DersID;

GO

