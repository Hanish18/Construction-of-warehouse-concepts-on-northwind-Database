USE [SupplyChain]
GO
/****** Object:  StoredProcedure [dbo].[getXMLFromTableData2]    Script Date: 12/25/2018 4:15:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[getXMLFromTableData2]
AS
BEGIN
select  *
from dimOrders
for xml auto, elements, root ('OrderEmployees')
END