CREATE TABLE VucutOlcumleri (
    OlcumID INT PRIMARY KEY IDENTITY(1,1),
    UyeID INT,
    OlcumTarihi DATE,
    Kilo DECIMAL(5,2),
    Boy INT,
    YagOrani DECIMAL(5,2)
    )