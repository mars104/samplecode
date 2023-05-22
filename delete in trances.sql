DECLARE @BatchSize INT = 1000; -- Adjust the batch size as per your requirement

WHILE 1 = 1
BEGIN
    DELETE T
    FROM (
        SELECT TOP (@BatchSize) ROW_NUMBER() OVER (PARTITION BY BINARY_CHECKSUM(*) ORDER BY %%physloc%%) AS RowNumber, *
        FROM MyTable
    ) T
    WHERE T.RowNumber > 1;

    IF @@ROWCOUNT = 0
        BREAK;
END
