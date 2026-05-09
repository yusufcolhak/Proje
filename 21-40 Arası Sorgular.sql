USE [SporSalonu]
GO

-- 21. LEFT JOIN: Tüm üyeleri ve varsa ödemelerini listeler. Hiç ödeme yapmayanları NULL olarak gösterir.
SELECT U.Ad, U.Soyad, O.Miktar, O.OdemeTarihi 
FROM Uyeler U 
LEFT JOIN Odemeler O 
ON U.UyeID = O.UyeID;

-- 22. RIGHT JOIN: Tüm dersleri ve o derslere kayıt olan üyeleri getirir. Üyesi olmayan dersleri tespit eder.
SELECT D.DersAdi, U.Ad AS 'Katilimci Adı' 
FROM KatilimKayitlari K 
RIGHT JOIN Dersler D 
ON K.DersID = D.DersID 
LEFT JOIN Uyeler U 
ON K.UyeID = U.UyeID;

-- 23. FULL OUTER JOIN: Üye ve paket eşleşmelerini, eşleşme olmasa bile her iki taraftan da tam liste olarak sunar.
SELECT U.Ad, U.Soyad, P.PaketAdi 
FROM Uyeler U 
FULL OUTER JOIN UyelikPaketleri P 
ON U.PaketID = P.PaketID;

-- 24. TRIPLE INNER JOIN (Çoklu Birleştirme): Hangi üyenin hangi eğitmenin dersine katıldığını raporlar.
SELECT U.Ad AS 'Uye', D.DersAdi, E.Ad AS 'Egitmen' 
FROM KatilimKayitlari K 
INNER JOIN Uyeler U 
ON K.UyeID = U.UyeID 
INNER JOIN Dersler D 
ON K.DersID = D.DersID 
INNER JOIN Egitmenler E 
ON D.EgitmenID = E.EgitmenID;

-- 25. STRING (CONCAT / +): Üye adı ve soyadını tek bir sütunda profesyonel formatta birleştirir.
SELECT U.Ad + ' ' + U.Soyad + ' -> ' + P.PaketAdi AS 'Üyelik Özeti' 
FROM Uyeler U 
JOIN UyelikPaketleri P 
ON U.PaketID = P.PaketID;

-- 26. JOIN & GROUP BY: Her bir üyelik paketinin spor salonuna kazandırdığı toplam geliri hesaplar.
SELECT P.PaketAdi, SUM(O.Miktar) AS 'Toplam Kazanc' 
FROM Odemeler O 
INNER JOIN Uyeler U 
ON O.UyeID = U.UyeID 
INNER JOIN UyelikPaketleri P 
ON U.PaketID = P.PaketID 
GROUP BY P.PaketAdi;

-- 27. JOIN & HAVING: 2'den fazla farklı ders veren eğitmenlerin isimlerini ve ders sayılarını getirir.
SELECT E.Ad, E.Soyad, COUNT(D.DersID) AS 'Ders Sayisi' 
FROM Egitmenler E 
INNER JOIN Dersler D 
ON E.EgitmenID = D.EgitmenID 
GROUP BY E.Ad, E.Soyad 
HAVING COUNT(D.DersID) > 2;

-- 28. LEFT JOIN & IS NULL: Kayıtlı olup henüz hiçbir derse katılım sağlamamış "pasif" üyeleri bulur.
SELECT U.Ad, U.Soyad 
FROM Uyeler U 
LEFT JOIN KatilimKayitlari K 
ON U.UyeID = K.UyeID 
WHERE K.KatilimID IS NULL;

-- 29. DATE (DATEDIFF): Üyelerin kayıt tarihinden bugüne kadar kaç gün geçtiğini hesaplar.
SELECT Ad, Soyad, DATEDIFF(DAY, KayitTarihi, GETDATE()) AS 'Gecen Gun Sayisi' FROM Uyeler;

-- 30. STRING (UPPER/LOWER): Raporlama için eğitmen adlarını büyük, uzmanlık alanlarını küçük harfe çevirir.
SELECT UPPER(Ad) AS 'AD', LOWER(UzmanlikAlani) AS 'Uzmanlik' FROM Egitmenler;

-- 31. SUBQUERY: Ortalama ödeme miktarının üzerinde ödeme yapan üyeleri ve tutarları listeler.
SELECT U.Ad, O.Miktar 
FROM Uyeler U 
JOIN Odemeler O 
ON U.UyeID = O.UyeID 
WHERE O.Miktar > (SELECT AVG(Miktar) FROM Odemeler);

-- 32. DATE (MONTH/YEAR): 2026 yılının Mart ayında kayıt olan üyeleri getirir.
SELECT * FROM Uyeler WHERE YEAR(KayitTarihi) = 2026 AND MONTH(KayitTarihi) = 3;

-- 33. MULTIPLE JOIN & COUNT: Her bir dersin kontenjanı ile o derse giren aktif kişi sayısını karşılaştırır.
SELECT D.DersAdi, D.Kontenjan, COUNT(K.KatilimID) AS 'Aktif Katilimci' 
FROM Dersler D 
LEFT JOIN KatilimKayitlari K 
ON D.DersID = K.DersID 
GROUP BY D.DersAdi, D.Kontenjan;

-- 34. STRING (REPLACE): Mail adreslerindeki 'gmail.com' kısımlarını 'outlook.com' olarak maskeler.
SELECT Ad, REPLACE(MailHesabi, 'gmail.com', 'outlook.com') AS 'Yeni Mail' FROM Uyeler;

-- 35. TOP & ORDER BY: En çok ödeme yapan ilk 3 üyeyi ve toplam tutarlarını listeler.
SELECT TOP 3 U.Ad, SUM(O.Miktar) AS 'Toplam Odeme' 
FROM Uyeler U 
JOIN Odemeler O ON U.UyeID = O.UyeID 
GROUP BY U.Ad 
ORDER BY SUM(O.Miktar) DESC;

-- 36. JOIN & WHERE: Sadece 'Pilates' uzmanlığına sahip eğitmenlerin dersine giren üyeleri getirir.
SELECT DISTINCT U.Ad, U.Soyad 
FROM Uyeler U 
JOIN KatilimKayitlari K 
ON U.UyeID = K.UyeID 
JOIN Dersler D 
ON K.DersID = D.DersID 
JOIN Egitmenler E 
ON D.EgitmenID = E.EgitmenID 
WHERE E.UzmanlikAlani LIKE '%Pilates%';

-- 37. DATEPART: Ödemelerin haftanın hangi günlerinde (indeks olarak) yapıldığını analiz eder.
SELECT DATEPART(DW, OdemeTarihi) AS 'Haftanin Gunu', COUNT(*) AS 'Islem Sayisi' 
FROM Odemeler GROUP BY DATEPART(DW, OdemeTarihi);

-- 38. JOIN & MIN: En ucuz üyelik paketine sahip olan üyenin iletişim bilgilerini getirir.
SELECT TOP 1 U.Ad, U.TelefonNumarasi, P.Ucret 
FROM Uyeler U 
JOIN UyelikPaketleri P 
ON U.PaketID = P.PaketID 
ORDER BY P.Ucret ASC;

-- 39. AGGREGATE (AVG): Derslerin ortalama kontenjan kapasitesini hesaplar.
SELECT AVG(Kontenjan) AS 'Ortalama Kontenjan' FROM Dersler;

-- 40. COMPLEX JOIN (Final): Her üyenin toplam kaç derse girdiğini ve toplam kaç TL ödediğini tek satırda gösterir.
SELECT U.Ad, COUNT(DISTINCT K.KatilimID) AS 'Toplam Ders', SUM(O.Miktar) AS 'Toplam Odeme' 
FROM Uyeler U 
LEFT JOIN KatilimKayitlari K 
ON U.UyeID = K.UyeID 
LEFT JOIN Odemeler O 
ON U.UyeID = O.UyeID 
GROUP BY U.Ad;
GO