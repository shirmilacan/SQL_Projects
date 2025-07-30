--=======================================================
--Author	 : Shirmila Hewapathirana
--Create date: 2024-10-30
--Description: Project Phase One
--=======================================================

Create database MCT_SQL_Project
use MCT_SQL_Project

--1.UserLogins
create table UserLogins
(
	UserLoginID smallint not null,
	UserLogin nvarchar(30) not null, -- altered to answer question 6 (original char(15))
	UserPassword varchar(20) not null,
	constraint PK_UL_UserLoginID primary key (UserLoginID)
)
select * from UserLogins
insert into UserLogins values
(1, 'John Doe', 'dasds12'),
(2, 'Jane Doe', 'dshjk'),
(3, 'Bob Smith', 'ewrwer'),
(4, 'Anna Jones', '	adasda123'),
(5, 'Dave', 'adas@456'),
(6, 'Sean Cooper', 'kKas@456'),
(7, 'Jude Anderson', 'Lkas@456')



--2.UserSecurityQuestions
create table UserSecurityQuestions
(
	UserSecurityQuestionID tinyint not null,
	UserSecurityQuestion varchar(50) not null,
	constraint PK_USQ_UserSecurityQuestionID primary key (UserSecurityQuestionID)
)

insert into UserSecurityQuestions values
(1, 'What is your mother’s maiden name?'), 
(2, 'What was the name of your first pet?'),
(3, 'What was the name of your elementary school?'),
(4, 'What was your first car?'),
(5, 'What is your favorite movie?')


--3.AccountType
create table AccountType
(
	AccountTypeID tinyint not null,
	AccountTypeDescription varchar(30) not null,
	constraint PK_AT_AccountTypeID primary key (AccountTypeID)
)

insert into AccountType values
(1, 'Savings'),
(2, 'Checking'),
(3, 'Business'),
(4, 'Student'),
(5, 'Visitor')


--4.SavingsInterestRates
create table SavingsInterestRates
(
	InterestSavingsRateID tinyint not null,
	InterestRateValue numeric(9,9) not null,
	InterestRateDescription varchar(50) not null,
	constraint PK_SIR_InterestSavingsRateID primary key (InterestSavingsRateID)
)

insert into SavingsInterestRates values
(1, 0.01, 'Standard Savings Rate'),
(2, 0.02, 'Premium Savings Rate'),
(3, 0.03, 'Student Savings Rate'),
(4, 0.04, 'Business Savings Rate'),
(5, 0.05, 'Visitor Savings Rate')


--5.AccountStatusType
create table AccountStatusType
(
	AccountStatusTypeID tinyint not null,
	AccountStatusDescription varchar(30) not null,
	constraint PK_AST_AccountStatusTypeID primary key (AccountStatusTypeID)
)

insert into AccountStatusType values
(1, 'Active'),
(2, 'closed'),
(3, 'Suspended'),
(4, 'Pending'),
(5, 'Dormant')


--6.TransactionType
create table TransactionType
(
	TransactionTypeID tinyint not null,
	TransactionTypeName char(10) not null,
	TransactionTypeDescription varchar(50) not null,
	TransactionFeeAmount smallmoney not null
	constraint PK_TT_TransactionTypeID primary key (TransactionTypeID)
)

insert into TransactionType values
(1, 'Deposit','Cash deposit', 0.05),
(2, 'Withdrawal', 'Cash withdrawal', 0.10),
(3, 'Transfer', 'Money transfer', 0.0),
(4, 'Payment', 'Bill payment',0.05),
(5, 'Fee', 'Service fee', 0.10)


--7.LoginErrorLog
create table LoginErrorLog
(
	ErrorLogID int not null,
	ErrorTime datetime not null,
	FailedTransactionXML xml not null,
	constraint PK_LEL_ErrorLogID primary key (ErrorLogID)
)
select * from LoginErrorLog
insert into LoginErrorLog values
(1, '2024-01-01 15:00:00', '<Error><Reason>Invalid Password</Reason></Error>'),
(2, '2024-01-02 16:00:00', '<Error><Reason>Account Locked</Reason></Error>'),
(3, '2024-01-03 17:00:00', '<Error><Reason>Invalid Username</Reason></Error>'),
(4, '2024-01-04 18:00:00', '<Error><Reason>Multiple Failed Attempts</Reason></Error>'),
(5, '2024-01-05 19:00:00', '<Error><Reason>Invalid Password</Reason></Error>'),
(6, '2024-11-11 21:00:00', '<Error><Reason>Invalid Username</Reason></Error>'),
(7, '2024-11-12 07:00:00', '<Error><Reason>Multiple Failed Attempts</Reason></Error>'),
(8, '2024-11-12 08:00:00', '<Error><Reason>Account Locked</Reason></Error>')


--8.Employee
create table Employee
(
	EmployeeID int not null,
	EmployeeFirstName varchar(25) not null,
	EmployeeMiddleInitial char(1),
	EmployeeLastName varchar(25),
	EmployeeIsManager bit,
	constraint PK_E_EmployeeID primary key (EmployeeID)
)

insert into Employee values
(1, 'Shirmila', 'T', 'Hewapathirana', 1),
(2, 'Rahul', '','Gurnani', 0), 
(3, 'Warren', 'S', 'Kenedy', 1),
(4, 'Mark', 'F', 'Browns', 0),
(5, 'Dilip', 'V', 'Mendes', 1)


--9.FailedTransactionErrorType
create table FailedTransactionErrorType
(
	FailedTransactionErrorTypeID tinyint not null,
	FailedTransactionDescription varchar(50),
	constraint PK_FTET_FailedTransactionErrorTypeID primary key(FailedTransactionErrorTypeID)
)
insert into FailedTransactionErrorType values
(1, 'InvalidPassword'),
(2, 'UserNotFound'),
(3, 'AccountLocked'),
(4, 'Multiple Failed Attempts'),
(5, 'Timeout')


--10.FailedTransactionLog
create table FailedTransactionLog
(
	FailedTransactionID int not null,
	FailedTransactionErrorTypeID tinyint not null,
	FailedTransactionErrorTime datetime not null,
	FailedTransactionXML xml not null,
	constraint PK_FTL_FailedTransactionID primary key (FailedTransactionID),
	constraint FK_FTL_FTET_FailedTransactionErrorTypeID foreign key (FailedTransactionErrorTypeID) references FailedTransactionErrorType(FailedTransactionErrorTypeID)
)

insert into FailedTransactionLog values
(1, 1, '2024-01-01 10:00:00', '<Transaction><ID>1</ID><ErrorType>InvalidPassword</ErrorType><Message>Incorrect password entered.</Message></Transaction>'),
(2, 2, '2024-01-02 11:00:00', '<Transaction><ID>2</ID><ErrorType>UserNotFound</ErrorType><Message>User ID does not exist in the system.</Message></Transaction>'),
(3, 3, '2024-01-03 12:00:00', '<Transaction><ID>3</ID><ErrorType>AccountLocked</ErrorType><Message>User account has been locked due to multiple failed attempts.</Message></Transaction>'),
(4, 1, '2024-01-04 13:00:00', '<Transaction><ID>4</ID><ErrorType>InvalidPassword</ErrorType><Message>Incorrect password entered.</Message></Transaction>'),
(5, 4, '2024-01-05 14:00:00', '<Transaction><ID>5</ID><ErrorType>Timeout</ErrorType><Message>Transaction timed out.</Message></Transaction>');


--11.Account
create table Account
(
	AccountID int not null,
	CurrentBalance int not null,
	AccountTypeID tinyint not null,
	AccountStatusTypeID tinyint not null,
	InterestSavingsRateID tinyint not null,
	constraint PK_A_AccountID primary key (AccountID),
	constraint FK_A_AT_AccountTypeID foreign key (AccountTypeID) references AccountType(AccountTypeID),
	constraint FK_A_AST_AccountStatusTypeID foreign key (AccountStatusTypeID) references AccountStatusType(AccountStatusTypeID),
	constraint FK_A_SIR_InterestSavingsRateID foreign key (InterestSavingsRateID) references SavingsInterestRates(InterestSavingsRateID)
)

insert into Account values
(1, 5000.00, 1, 1, 1),
(2, 10000.00, 2, 1, 2),
(3, 15000.00, 1, 1, 1),
(4, 2000.00, 2, 1, 2),
(5, 3000.00, 5, 1, 5),
(6, 300, 1, 2, 1),
(7, 446, 2, 1, 2),
(8, 50.00, 1, 1, 1),
(9, 10.00, 1, 1, 1),
(10, 55, 1, 1, 1),
(11, 25, 2, 1, 2)


--12.Customer
create table Customer
(
	CustomerID int not null,
	CustomerAddress1 varchar(30) not null,
	CustomerAddress2 varchar(30), 
	CustomerFirstName varchar(30) not null,
	CustomerMiddleInitial char(1),
	CustomerLastName varchar(30),
	City varchar(20) not null,
	State char(2) not null,
	ZipCode char(10) not null,
	EmailAddress varchar(40) not null,
	HomePhone char(10),
	CellPhone char(10),
	WorkPPhone char(10),
	SSN char(9), 
	UserLoginID smallint,
	Constraint PK_C_CustomerID primary key (CustomerID),
	constraint FK_C_TL_UserLoginID foreign key (UserLoginID) references UserLogins(UserLoginID)
)

Insert into Customer values
(1, '123 Main St', '', 'John', 'A', 'Doe', 'Toronto', 'ON', 'M1J 1V3', 'john.d@gmail.com', '5551234567', '5559876543', '5557654321', '123456789', 1),
(2, '456 Elm St', 'Apt 2', 'Jane', 'B', 'Doe', 'Toronto', 'ON', 'M1H 2F3', 'jane.d@gmail.com', '5551234568', '5559876542', '5557654322', '234567890', 2),
(3, '789 Oak St', '', 'Bob', 'C', 'Smith', 'Scarborough', 'ON', 'M1K 4C2', 'bob.s@gmail.com', '5551234569', '5559876541', '5557654323', '345678901', 3),
(4, '101 Maple St', 'Suite 3', 'Anna', 'D', 'Jones', 'Markaham', 'ON', 'H10 3S3', 'anna.j@gmail.com', '5551234570', '5559876540', '5557654324', '456789012', 4),
(5, '202 Pine St', '', 'Dave', 'E', 'Miller', 'Ajex', 'ON', 'Q2d 1F5', 'dave.m@gmail.com', '5551234571', '5559876539', '5557654325', '567890123', 5)
(6, '123 Main St', 'unit 5', 'Sean', 'A', 'Cooper', 'Edmonton', 'AB', 'Q1J 1V3', 'Sean.c@gmail.com', '6651234567', '6659876543', '6657654321', '663456789', 6),
(7, '456 Oak St', '', 'Jude', '', 'Anderson', 'Vancouver', 'BC', 'V6B 2M9', 'jade.a@gmail.com', '7751234568', '7759876542', '7757654322', '774567890', 7)


--13.CustomerAccount
create table CustomerAccount
(
	AccountID int not null,
	CustomerID int not null,
	constraint FK_CA_A_AccountID foreign key (AccountID) references Account(AccountID),
	constraint FK_CA_C_CustomerID foreign key (CustomerID) references Customer(CustomerID)
)

insert into CustomerAccount values
(1,1),
(2,1),
(3,2),
(4,2),
(5,5),
(6,6),
(7,7),
(8,1),
(9,1),
(10,3),
(11,4)


--14.UserSecurityAnswers
create table UserSecurityAnswers
(
	UserLoginID smallint not null,
	UserSecurityAnswer varchar(25) not null,
	UserSecurityQuestionID tinyint not null,
	constraint PK_USA_UserLoginID primary key (UserLoginID),
	constraint FK_USA_UL_UserLoginID foreign key (UserLoginID) references UserLogins(UserLoginID),
	constraint FK_USA_USQ_UserSecurityQuestionID foreign key (UserSecurityQuestionID) references UserSecurityQuestions(UserSecurityQuestionID)
)

insert into UserSecurityAnswers values
(1, 'Salvador', 1),
(2, 'Billy', 2),
(3, 'Lincoln', 3),
(4, 'Civic', 4),
(5, 'Brave Hearts', 5)


--15.TransactionLog
create table TransactionLog
(
	TransactionID int not null,
	TransactionDate datetime not null,
	TransactionTypeID tinyint not null,
	TransactionAmount money not null,
	NewBalance money not null,
	AccountID int not null,
	CustomerID int not null,
	EmployeeID int not null,
	UserLoginID smallint not null,
	constraint PK_TL_TransactionID primary key (TransactionID),
	constraint FK_TL_TT_TransactionTypeID foreign key (TransactionTypeID) references TransactionType (TransactionTypeID),
	constraint FK_TL_A_AccountID foreign key (AccountID) references Account (AccountID),
	constraint FK_TL_C_CustomerID foreign key (CustomerID) references Customer (CustomerID),
	constraint FK_TL_E_EmployeeID foreign key (EmployeeID) references Employee (EmployeeID),
	constraint FK_TL_UL_UserLoginID foreign key (UserLoginID) references UserLogins (UserLoginID)
)

Insert into TransactionLog values
(1, '2024-01-01 10:00:00', 1, 0.05, 500.05, 1, 1, 1, 1),
(2, '2024-02-01 11:00:00', 2, 0.10, 899.90, 2, 2, 2, 2),
(3, '2024-03-01 12:00:00', 3, 0.00, 500.00, 3, 3, 3, 3),
(4, '2024-04-01 13:00:00', 4, 0.05, 715.00, 4, 4, 4, 4),
(5, '2024-05-01 14:00:00', 5, 0.10, 2997.50, 5, 5, 5, 5)

--16.OverDraftLog
create table OverDraftLog
(
	AccountID int not null,
	OverDraftDate datetime not null,
	OverDraftAmount money not null,
	OverDraftTransactionXML xml not null,
	constraint PK_ODL_AccountID primary key (AccountID),
	constraint FK_ODL_A_AccountID foreign key (AccountID) references Account(AccountID)
)
select * from OverDraftLog
insert into OverDraftLog values
(1, '2024-01-01 10:00:00', 100.00, '<Transaction><ID>1</ID><Status>Overdraft</Status><Amount>100.00</Amount><Reason>Withdrawal</Reason></Transaction>'), 
(2, '2024-02-01 11:00:00', 200.00, '<Transaction><ID>2</ID><Status>Overdraft</Status><Amount>200.00</Amount><Reason>Withdrawal</Reason></Transaction>'), 
(3, '2024-03-01 12:00:00', 300.00, '<Transaction><ID>3</ID><Status>Overdraft</Status><Amount>300.00</Amount><Reason>Transfer</Reason></Transaction>'), 
(4, '2024-04-01 13:00:00', 400.00, '<Transaction><ID>4</ID><Status>Overdraft</Status><Amount>400.00</Amount><Reason>Payment</Reason></Transaction>'), 
(5, '2024-04-01 14:00:00', 500.00, '<Transaction><ID>5</ID><Status>Overdraft</Status><Amount>500.00</Amount><Reason>Fee</Reason></Transaction>'),
(6, '2024-04-01 14:00:00', 600.00, '<Transaction><ID>6</ID><Status>Overdraft</Status><Amount>600.00</Amount><Reason>Fee</Reason></Transaction>'),
(7, '2024-05-01 14:00:00', 700.00, '<Transaction><ID>7</ID><Status>Overdraft</Status><Amount>700.00</Amount><Reason>Fee</Reason></Transaction>');


--17.LoginAccount
create table LoginAccount
(
	UserLoginID smallint not null,
	AccountID int not null,
	constraint FK_LA_UL_UserLoginID foreign key (UserLoginID) references UserLogins(UserLoginID),
	constraint FK_LA_A_AccountID foreign key (AccountID) references Account(AccountID)
)

insert into LoginAccount values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5)

go

--Table list
select * from [dbo].[UserLogins]
select * from [dbo].[UserSecurityQuestions]
select * from [dbo].[AccountType]
select * from [dbo].[SavingsInterestRates]
select * from [dbo].[AccountStatusType]
select * from [dbo].[TransactionType]
select * from [dbo].[LoginErrorLog]
select * from [dbo].[Employee]
select * from [dbo].[FailedTransactionErrorType]
select * from [dbo].[FailedTransactionLog]
select * from [dbo].[Account]
select * from [dbo].[Customer]
select * from [dbo].[CustomerAccount]
select * from [dbo].[UserSecurityAnswers]
select * from [dbo].[TransactionLog]
select * from [dbo].[OverDraftLog]
select * from [dbo].[LoginAccount]
go


--=======================================================
--Description: Project Phase One
--=======================================================

--1.Create a view to get all customers with checking accounts from ON province.
/*
--notes
--I added an alias to 'State' to change it to show as 'Province in the output
--Tables I used in my query
select * from Customer
select * from CustomerAccount
select * from Account
select * from AccountType

*/

--Solution
Create view AllCustomersWithCheckingAcView
as
select 
		c.CustomerFirstName + ' ' + c.CustomerLastName [Customer Full Name], 
		c.State [Province],  --added an alias to change State into Province in the result
		at.AccountTypeDescription [Account Type]
from Customer c
left join CustomerAccount ca
on c.CustomerID = ca.CustomerID
left join Account a
on ca.AccountID = a.AccountID
left join AccountType at
on a.AccountID = at.AccountTypeID
where 
	c.State = 'ON' and 
	AccountTypeDescription= 'checking' 

select * from AllCustomersWithCheckingAcView

go


--2.Create a view to get all customers with a total account balance (including interest rate) greater than 5000
/*
--notes
--Tables I used in my query
select * from Customer
select * from CustomerAccount
select * from Account
select * from SavingsInterestRates
*/

--Solution
Create view CustomersWithTotalBalanceAbove5k
as
Select	c.CustomerFirstName + ' ' + c.CustomerLastName [Customer Full Name], 
		a.AccountID,
		sum(a.CurrentBalance * (1+sir.InterestRateValue)) as [TotalAccountBalance] 
from Customer c
left join CustomerAccount ac
on c.CustomerID = ac.CustomerID
left join Account a
on ac.AccountID = a.AccountID 
left join SavingsInterestRates sir
on a.InterestSavingsRateID = sir.InterestSavingsRateID
Group by 
		c.CustomerFirstName, 
		c.CustomerLastName, 
		a.AccountID
having sum(a.CurrentBalance * (1+sir.InterestRateValue)) > 5000

select * from CustomersWithTotalBalanceAbove5k

go


--3.Create a view to get counts of checking and savings accounts by customer.
/*
--notes
--Tables I used in my query
select * from [dbo].[Customer]
select * from [dbo].[CustomerAccount]
select * from [dbo].[Account]
select * from [dbo].[AccountType]
*/


--Solution
--In this solution result for each customer will be returened in one row

create view CheckingandSavingAcbyCustomerView1 as
select
	c.CustomerFirstName + ' ' + c.CustomerLastName [CustomerFullName],
	--if a customer is having multiple saving or checking accounts get 
	--the total of accounts by saving/checking
    sum(case 
			when at.AccountTypeDescription = 'Checking' 
			then 1 else 0 end) as [CheckingAccounts],
    sum(case 
			when at.AccountTypeDescription = 'Savings' 
			then 1 else 0 end) as [SavingsAccounts]
from Customer c
left join CustomerAccount ca 
on c.CustomerID = ca.CustomerID
left join Account a 
on ca.AccountID = a.AccountID
left join AccountType at 
on a.AccountTypeID = at.AccountTypeID
group by	c.CustomerFirstName, 
			c.CustomerLastName

select * from CheckingandSavingAcbyCustomerView1


--4.Create a view to get any particular user’s login and password using AccountId
/*
--notes
--Tables I used in my query
select * from Customer
select * from CustomerAccount
select * from UserLogins
*/

--Solution
create view UserLoginCredentialsbyAcIDView
as
select 
	ca.AccountID,	
	c.CustomerFirstName + ' ' + c.CustomerLastName [CustomerFullName], 
	ul.UserLogin, 
	ul.UserPassword
from Customer c
left join CustomerAccount ca
on c.CustomerID = ca.CustomerID
left join UserLogins ul
on c.UserLoginID = ul.UserLoginID
where AccountID = 3		-- Call user credentials of AccountID = 3

select * from UserLoginCredentialsbyAcIDView
go


--5.Create a view to get all customers’ overdraft amounts
/*
--notes
--Tables I used in my query
select * from Customer
select * from CustomerAccount
select * from OverDraftLog
*/

--Solution
create view AllCustomersODAmountsView1
as
select	
		c.CustomerFirstName + ' ' + c.CustomerLastName [CustomerFullName],
		sum(odl.OverDraftAmount) as TotalOverDraftAmount
from Customer c
left join CustomerAccount ca
on c.CustomerID = ca.CustomerID
right join OverDraftLog odl			--used right join to exclusively get data in overdraftLog table which is also possible with 'inner join'/'join' here 
on ca.AccountID = odl.AccountID
group by 
		c.CustomerFirstName, 
		c.CustomerLastName 

select * from AllCustomersODAmountsView1


--6.Create a stored procedure to add “User_” as a prefix to everyone’s login (username). 
/*
--notes
select * from UserLogins
--First check whether the UserLogin starts as 'User_', if not update such UserLogins
--sql statement
update UserLogins
set UserLogin = 'User_' + UserLogin
where UserLogin not like 'User_%'

*/

--Solution

create proc sp_AddPrefixToUserLogin
as
begin
	if(select count(*) from UserLogins where UserLogin not like 'User_%') > 0
	begin
	    update UserLogins
		set UserLogin = 'User_' + UserLogin
		where UserLogin not like 'User_%'	--with this condition, I can avoid updating UserLogins whic already starts as 'User_' 
		print 'UserLogins successfully updated with prefix "User_"'
	end
	else
	begin
		print 'No records updated. Allrecords already have the prefix "User_" .'
	end
end

exec sp_AddPrefixToUserLogin

/*
--foot note 
--for testing the code

--remove 'User_' prefix from Userlogin

update UserLogins
set UserLogin = substring(UserLogin,6, LEN(UserLogin))
where UserLogin like 'User_%'

select * from UserLogins
*/


--7.Create a stored procedure that accepts AccountId as a parameter and returns the customer’s full name.
/*
--notes
select * from CustomerAccount
select * from Customer
--Input - AccountID
--Output - CustomerFullName
--sql statement
select * from Customer c		 
left join CustomerAccount ca 
on c.CustomerID = ca.CustomerID
*/

--Solution code
Create proc sp_FullNamebyAccountID 
		(@AcID int, 
		 @fullname nvarchar(100) out)
as
begin
--check whether the specified AccountID exists in CustomerAccout table
if (@AcID in (select AccountID from CustomerAccount)) 
--if available get the full name
	begin
	select @fullname = c.customerfirstname + ' ' + c.CustomerMiddleInitial +' ' + c.customerlastname 
	from Customer c
	left join CustomerAccount ca
	on c.CustomerID = ca.CustomerID 
	where ca.AccountID = @AcId
	print 'Full name for Account ID '+ convert(varchar(10), @AcID)+ ' is:'
	end
	--if AccountID is not exist in AccountTable, print message 
	else
	begin
	print 'There is no customer withis acount ID: ' + convert(varchar(10), @AcID)
	end
end

--Execute the SP to check the result for the required AccountID
--Check AccountID 5 to see the results
declare @output nvarchar(100)
exec sp_FullNamebyAccountID 5, @output output
print @output	--used print as question asks for a message to display. If I used select, output will be showed in a table

--Check AccountID 101 to see the results
declare @output nvarchar(100)
exec sp_FullNamebyAccountID 101, @output output
print @output

 
--8.Create a stored procedure that returns error logs inserted in the last 24 hours. [Advanced] (optional)
/*
--notes
select * from LoginErrorLog		
--print getdate()-1
*/

--Solution - 1
create proc sp_LoginErrorLog @hrsAgo int 
as
begin
select * from LoginErrorLog
where ErrorTime >= DATEADD(HOUR, -@hrsAgo, GETDATE())
end

exec sp_LoginErrorLog @hrsAgo=24

/*
Add records to LoginErrorLog
select * from LoginErrorLog			
Update ID before insert
insert into loginErrorLog values (11, getdate(), '<Error><Reason>Account Locked</Reason></Error>' )
*/


--9.Create a stored procedure that takes a deposit as a parameter and updates the CurrentBalance value for 
--  that particular account.(optional)
/*
--notes
select * from Account
--sql code to update balance
update Account
set CurrentBalance = CurrentBalance +100	--@AmtDeposited / input
where AccountID = 1							--@AccountID	/ input
*/
--Solution
create proc sp_UpdateCurrentBalanceDep 
	@AccountID int,				 
	@AmtDeposited money,		 
	@UpdatedBalance money out	 
as
begin
	--check whether the entered account number is avalid pne
	if exists (select * from Account where AccountID = @AccountID)  
		begin
		--updating current balance for the acount
		update Account
		set CurrentBalance = CurrentBalance + @AmtDeposited	
		where AccountID = @AccountID
		--retrieve the updated balance(or new balance)
			begin
			select @UpdatedBalance = CurrentBalance from Account 
			where AccountID = @AccountID 
			--message to print
			print 'Deposit successful. Your updated current balance in account No. ' + convert(nvarchar(20), @AccountID) +
  				   ' is $.' + convert(nvarchar(20), @UpdatedBalance)
			end
		end
	else
		--if the entered account number is an invalid one, then inform the customer with the below message
		begin
		print 'Invalid acount number. ' + 'Please check the account number: ' + convert(nvarchar(20), @AccountID) +' and try again.'
		end
end
go

--sample for valid account number
declare @output1 money
exec sp_UpdateCurrentBalanceDep 11,125, @output1 output
go

--sample for invalid account number
declare @output2 money
exec sp_UpdateCurrentBalanceDep 12,150, @output2 output
go


--10.Create a stored procedure that takes a withdrawal amount as a parameter and updates  (optional)
/*
--notes
select * from Account

--sql code to update balance
update Account
set CurrentBalance = CurrentBalance - 100
where AccountID = 1					
*/

--Solution
create proc sp_UpdateCurrentBalanceForWithdrawal 
    @AccountID INT,						
    @AmtWithdraw money,					
	@UpdatedCurrentBalance money out	
as
begin
    --Check if the account exists
    if exists (select * from Account where AccountID = @AccountID)
		begin
		--Check if the account has sufficient balance
		if (select CurrentBalance from Account where AccountID = @AccountID)>=@AmtWithdraw
			begin
			-- Update the CurrentBalance value for the specified account
			update Account
			set CurrentBalance = CurrentBalance - @AmtWithdraw
			where AccountID = @AccountID;
			--retrieve current balance to show it in below message
			select @UpdatedCurrentBalance = CurrentBalance from Account
			where AccountID = @AccountID
			print 'Withdrawal successful. Your updated current balance is: $.'+ convert(nvarchar(20), @UpdatedCurrentBalance)
			end
		else
			begin
			--retrieve current balance to show it in below message
			select @UpdatedCurrentBalance = CurrentBalance from Account
			where AccountID = @AccountID
			print 'Whthdrawal failed due to insufficent funds. Your current balance in account No. '+ 
				   convert(nvarchar(20), @AccountID) +' is: $.'+ convert(nvarchar(20), @UpdatedCurrentBalance)
			end
		end
		else
			begin
				print 'Invalid acount number. ' + 'Please check the account number: ' + convert(nvarchar(20), @AccountID) +' and try again.'
			end
end
go

--sample for valid account number
declare @outputW1 money
exec sp_UpdateCurrentBalanceForWithdrawal 2,100, @outputW1 output
go

--sample for invalid account number
declare @outputW2 money
exec sp_UpdateCurrentBalanceForWithdrawal 12,150, @outputW2 output
go

--sample for insufficent funds
declare @outputW3 money
exec sp_UpdateCurrentBalanceForWithdrawal 11,15000, @outputW3 output
go

select * from AccountType


--Table list
select * from [dbo].[UserLogins]
select * from [dbo].[UserSecurityQuestions]
select * from [dbo].[AccountType]
select * from [dbo].[SavingsInterestRates]
select * from [dbo].[AccountStatusType]
select * from [dbo].[TransactionType]
select * from [dbo].[LoginErrorLog]
select * from [dbo].[Employee]
select * from [dbo].[FailedTransactionErrorType]
select * from [dbo].[FailedTransactionLog]
select * from [dbo].[Account]
select * from [dbo].[Customer]
select * from [dbo].[CustomerAccount]
select * from [dbo].[UserSecurityAnswers]
select * from [dbo].[TransactionLog]
select * from [dbo].[OverDraftLog]
select * from [dbo].[LoginAccount]
go