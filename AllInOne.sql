--
CREATE TABLE Customer (
	CustNo int IDENTITY (100, 1) NOT NULL Primary key,
	custFname nvarchar (20) NOT NULL ,
	custLname nvarchar (8) NOT NULL ,
	IDNo int NOT NULL  Unique,
	Tel varchar (12) NOT NULL  
                Check(Tel like '09[0-9][0-9] [0-9][0-9][0-9][0-9][0-9][0-9]' or Tel like '[1-9]%-[0-9][0-9][0-9][0-9][0-9][0-9]'),
	Address nvarchar (40) NULL ,
	Email varchar (30) NULL Check(Email  like '[a-z]%@[a-z]%.[a-z]%'),
	Photo varbinary (MAX) NULL 
)
GO
Insert into customer values(N'Nguy?n van',N'Lành',200016858,'511-613059',N' 39 Núi Thành ÐN','lanhnv@yahoo.com',NULL)
Insert into customer values(N'Lê van',N'Du?n',200016737,'8-613059',N' 81 Hùng Vuong ÐN','lvduan@dng.vnn.vn',NULL)
Insert into customer values(N'Bùi qu?c',N'Nam',200016859,'65-613059',N' 39 Tr?n Cao Vân ÐN','bqnam@yahoo.com',NULL)
Insert into customer values(N'Nguy?n Khánh',N'Toàn',200017858,'0913 572231',N' 3 Lý T? Tr?ng ÐN','khanhtoan@dsp.com',NULL)
Insert into customer values(N'Mai quê´',N'Lô?',200176543,'0913 657869',N'41 Hoa`ng Hoa Tha´m','maiquelo@dng.vnn.vn',NULL)
Go
CREATE TABLE Account (
	CustNo int NOT NULL  FOREIGN KEY references Customer(CustNo),
	AccNo int IDENTITY (1000, 1) NOT NULL CONSTRAINT PK_Account PRIMARY KEY,
	Balance decimal(18, 2) NOT NULL Default(0) Check(Balance>=0),
	Password varchar(14),
	LastAccess datetime NOT NULL default(getdate()) 
) 
Go
Insert into Account values(       101, 1000,'defaultPW',getDate())
Insert into Account values(       102, 2000,'defaultPW',getDate())
Insert into Account values(       103, 3000,'defaultPW',getDate())
Insert into Account values(       100, 1000,'defaultPW',getDate())
Insert into Account values(       104,  500,'defaultPW',getDate())
Insert into Account values(       101,     0,'defaultPW',getDate())
Go


SELECT TOP 1 Balance 
FROM Account 
WHERE AccNo = 1001
;


CREATE TABLE TransLog (
	AccNo int NOT NULL  Foreign Key References Account(AccNo),
	LogID int IDENTITY (1, 1) NOT NULL  Primary Key,
	Time datetime NOT NULL Default(GetDate()),
	Task VarChar (10) NOT NULL  Check(Task in ('Withdraw','Deposit','Transfer','System','Register','Change PW')),
	Amount decimal(18, 2) NOT NULL default(0) ,
	PostBalance decimal(18, 2) NOT NULL 
) 
GO
Insert into TransLog values(      1001,getDate(),'Deposit',5000.00,      5000)
Insert into TransLog values(      1001,getDate(),'Withdraw ',500.00,      4500)
Insert into TransLog values(      1001,getDate(),'Deposit',1000.00,      5000)
Insert into TransLog values(      1002,getDate(),'Deposit',500.00,       500)
Insert into TransLog values(      1003,getDate(),'Withdraw',200.00,       700)
Insert into TransLog values(      1001,getDate(),'Withdraw',1500.00,      2000)
Insert into TransLog values(      1001,getDate(),'Deposit',400.00,      1600)
Insert into TransLog values(      1001,getDate(),'Deposit',100.00,      1500)
Go

CREATE PROCEDURE InterestCalc
	@accNo int = NULL,
	@from DateTime= Null,
	@to DateTime = Null,
	@result decimal(18,2) OUTPUT
 AS
If (@accNo is Null) or (@from is Null) or (@to is Null) 
   Begin
     RAISERROR('Wrong Arguments',10,1) 
     Return -1
   End
Select @result=min(PostBalance) from TransLog
   where AccNo=@accNo and Time between @from and @to
If @result is NULL  Return -1
Set @result=@result*2.0/1000
Update Account set Balance=Balance+@result, LastAccess=GetDate() where AccNo=@AccNo
Go

CREATE TRIGGER UpdateTrig ON Account FOR UPDATE 
AS
Declare @acc  as int, @Bal as decimal(18,2),@PostBal as decimal(18,2),@Task as Varchar(10)
if update(Balance)
   Begin
	Select @acc=o.AccNo,@Bal=o.Balance,@PostBal=n.Balance  from deleted o inner join inserted n  on o.accno=n.accno
       if @Bal> @PostBal  Set @Task='WithDraw'
       else if @Bal < @PostBal   Set @Task='Deposit'
       Insert into TransLog values(@acc,GetDate(),@Task,abs(@Bal - @PostBal),@PostBal)
       update Account set lastAccess=getDate()
    End

Go
CREATE PROCEDURE sp_newAccount 
	@accNo int OUT,
	@custNo int,
	@initBal decimal(18, 0),
	@pw varchar(8)
AS 
Insert into Account(CustNo,Balance,Password,LastAccess) values(@custNo,@initBal,@pw,getdate())
if @@rowcount=1
	set @accNo=@@identity
else set @accNo=-1

GO
CREATE PROCEDURE sp_newCustomer
	@CustNo int out,
	@custFNam nvarchar(10),
	@custLNam nvarchar(20),
	@IDno int,
	@Tel varchar(20),
	@address nvarchar(30),
	@email varchar(20)
AS 
Insert into Customer(CustFname,CustLName,IDNo,Tel,Address,Email) 
   values(@custFNam,@custLNam,@IDNo,@Tel,@address,@email)
if @@rowcount=1
	set @CustNo=@@identity
else  set @CustNo=-1
Go
CREATE PROCEDURE sp_Login
	@accNo int ,
	@pw varchar(14),
	@bal decimal(18, 0) out
AS 
Select @bal=Balance from Account where accNo=@accNo and Password=@pw
if @@rowcount<>1 set @bal=-1.0
Go
CREATE TRIGGER logAccount ON Account FOR UPDATE 
AS
Declare @acc  as int, @Bal as decimal(18,2),@PosBal as decimal(18,2),@Task as Varchar(10)
if update(Balance)
Begin
Declare updateCursor Cursor For
       Select o.AccNo,o.Balance,n.Balance  from deleted o inner join inserted n  on o.accno=n.accno
  Open updateCursor
  Fetch next from updateCursor into @acc,@Bal, @PosBal
   While (@@fetch_status = 0) begin
       if @Bal> @PosBal  Set @Task='WithDraw'
       else if @Bal < @PosBal   Set @Task='Deposit'
       else Set @Task='System'
       Insert into TransLog values(@acc,GetDate(),@Task,abs(@Bal - @PosBal),@PosBal)
       fetch next from updateCursor into @acc,@Bal, @PosBal
   End
  Close updateCursor
  Deallocate updateCursor
End
Go

DROP TABLE TransLog;
------------------------------------------------------------------
CREATE PROCEDURE sp_withdraw
    @accNo INT,
    @amount FLOAT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @currentBalance FLOAT;
    
   
    SELECT @currentBalance = Balance FROM Account WHERE AccNo = @accNo;
    
   
    IF @currentBalance < @amount
    BEGIN
        PRINT 'Insufficient funds';
        RETURN;
    END

  
    UPDATE Account SET Balance = Balance - @amount WHERE AccNo = @accNo;

 
    INSERT INTO Translog (accNo, time, task, amount, PostBalance)
    VALUES (@accNo, GETDATE(), 'Withdraw', -@amount, @currentBalance - @amount);
END

CREATE PROCEDURE sp_transfer
    @senderAccNo INT,
    @receiverAccNo INT,
    @amount FLOAT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @senderBalance FLOAT, @receiverBalance FLOAT;

   
    SELECT @senderBalance = Balance FROM Account WHERE AccNo = @senderAccNo;
    IF @senderBalance IS NULL
    BEGIN
        PRINT 'Sender account does not exist';
        RETURN;
    END
    IF @senderBalance < @amount
    BEGIN
        PRINT 'Insufficient funds for transfer';
        RETURN;
    END

    
    SELECT @receiverBalance = Balance FROM Account WHERE AccNo = @receiverAccNo;
    IF @receiverBalance IS NULL
    BEGIN
        PRINT 'Receiver account does not exist';
        RETURN;
    END

 
    UPDATE Account SET Balance = Balance - @amount WHERE AccNo = @senderAccNo;

  
    UPDATE Account SET Balance = Balance + @amount WHERE AccNo = @receiverAccNo;

    SELECT @senderBalance = Balance FROM Account WHERE AccNo = @senderAccNo;
    SELECT @receiverBalance = Balance FROM Account WHERE AccNo = @receiverAccNo;


    INSERT INTO Translog (accNo, time, task, amount, PostBalance)
    VALUES (@senderAccNo, GETDATE(), 'Transfer', -@amount, @senderBalance);


    INSERT INTO Translog (accNo, time, task, amount, PostBalance)
    VALUES (@receiverAccNo, GETDATE(), 'Deposit', @amount, @receiverBalance);
END
drop procedure sp_transfer