/* ============================================================
   BANKING FRAUD DATABASE
   ============================================================ */

CREATE DATABASE BankingFraudDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE BankingFraudDB;

/* ============================================================
   01. DIM BANK
   ============================================================ */

CREATE TABLE DimBank (
    BankID INT NOT NULL,
    BankName VARCHAR(100) NOT NULL,
    Country VARCHAR(50),
    Region VARCHAR(50),
    BankType VARCHAR(100),
    PRIMARY KEY (BankID)
)  ENGINE=INNODB;

/* ============================================================
   02. DIM LOCATION
   ============================================================ */

CREATE TABLE DimLocation (
    LocationID VARCHAR(20) NOT NULL,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(50),
    Region VARCHAR(50),
    Latitude DECIMAL(10 , 7 ),
    Longitude DECIMAL(10 , 7 ),
    AreaType VARCHAR(50),
    PRIMARY KEY (LocationID)
)  ENGINE=INNODB;

/* ============================================================
   03. DIM MERCHANT
   ============================================================ */

CREATE TABLE DimMerchant (
    MerchantID VARCHAR(30) NOT NULL,
    MerchantName VARCHAR(150) NOT NULL,
    MerchantCategory VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(50),
    MerchantRiskScore INT,
    MerchantStatus VARCHAR(50),
    AverageTransactionAmount DECIMAL(18 , 2 ),
    PRIMARY KEY (MerchantID)
)  ENGINE=INNODB;

/* ============================================================
   04. DIM DEVICE
   ============================================================ */

CREATE TABLE DimDevice (
    DeviceID VARCHAR(30) NOT NULL,
    DeviceType VARCHAR(50),
    OperatingSystem VARCHAR(100),
    Browser VARCHAR(100),
    IPAddress VARCHAR(45),
    FirstSeenDate DATE,
    LastSeenDate DATE,
    TrustedDeviceFlag VARCHAR(5),
    RiskScore INT,
    PRIMARY KEY (DeviceID)
)  ENGINE=INNODB;

/* ============================================================
   05. DIM CALENDAR
   ============================================================ */

CREATE TABLE DimCalendar (
    `Date` DATE NOT NULL,
    `Year` INT,
    `Quarter` INT,
    `Month` INT,
    MonthName VARCHAR(20),
    `Week` INT,
    `Day` INT,
    `Weekday` INT,
    IsWeekend VARCHAR(5),
    FinancialYear VARCHAR(20),
    PRIMARY KEY (`Date`)
)  ENGINE=INNODB;

/* ============================================================
   06. DIM CUSTOMER
   ============================================================ */

CREATE TABLE DimCustomer (
    CustomerID VARCHAR(30) NOT NULL,
    BankID INT NOT NULL,
    CustomerName VARCHAR(150) NOT NULL,
    Gender VARCHAR(20),
    Age INT,
    CustomerSegment VARCHAR(50),
    Occupation VARCHAR(100),
    AnnualIncome DECIMAL(18 , 2 ),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(50),
    AccountOpeningDate DATE,
    CustomerRiskScore INT,
    RiskCategory VARCHAR(50),
    PRIMARY KEY (CustomerID),
    CONSTRAINT FK_DimCustomer_Bank FOREIGN KEY (BankID)
        REFERENCES DimBank (BankID)
)  ENGINE=INNODB;

/* ============================================================
   07. DIM BRANCH
   ============================================================ */

CREATE TABLE DimBranch (
    BranchID VARCHAR(30) NOT NULL,
    BankID INT NOT NULL,
    BranchName VARCHAR(150),
    City VARCHAR(100),
    State VARCHAR(100),
    Region VARCHAR(50),
    RiskRating VARCHAR(50),
    PRIMARY KEY (BranchID),
    CONSTRAINT FK_DimBranch_Bank FOREIGN KEY (BankID)
        REFERENCES DimBank (BankID)
)  ENGINE=INNODB;

/* ============================================================
   08. DIM ATM
   ============================================================ */

CREATE TABLE DimATM (
    ATMID VARCHAR(30) NOT NULL,
    BranchID VARCHAR(30) NOT NULL,
    BankID INT NOT NULL,
    ATMType VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    RiskRating VARCHAR(50),
    PRIMARY KEY (ATMID),
    CONSTRAINT FK_DimATM_Branch FOREIGN KEY (BranchID)
        REFERENCES DimBranch (BranchID),
    CONSTRAINT FK_DimATM_Bank FOREIGN KEY (BankID)
        REFERENCES DimBank (BankID)
)  ENGINE=INNODB;

/* ============================================================
   09. DIM EMPLOYEE
   ============================================================ */

CREATE TABLE DimEmployee (
    EmployeeID VARCHAR(30) NOT NULL,
    BankID INT NOT NULL,
    EmployeeName VARCHAR(150) NOT NULL,
    Department VARCHAR(100),
    Role VARCHAR(100),
    ExperienceYears INT,
    CasesAssigned INT,
    CasesResolved INT,
    PRIMARY KEY (EmployeeID),
    CONSTRAINT FK_DimEmployee_Bank FOREIGN KEY (BankID)
        REFERENCES DimBank (BankID)
)  ENGINE=INNODB;

/* ============================================================
   10. DIM ACCOUNT
   ============================================================ */

CREATE TABLE DimAccount (
    AccountID VARCHAR(30) NOT NULL,
    CustomerID VARCHAR(30) NOT NULL,
    BankID INT NOT NULL,
    AccountType VARCHAR(50),
    Balance DECIMAL(18 , 2 ),
    AccountStatus VARCHAR(50),
    OpeningDate DATE,
    BranchID VARCHAR(30),
    AverageMonthlyBalance DECIMAL(18 , 2 ),
    TransactionLimit DECIMAL(18 , 2 ),
    InternationalEnabled VARCHAR(5),
    PRIMARY KEY (AccountID),
    CONSTRAINT FK_DimAccount_Customer FOREIGN KEY (CustomerID)
        REFERENCES DimCustomer (CustomerID),
    CONSTRAINT FK_DimAccount_Bank FOREIGN KEY (BankID)
        REFERENCES DimBank (BankID),
    CONSTRAINT FK_DimAccount_Branch FOREIGN KEY (BranchID)
        REFERENCES DimBranch (BranchID)
)  ENGINE=INNODB;

/* ============================================================
   11. DIM CARD
   ============================================================ */

CREATE TABLE DimCard (
    CardID VARCHAR(30) NOT NULL,
    CustomerID VARCHAR(30) NOT NULL,
    AccountID VARCHAR(30) NOT NULL,
    BankID INT NOT NULL,
    CardType VARCHAR(50),
    CardNetwork VARCHAR(50),
    CardCategory VARCHAR(50),
    IssueDate DATE,
    ExpiryDate DATE,
    CardStatus VARCHAR(50),
    BlockedFlag VARCHAR(5),
    BlockReason VARCHAR(150),
    PRIMARY KEY (CardID),
    CONSTRAINT FK_DimCard_Customer FOREIGN KEY (CustomerID)
        REFERENCES DimCustomer (CustomerID),
    CONSTRAINT FK_DimCard_Account FOREIGN KEY (AccountID)
        REFERENCES DimAccount (AccountID),
    CONSTRAINT FK_DimCard_Bank FOREIGN KEY (BankID)
        REFERENCES DimBank (BankID)
)  ENGINE=INNODB;

/* ============================================================
   12. FACT TRANSACTIONS
   ============================================================ */

CREATE TABLE FactTransactions (
    TransactionID VARCHAR(40) NOT NULL,
    TransactionDate DATE NOT NULL,
    TransactionTime TIME,
    BankID INT NOT NULL,
    CustomerID VARCHAR(30) NOT NULL,
    AccountID VARCHAR(30) NOT NULL,
    CardID VARCHAR(30) NOT NULL,
    BranchID VARCHAR(30) NOT NULL,
    ATMID VARCHAR(30) NOT NULL,
    MerchantID VARCHAR(30) NOT NULL,
    DeviceID VARCHAR(30) NOT NULL,
    LocationID VARCHAR(20) NOT NULL,
    TransactionType VARCHAR(50),
    Channel VARCHAR(50),
    Currency VARCHAR(10),
    Amount DECIMAL(18 , 2 ),
    FraudFlag VARCHAR(5),
    FraudType VARCHAR(100),
    FraudRiskScore INT,
    TransactionStatus VARCHAR(50),
    IsInternational VARCHAR(5),
    IsHighValue VARCHAR(5),
    IsRoundAmount VARCHAR(5),
    IsVelocityAlert VARCHAR(5),
    IsLocationMismatch VARCHAR(5),
    PreviousTransactionAmount DECIMAL(18 , 2 ),
    TransactionsLast24H INT,
    AmountLast24H DECIMAL(18 , 2 ),
    CustomerAvgTransactionAmount DECIMAL(18 , 2 ),
    CreatedDate DATE,
    PRIMARY KEY (TransactionID),
    CONSTRAINT FK_FactTransactions_Date FOREIGN KEY (TransactionDate)
        REFERENCES DimCalendar (`Date`),
    CONSTRAINT FK_FactTransactions_Bank FOREIGN KEY (BankID)
        REFERENCES DimBank (BankID),
    CONSTRAINT FK_FactTransactions_Customer FOREIGN KEY (CustomerID)
        REFERENCES DimCustomer (CustomerID),
    CONSTRAINT FK_FactTransactions_Account FOREIGN KEY (AccountID)
        REFERENCES DimAccount (AccountID),
    CONSTRAINT FK_FactTransactions_Card FOREIGN KEY (CardID)
        REFERENCES DimCard (CardID),
    CONSTRAINT FK_FactTransactions_Branch FOREIGN KEY (BranchID)
        REFERENCES DimBranch (BranchID),
    CONSTRAINT FK_FactTransactions_ATM FOREIGN KEY (ATMID)
        REFERENCES DimATM (ATMID),
    CONSTRAINT FK_FactTransactions_Merchant FOREIGN KEY (MerchantID)
        REFERENCES DimMerchant (MerchantID),
    CONSTRAINT FK_FactTransactions_Device FOREIGN KEY (DeviceID)
        REFERENCES DimDevice (DeviceID),
    CONSTRAINT FK_FactTransactions_Location FOREIGN KEY (LocationID)
        REFERENCES DimLocation (LocationID)
)  ENGINE=INNODB;

/* ============================================================
   13. FACT FRAUD CASES
   ============================================================ */

CREATE TABLE FactFraudCases (
    FraudCaseID VARCHAR(40) NOT NULL,
    TransactionID VARCHAR(40) NOT NULL,
    CustomerID VARCHAR(30) NOT NULL,
    FraudType VARCHAR(100),
    FraudStatus VARCHAR(50),
    RiskLevel VARCHAR(50),
    InvestigatorID VARCHAR(30),
    InvestigationDate DATE,
    ResolutionDate DATE,
    InvestigationDurationHours DECIMAL(10 , 2 ),
    FraudAmount DECIMAL(18 , 2 ),
    RecoveredAmount DECIMAL(18 , 2 ),
    FinancialLoss DECIMAL(18 , 2 ),
    CasePriority VARCHAR(50),
    InvestigationResult VARCHAR(255),
    PRIMARY KEY (FraudCaseID),
    UNIQUE (TransactionID),
    CONSTRAINT FK_FactFraudCases_Transaction FOREIGN KEY (TransactionID)
        REFERENCES FactTransactions (TransactionID),
    CONSTRAINT FK_FactFraudCases_Customer FOREIGN KEY (CustomerID)
        REFERENCES DimCustomer (CustomerID),
    CONSTRAINT FK_FactFraudCases_Employee FOREIGN KEY (InvestigatorID)
        REFERENCES DimEmployee (EmployeeID)
)  ENGINE=INNODB;

ALTER TABLE FactFraudCases
MODIFY InvestigationDurationHours DECIMAL(10,2) NULL;

/* ============================================================
   14. FACT LOGINS
   ============================================================ */

CREATE TABLE FactLogins (
    LoginID VARCHAR(40) NOT NULL,
    CustomerID VARCHAR(30) NOT NULL,
    DeviceID VARCHAR(30) NOT NULL,
    LoginTime DATETIME,
    IPAddress VARCHAR(45),
    Browser VARCHAR(100),
    OperatingSystem VARCHAR(100),
    LocationID VARCHAR(20) NOT NULL,
    LoginStatus VARCHAR(50),
    FailureReason VARCHAR(150),
    IsNewDevice VARCHAR(5),
    IsNewLocation VARCHAR(5),
    IsSuspicious VARCHAR(5),
    RiskScore INT,
    FailedAttempts24H INT,
    PRIMARY KEY (LoginID),
    CONSTRAINT FK_FactLogins_Customer FOREIGN KEY (CustomerID)
        REFERENCES DimCustomer (CustomerID),
    CONSTRAINT FK_FactLogins_Device FOREIGN KEY (DeviceID)
        REFERENCES DimDevice (DeviceID),
    CONSTRAINT FK_FactLogins_Location FOREIGN KEY (LocationID)
        REFERENCES DimLocation (LocationID)
)  ENGINE=INNODB;
