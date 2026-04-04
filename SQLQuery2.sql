-- Üyeler Tablosu
CREATE TABLE Uyeler (
    UyeID INT PRIMARY KEY IDENTITY(1,1), -- Üye ID(PK) 
    PaketID INT, -- Paket ID(FK) 
    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    MailHesabi NVARCHAR(100),
    TelefonNumarasi NVARCHAR(15),
    KayitTarihi DATE DEFAULT GETDATE(), -- Kayıt Tarihi [cite: 11]
    FOREIGN KEY (PaketID) REFERENCES UyelikPaketleri(PaketID) -- İlişki 
);

-- Dersler Tablosu
CREATE TABLE Dersler (
    DersID INT PRIMARY KEY IDENTITY(1,1), -- Ders ID(PK) 
    EgitmenID INT, -- Eğitmen ID(FK) 
    DersAdi NVARCHAR(100),
    DersSaati TIME,
    Kontenjan INT,
    FOREIGN KEY (EgitmenID) REFERENCES Egitmenler(EgitmenID) -- İlişki 
);

-- Ödemeler Tablosu
CREATE TABLE Odemeler (
    OdemeID INT PRIMARY KEY IDENTITY(1,1), -- Ödeme ID(PK) 
    UyeID INT, -- Üye ID(FK) 
    Miktar DECIMAL(10,2),
    OdemeTarihi DATE DEFAULT GETDATE(), -- Ödeme Tarihi [cite: 11]
    OdemeTipi NVARCHAR(30),
    FOREIGN KEY (UyeID) REFERENCES Uyeler(UyeID) -- İlişki 
);

-- Katılım Kayıtları Tablosu
CREATE TABLE KatilimKayitlari (
    KatilimID INT PRIMARY KEY IDENTITY(1,1), -- Katılım ID(PK) 
    UyeID INT, -- Üye ID(FK) 
    DersID INT, -- Ders ID(FK) 
    KatilimTarihi DATE DEFAULT GETDATE(), -- Katılım Tarihi [cite: 11]
    FOREIGN KEY (UyeID) REFERENCES Uyeler(UyeID), -- İlişki 
    FOREIGN KEY (DersID) REFERENCES Dersler(DersID) -- İlişki 
);