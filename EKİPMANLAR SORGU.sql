-- Tüm Ekipmanların Genel Listesi (Kategori ve İsme Göre Sıralı)
SELECT EkipmanID, Kategori, EkipmanAdi, Marka, Adet, Durum 
FROM Ekipmanlar 
ORDER BY Kategori, EkipmanAdi;
GO

-- Şu An Kullanılamaz Durumda Olan (Arızalı veya Bakımda) Ekipmanlar
-- Yönetimin hızlı müdahale etmesi gereken sorunlu cihazları listeler.
SELECT EkipmanAdi, Kategori, Marka, Durum 
FROM Ekipmanlar 
WHERE Durum IN ('Arızalı', 'Bakımda');
GO

-- Kategorilere Göre Toplam Ekipman Çeşidi ve Toplam Adet Sayıları
-- Salonda toplam kaç tane kardiyo, kaç tane makine vb. ürün grubu olduğunu özetler.
SELECT Kategori, 
       COUNT(*) AS CesitSayisi, 
       SUM(Adet) AS ToplamAdet 
FROM Ekipmanlar 
GROUP BY Kategori;
GO

-- Durumlarına Göre (Aktif/Arızalı/Bakımda) Toplam Ekipman Adetleri
-- Salonun operasyonel kapasitesini ve çalışır durumdaki cihaz yüzdesini ölçmek için kullanılır.
SELECT Durum, 
       SUM(Adet) AS ToplamAdet 
FROM Ekipmanlar 
GROUP BY Durum;
GO

-- Hiç Bakım Görmemiş (Son Bakım Tarihi NULL Olan) Ekipmanlar
-- Genelde sarf malzemesi olan (mat, pilates topu gibi) veya bakımı unutulmuş ürünleri bulur.
SELECT EkipmanAdi, Kategori, SatinAlinmaTarihi 
FROM Ekipmanlar 
WHERE SonBakimTarihi IS NULL;
GO

-- Salonda En Fazla Sayıda Bulunan İlk 3 Ekipman (Adet Bazlı)
-- Yoğunluk gruplarını ve en çok yatırım yapılan küçük/büyük ekipmanları listeler.
SELECT TOP 3 EkipmanAdi, Kategori, Adet 
FROM Ekipmanlar 
ORDER BY Adet DESC;
GO

-- Belirli Bir Markaya (Örn: Technogym veya Life Fitness) Ait Ekipmanların Listesi
-- Marka bazlı garanti veya teknik servis takibi yapmak için filtreleme sağlar.
SELECT EkipmanAdi, Kategori, Marka, Durum 
FROM Ekipmanlar 
WHERE Marka IN ('Technogym', 'Life Fitness');
GO

-- Son Bakımı 2026 Yılında Yapılmış Olan Güncel Ekipmanlar
-- Yakın zamanda teknik kontrolden geçmiş cihazların takibini sağlar.
SELECT EkipmanAdi, Marka, SonBakimTarihi 
FROM Ekipmanlar 
WHERE YEAR(SonBakimTarihi) = 2026;
GO

-- 2025 Yılı ve Sonrasında Satın Alınan Yeni Ekipmanlar
-- Salona son dönemde katılan yeni demirbaş yatırımlarını raporlar.
SELECT EkipmanAdi, Kategori, SatinAlinmaTarihi 
FROM Ekipmanlar 
WHERE SatinAlinmaTarihi >= '2025-01-01'
ORDER BY SatinAlinmaTarihi DESC;
GO

-- Ekipmanların Durumunu Detaylı Metinle Gösteren Gelişmiş Rapor (CASE WHEN)
-- Durum alanındaki teknik terimleri rapora uygun daha anlaşılır açıklamalara çevirir.
SELECT EkipmanAdi, 
       Kategori, 
       CASE 
            WHEN Durum = 'Aktif' THEN 'Kullanıma Hazır / Güvenli'
            WHEN Durum = 'Arızalı' THEN 'TEKNİK SERVİS BEKLİYOR'
            WHEN Durum = 'Bakımda' THEN 'Rutin Kontrolde'
            ELSE 'Bilinmiyor' 
       END AS DetayliKullanimDurumu
FROM Ekipmanlar;
GO