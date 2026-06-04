


-- ADIM 1: MEVCUT DURUMU GÖSTERME
-- öncelikle 1 numaralı dersimizin güncel kontenjanına bakalım:
SELECT DersID, DersAdi, Kontenjan 
FROM Dersler 
WHERE DersID = 1


-- ADIM 2: DERSE KAYIT İŞLEMİ (Kontenjan Düşürücü Trigger Devreye Girecek)
-- Şimdi 3 numaralı üyemizi bu derse kaydediyoruz:
INSERT INTO KatilimKayitlari (UyeID, DersID, KatilimTarihi, KatilimDurumu)
VALUES (3, 1, GETDATE(), 'Aktif')


-- ADIM 3: KONTENJANI TEKRAR KONTROL ETME


-- ADIM 4: KAYIT İPTALİ (Kontenjan İade Trigger'ı Devreye Girecek)
-- Diyelim ki üyemiz derse gelmekten vazgeçti ve kaydını sildirdi. 
DELETE FROM KatilimKayitlari 
WHERE UyeID = 3 AND DersID = 1


-- ADIM 5: İADE KONTROLÜ
