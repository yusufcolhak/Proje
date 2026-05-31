-- 1. SELECT İÇİNDE MATEMATİK (+ ve /): Paket ücretine %20 KDV ekleyip günlük ortalamasını bulma.
SELECT PaketAdi, Ucret, (Ucret + (Ucret * 20 / 100)) / 30 AS GunlukMaliyet
FROM UyelikPaketleri

-- 2. SELECT İÇİNDE MATEMATİK (-): Mevcut ödeme miktarlarından 50 TL kampanya indirimi düşerek listeleme.
SELECT OdemeID, Miktar, Miktar - 50 AS IndirimliTutar 
FROM Odemeler

-- 3. SELECT İÇİNDE MATEMATİK (*): Derslerin mevcut kontenjanını 2 katına çıkarsaydık toplam ne kadar kapasite olurdu?
SELECT DersAdi, Kontenjan, Kontenjan * 2 AS HedefKapasite 
FROM Dersler

-- 4. >= ve AND KULLANIMI: Fiyatı 1000 TL ve üzeri olan VE Kredi Kartı ile yapılan ödemeler.
SELECT * FROM Odemeler 
WHERE Miktar >= 1000 AND OdemeTipi = 'Kredi Kartı'

-- 5. <= KULLANIMI: Kontenjanı 15 veya daha az olan butik/özel dersleri listeleme.
SELECT * FROM Dersler 
WHERE Kontenjan <= 15

-- 6. NOT BETWEEN: Fiyatı 500 ile 1500 TL aralığında OLMAYAN paketler.
SELECT * FROM UyelikPaketleri 
WHERE Ucret NOT BETWEEN 500 AND 1500

-- 7. LİKE İÇİNDE VİRGÜL [ , ]: Eğitmenlerin isimleri sadece 'A' veya 'M' harfi ile başlıyorsa listeleme.
SELECT Ad, Soyad FROM Egitmenler 
WHERE Ad LIKE '[A,M]%'

-- 8. NOT LIKE İÇİNDE TİRE [ - ]: Adı A ile M harfleri arasındaki karakterlerle BAŞLAMAYAN üyeler.
SELECT Ad, Soyad FROM Uyeler 
WHERE Ad NOT LIKE '[A-M]%'

-- 9. LİKE '__%': Adı 'M' ile başlayan ve sonrasında en az 2 karakter daha olan (minimum 3 harfli) üyeler.
SELECT * FROM Uyeler 
WHERE Ad LIKE 'M__%'

-- 10. ÇOKLU OR KULLANIMI: Belirli paket ID'lerine sahip olanları getirme (IN alternatifi).
SELECT Ad, Soyad, PaketID FROM Uyeler 
WHERE PaketID = 1 OR PaketID = 2 OR PaketID = 3

-- 11. YALIN ORDER BY (Varsayılan ASC): Eğitmenleri isme göre A'dan Z'ye sıralama.
SELECT Ad, UzmanlikAlani FROM Egitmenler 
ORDER BY Ad

-- 12. YALIN ORDER BY ÇOKLU: Dersleri önce Eğitmen numarasına, sonra kontenjana göre sıralama.
SELECT * FROM Dersler 
ORDER BY EgitmenID, Kontenjan

-- 13. SÜTUN BAZLI DISTINCT: Sadece birbirinden farklı uzmanlık alanlarının metin listesi.
SELECT DISTINCT UzmanlikAlani 
FROM Egitmenler

-- 14. >= ve <= İLE ARALIK: BETWEEN yerine matematiksel küçüktür/büyüktür operatörleri ile aralık belirleme.
SELECT * FROM Dersler 
WHERE Kontenjan >= 10 AND Kontenjan <= 20

-- 15. ÇİFT LIKE ve AND: Adında 'an' geçen ve soyadında 'k' bulunan üyeler.
SELECT Ad, Soyad FROM Uyeler 
WHERE Ad LIKE '%an%' AND Soyad LIKE '%k%'

-- 16. WHERE İÇİNDE MATEMATİK: Yapılan ödemenin yarısı 400 TL'den büyük olan yüksek miktarlı ödemeleri bulma.
SELECT * FROM Odemeler 
WHERE (Miktar / 2) > 400

-- 17. ALIAS (AS) TIRNAKSIZ YAZIM: Tablodaki sütunlara tırnaksız referans (takma ad) tanımlama.
SELECT Ad, Soyad, TelefonNumarasi AS Iletisim 
FROM Uyeler

-- 18. BOŞLUK KONTROLÜ (LIKE '% %'): İçerisinde en az bir boşluk karakteri barındıran (iki isimli) üyeleri bulma.
SELECT Ad, Soyad FROM Uyeler 
WHERE Ad LIKE '% %'

-- 19. JOIN İLE WHERE İÇİNDE >= KONTROLÜ: Inner Join yapıp, ödemesi 1500 TL'den büyük ve eşit olan üyeler.
SELECT U.Ad, O.Miktar 
FROM Uyeler U 
INNER JOIN Odemeler O ON U.UyeID = O.UyeID 
WHERE O.Miktar >= 1500

-- 20. MULTIPLE OR İLE SPESİFİK SEÇİM: Spesifik ID'lere sahip katılımları seçme.
SELECT * FROM KatilimKayitlari 
WHERE KatilimID = 1 OR KatilimID = 5 OR KatilimID = 10

-- 21. LEN(): Üyelerin ad ve soyadlarının kaç karakterden oluştuğunu bulma.
SELECT Ad, LEN(Ad) AS 'Ad Uzunluk', Soyad, LEN(Soyad) AS 'Soyad Uzunluk' 
FROM Uyeler

-- 22. LEN() ve ORDER BY: Üyeleri, isimlerinin uzunluğuna göre en kısa isimden en uzuna doğru sıralama.
SELECT Ad, LEN(Ad) AS 'Uzunluk' 
FROM Uyeler 
ORDER BY Uzunluk ASC

-- 23. UPPER() ve LOWER(): Eğitmenlerin isimlerini tamamen BÜYÜK, uzmanlık alanlarını tamamen küçük harfle gösterme.
SELECT UPPER(Ad) AS 'Egitmen', LOWER(UzmanlikAlani) AS 'Uzmanlik' 
FROM Egitmenler

-- 24. CONCAT() ve LEFT(): İsmin ilk harfi ve soyadı birleştirerek şirkete özel otomatik kullanıcı adı oluşturma.
SELECT Ad, Soyad, CONCAT(LEFT(Ad, 1), '.', Soyad) AS 'Kullanici Adi' 
FROM Uyeler

-- 25. SUBSTRING() ve RIGHT(): Telefon numaralarının ilk 3 karakterini (Alan Kodu) alma ve numaranın son 4 hanesini gösterme.
SELECT TelefonNumarasi, 
       SUBSTRING(TelefonNumarasi, 1, 3) AS 'Alan Kodu', 
       RIGHT(TelefonNumarasi, 4) AS 'Son 4 Hane' 
FROM Uyeler

-- 26. REPLACE(): Yanlış yazıldığını varsaydığımız 'gmail.com' uzantılarını metin içinden bulup 'outlook.com' olarak değiştirme.
SELECT MailHesabi, REPLACE(MailHesabi, 'gmail.com', 'outlook.com') AS 'Yeni Mail' 
FROM Uyeler 
WHERE MailHesabi LIKE '%gmail.com%'

-- 27. LTRIM() ve RTRIM(): Veri girişinde yanlışlıkla ismin başına veya sonuna bırakılan gereksiz boşlukları temizleme.
SELECT Ad, LTRIM(Ad) AS 'Sol Bosluk Temiz', RTRIM(Ad) AS 'Sag Bosluk Temiz' 
FROM Uyeler

-- 28. İÇ İÇE (NESTED) STRING: Üyenin adının ilk harfini BÜYÜK, kalanını KÜÇÜK, soyadını komple BÜYÜK yapma.
SELECT CONCAT(UPPER(LEFT(Ad, 1)), LOWER(SUBSTRING(Ad, 2, LEN(Ad))), ' ', UPPER(Soyad)) AS 'Muntazam Isim'
FROM Uyeler

-- 29. CAST(): Ödeme tarihlerinde bulunan "Saat:Dakika:Saniye" kısımlarını silip, veriyi saf "DATE" (Tarih) formatına dönüştürme.
SELECT Miktar, OdemeTarihi, CAST(OdemeTarihi AS date) AS 'Sadece Tarih' 
FROM Odemeler

-- 30. YEAR(), MONTH() ve DAY(): Sadece 2026 yılının Haziran (6. ay) ayında yapılan ödemeleri günleriyle birlikte listeleme.
SELECT Miktar, OdemeTarihi, DAY(OdemeTarihi) AS 'Gun' 
FROM Odemeler 
WHERE YEAR(OdemeTarihi) = 2026 AND MONTH(OdemeTarihi) = 6

-- 31. DECLARE İLE DEĞİŞKEN TANIMLAMA (@): Dışarıdan bir tarih değişkeni belirleyip, bu tarihten sonraki ödemeleri filtreleme.
DECLARE @BaslangicTarihi DATE = '2026-05-01';
SELECT * FROM Odemeler 
WHERE CAST(OdemeTarihi AS date) > @BaslangicTarihi

-- 32. TABLO ALIAS (Kısaltma) VE KÖŞELİ PARANTEZ [ ]: Txt'deki [Order Details] mantığıyla veritabanı adını garantiye alma.
SELECT u.Ad, u.Soyad, p.PaketAdi 
FROM [Uyeler] as u
INNER JOIN [UyelikPaketleri] as p 
ON u.PaketID = p.PaketID

-- 33. ZİNCİRLEME INNER JOIN (4 Tablo): (Employees -> Territories -> Region) mantığıyla, Üyenin hangi eğitmenin dersine katıldığını bulma.
SELECT u.Ad AS 'Uye', d.DersAdi, e.Ad AS 'Egitmen', e.UzmanlikAlani
FROM Uyeler u
INNER JOIN KatilimKayitlari k ON u.UyeID = k.UyeID
INNER JOIN Dersler d ON k.DersID = d.DersID
INNER JOIN Egitmenler e ON d.EgitmenID = e.EgitmenID;

-- 34. LEFT JOIN VE ALIAS: Müşteri/Sipariş mantığıyla, tüm üyeleri ve eğer varsa ödemelerini (ödemesi olmayanları NULL ile) getirme.
SELECT u.Ad, u.Soyad, o.Miktar, o.OdemeTarihi
FROM Uyeler as u
LEFT JOIN Odemeler as o 
ON u.UyeID = o.UyeID;

GO