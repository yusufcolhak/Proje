USE [SporSalonu]
GO

--  Tüm dolap tahsis kayıtlarını getirir.
SELECT * FROM Dolaplar;

--  Şu an kullanımda olan (tahsis edilmiş) toplam dolap sayısını verir.
SELECT COUNT(*) AS 'Tahsis Edilen Dolap Sayisi' 
FROM Dolaplar

--  Dolapları en son tahsis edilenden en eskiye doğru sıralar.
SELECT * FROM Dolaplar 
ORDER BY TahsisTarihi DESC

--  Sistemi en son kullanan (en yeni) 3 dolap sahibini getirir.
SELECT TOP 3 * FROM Dolaplar 
ORDER BY TahsisTarihi DESC

--  Sadece numarası 'A' ile başlayan (A serisi) dolapları listeler.
SELECT * FROM Dolaplar 
WHERE DolapNo LIKE 'A%'

--  Belirli bir tarihten (1 Ocak 2026) sonraki dolap tahsislerini gösterir.
SELECT * FROM Dolaplar 
WHERE TahsisTarihi > '2026-01-01'

--  2025 yılı içerisinde verilmiş olan dolapları aralık belirterek getirir.
SELECT * FROM Dolaplar 
WHERE TahsisTarihi BETWEEN '2025-01-01' AND '2025-12-31'

--  Hangi gün kaç tane dolap kiralandığını/tahsis edildiğini hesaplar.
SELECT TahsisTarihi, COUNT(*) AS 'O Gun Verilen Dolap Sayisi' 
FROM Dolaplar 
GROUP BY TahsisTarihi

--  INNER JOIN: Dolap No ile o dolabın sahibi olan üyenin Ad ve Soyadını birleştirir.
SELECT D.DolapNo, U.Ad, U.Soyad, D.TahsisTarihi
FROM Dolaplar D
INNER JOIN Uyeler U ON D.UyeID = U.UyeID

--  INNER JOIN: Dolabı olan üyelerin iletişim bilgilerini listeler.
SELECT D.DolapNo, U.Ad, U.Soyad, U.TelefonNumarasi
FROM Dolaplar D
INNER JOIN Uyeler U ON D.UyeID = U.UyeID
GO
