-- 1. Uyeler Tablosu Güncelleme
ALTER TABLE Uyeler ADD 
    DogumTarihi DATE,
    Cinsiyet VARCHAR(10),
    AcilDurumTlf VARCHAR(15),
    UyelikDurumu VARCHAR(10) DEFAULT 'Aktif'


-- 2. Egitmenler Tablosu Güncelleme
ALTER TABLE Egitmenler ADD 
    Maas DECIMAL(10,2),
    IseBaslamaTarihi DATE


-- 3. UyelikPaketleri Tablosu Güncelleme
ALTER TABLE UyelikPaketleri ADD 
    GecerlilikSuresiAy INT


-- 4. Dersler Tablosu Güncelleme
ALTER TABLE Dersler ADD 
    DersGunu VARCHAR(15),
    ZorlukDerecesi VARCHAR(15),
    DersSuresiDk INT


-- 5. Odemeler Tablosu Güncelleme
ALTER TABLE Odemeler ADD 
    IndirimOrani INT DEFAULT 0,
    TaksitSayisi INT DEFAULT 1


-- 6. KatilimKayitlari Tablosu Güncelleme
ALTER TABLE KatilimKayitlari ADD 
    KatilimDurumu VARCHAR(10)
