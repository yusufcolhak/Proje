/****** SSMS’ten SelectTopNRows komutu için betik  ******/
SELECT TOP (1000) [EgitmenID]
      ,[Ad]
      ,[Soyad]
      ,[UzmanlikAlani]
      ,[TelefonNumarasi]
  FROM [SporSalonu].[dbo].[Egitmenler]