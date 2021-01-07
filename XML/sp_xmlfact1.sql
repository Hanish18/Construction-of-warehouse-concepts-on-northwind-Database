/*create a stored procedure that
generates a xml data from the Student 
table data having student attributes as xml tags
which store thier value*/
USE [SupplyChain]
GO
/****** Object:  StoredProcedure [dbo].[getXMLFromTableData]    Script Date: 11/14/2018 11:50:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[getXMLFromTableData]
AS
BEGIN
select  *
from factProductSupplierDetails
for xml auto, elements, root ('ProductSuppiers')
END