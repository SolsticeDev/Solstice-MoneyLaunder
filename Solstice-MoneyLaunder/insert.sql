CREATE TABLE investments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(255) NOT NULL,
    businessName VARCHAR(255) NOT NULL,
    amountInvested INT NOT NULL,
    convertedAmount INT NOT NULL,
    endTime TIMESTAMP NOT NULL
);
