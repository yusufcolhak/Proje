-- ====================================================================
-- 1. TÜM ÜYELERİN NULL ALANLARINI TOPLU DOLDURMA
-- (Herkesi Aktif yapar, rastgele doğum tarihi ve telefon atar)
-- ====================================================================
UPDATE Uyeler 
SET 
    UyelikDurumu = 'Aktif',
    Cinsiyet = CASE WHEN UyeID % 2 = 0 THEN 'Kadın' ELSE 'Erkek' END, -- ID çift ise Kadın, tek ise Erkek yapar
    DogumTarihi = DATEADD(YEAR, -20 - (UyeID % 15), GETDATE()), -- Her üyeye 20-35 yaş arası mantıklı doğum tarihi üretir
    AcilDurumTlf = '0532' + CAST(1000000 + UyeID AS VARCHAR(10)); -- Her üyeye benzersiz acil durum nosu üretir
GO

-- ====================================================================
-- 2. TÜM EGİTMENLERİN NULL ALANLARINI TOPLU DOLDURMA
-- ====================================================================
UPDATE Egitmenler 
SET 
    Maas = 25000.00 + (EgitmenID * 1500), -- Her eğitmene ID'sine göre artan maaş yazar (26500, 28000...)
    IseBaslamaTarihi = DATEADD(MONTH, -EgitmenID * 3, GETDATE()); -- İşe başlama tarihlerini geçmişe dönük ayarlar
GO

-- ====================================================================
-- 3. TÜM ÜYELİK PAKETLERİNİ TOPLU DOLDURMA
-- (Paket adına bakarak geçerlilik süresini otomatik tahmin eder)
-- ====================================================================
UPDATE UyelikPaketleri 
SET GecerlilikSuresiAy = 
    CASE 
        WHEN PaketAdi LIKE '%3%' OR PaketAdi LIKE '%Üç%' THEN 3
        WHEN PaketAdi LIKE '%6%' OR PaketAdi LIKE '%Altı%' THEN 6
        WHEN PaketAdi LIKE '%12%' OR PaketAdi LIKE '%Yıl%' THEN 12
        ELSE 1 -- Eğer eşleşen bulamazsa varsayılan olarak 1 aylık yapar
    END;
GO

-- ====================================================================
-- 4. TÜM DERSLERİN NULL ALANLARINI TOPLU DOLDURMA
-- ====================================================================
UPDATE Dersler 
SET 
    DersSuresiDk = 60, -- Tüm dersleri standart 60 dakika yapar
    ZorlukDerecesi = CASE WHEN DersID % 3 = 0 THEN 'İleri' WHEN DersID % 3 = 1 THEN 'Başlangıç' ELSE 'Orta' END,
    DersGunu = CASE WHEN DersID % 2 = 0 THEN 'Pazartesi' ELSE 'Çarşamba' END;
GO

-- ====================================================================
-- 5. TÜM ÖDEMELERİN NULL ALANLARINI TOPLU DOLDURMA
-- ====================================================================
UPDATE Odemeler 
SET 
    IndirimOrani = CASE WHEN OdemeID % 5 = 0 THEN 10 ELSE 0 END, -- Bazı ödemelere %10 indirim simüle eder
    TaksitSayisi = CASE WHEN OdemeTipi LIKE '%Kart%' THEN 3 ELSE 1 END; -- Kartla ödenenleri 3 taksit, diğerlerini peşin yapar
GO

-- ====================================================================
-- 6. TÜM KATILIM KAYITLARINI (YOKLAMA) TOPLU DOLDURMA
-- ====================================================================
UPDATE KatilimKayitlari 
SET KatilimDurumu = CASE WHEN KatilimID % 10 = 0 THEN 'Gelmedi' ELSE 'Geldi' END; -- Küçük bir kısmı gelmedi, çoğunluk geldi
GO