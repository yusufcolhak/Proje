CREATE TABLE Ekipmanlar (
    EkipmanID INT PRIMARY KEY IDENTITY(1,1), 
    Kategori NVARCHAR(50),      
    EkipmanAdi NVARCHAR(100),
    Marka NVARCHAR(50),
    Adet INT,                   
    SatinAlinmaTarihi DATE,
    SonBakimTarihi DATE,
    Durum NVARCHAR(50)          
)