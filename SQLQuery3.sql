/****** SSMS’ten SelectTopNRows komutu için betik  ******/
SELECT TOP (1000) [PaketID]
      ,[PaketAdi]
      ,[Sure]
      ,[Ucret]
  FROM [SporSalonu].[dbo].[UyelikPaketleri]