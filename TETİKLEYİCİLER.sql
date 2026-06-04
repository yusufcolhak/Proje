

CREATE TRIGGER trg_DerseKayit_KontenjanKontrol
ON KatilimKayitlari
AFTER INSERT
AS
BEGIN
    -- 1. Adım: Kontenjan dolu mu diye kontrol et
    IF EXISTS (
        SELECT 1 FROM inserted i 
        INNER JOIN Dersler d ON i.DersID = d.DersID 
        WHERE d.Kontenjan <= 0
    )
    BEGIN
        -- Doluysa hata mesajı fırlat ve işlemi iptal et
        RAISERROR ('HATA: Seçtiğiniz dersin kontenjanı tamamen doludur! Kayıt alınamadı.', 16, 1)
        ROLLBACK TRANSACTION
    END
    ELSE
    BEGIN
        -- 2. Adım: Yer varsa kaydı onayla ve kontenjan sayısını 1 azalt
        UPDATE Dersler
        SET Kontenjan = Kontenjan - 1
        FROM Dersler d 
        INNER JOIN inserted i ON d.DersID = i.DersID
    END
END
GO



USE [SporSalonu]
GO

CREATE TRIGGER trg_KayitIptal_KontenjanIade
ON KatilimKayitlari
AFTER DELETE
AS
BEGIN
    -- 'deleted' tablosu, o an silinmekte olan veriyi tutar.
    -- Silinen kişinin çıktığı dersin kontenjanını 1 artırıyoruz.
    UPDATE Dersler
    SET Kontenjan = Kontenjan + 1
    FROM Dersler d
    INNER JOIN deleted del ON d.DersID = del.DersID
END
GO



USE [SporSalonu]
GO

CREATE TRIGGER trg_CiftDolapEngeli
ON Dolaplar
AFTER INSERT, UPDATE
AS
BEGIN
    -- Eğer eklenmeye çalışılan Üye ID, Dolaplar tablosunda 1'den fazla kez geçiyorsa:
    IF EXISTS (
        SELECT UyeID 
        FROM Dolaplar 
        WHERE UyeID IN (SELECT UyeID FROM inserted)
        GROUP BY UyeID 
        HAVING COUNT(*) > 1
    )
    BEGIN
        -- İşlemi durdur ve uyarı ver
        RAISERROR ('HATA: Kural ihlali! Bir üyeye aynı anda sadece bir adet dolap tahsis edilebilir.', 16, 1)
        ROLLBACK TRANSACTION
    END
END
GO
