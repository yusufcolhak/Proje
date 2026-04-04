-- Üyelik Paketleri Tablosu
CREATE TABLE UyelikPaketleri (
    PaketID INT PRIMARY KEY IDENTITY(1,1), -- Paket ID(PK) 
    PaketAdi NVARCHAR(50),
    Sure NVARCHAR(20),
    Ucret DECIMAL(10,2) -- Ücret sütunu [cite: 11]
);

-- Eğitmenler Tablosu
CREATE TABLE Egitmenler (
    EgitmenID INT PRIMARY KEY IDENTITY(1,1), -- Eğitmen ID(PK) 
    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    UzmanlikAlani NVARCHAR(100),
    TelefonNumarasi NVARCHAR(15)
);