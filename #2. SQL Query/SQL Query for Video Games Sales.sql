create database video_games_sales_project;
show databases;
use video_games_sales_project;

create table vgsales(
sr_no int,
Name varchar(500),
Platform varchar(200), 
Year year,
Genre varchar(200),
Publisher varchar(200),
NA_Sales float,
EU_Sales float,
JP_Sales float,
Other_Sales float,
Global_Sales float
);
select * from vgsales;
desc vgsales;

show global variables like 'local_infile';
set global local_infile = 'on';
show global variables like 'local_infile';

load data local infile 'E:/Datasets for project/Video game sales/vgsales.csv' into table vgsales 
fields terminated by ','
lines terminated by '\n'
ignore 1 lines ;

select * from vgsales;
select count(*) from vgsales;


-- -------------------------------------------------------------------------------------------
# Changing data types of Columns
desc vgsales;
alter table vgsales modify global_sales float;
alter table vgsales modify `Rank` int;
alter table vgsales modify `Name` varchar(500);
alter table vgsales modify Platform varchar(500);
alter table vgsales modify `Year` year;
alter table vgsales modify Genre varchar(500);
alter table vgsales modify Publisher varchar(500);
alter table vgsales modify NA_Sales float;
alter table vgsales modify Eu_sales float;
alter table vgsales modify jp_sales float;
alter table vgsales modify other_sales float;
alter table vgsales modify global_sales float;
-- -------------------------------------------------------------------------------------------
# Checking for null Values
select * from vgsales 
where 
publisher is null or
na_sales is null or
eu_sales is null or
jp_sales is null or
other_sales is null or
global_Sales is null ;

show columns from vgsales;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q. Finding Any missing in Total_Sales from dataset
select * from vgsales;
select * from 
(select global_sales, na_sales + jp_sales + eu_sales + other_sales,
abs( ((global_sales)- (na_sales + jp_sales + eu_sales + other_sales))) as missing_sales
from vgsales ) as first_table
where  missing_sales >1;

-- ANS : Since output has no values , there is no null values in Total Sales.

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q. Dropping Rank Column 
alter table vgsales drop column `Rank`;
desc vgsales;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

### Updating Platform Names for better understanding

-- GB Game Box
update vgsales
set platform = 'Game Box'
where platform = 'GB';

-- DS (Dual Screen)
update vgsales
set platform = 'Dual Screen'
where platform = 'DS';

-- X360 (XBOX 360)
update vgsales
set platform = 'XBox 360'
where platform = 'X360';

-- PS3 (Playstation 3)
update vgsales
set platform = 'Playstation 3'
where platform = 'PS3';

-- PS2 (Palystation 2)
update vgsales
set platform = 'Palystation 2'
where platform = 'PS2';

-- SNES (Super Nintendo Entertainment System)
update vgsales
set platform = 'Super Nintendo Entertainment System'
where platform = 'SNES';

-- GBA (Game Boy Advance)
update vgsales
set platform = 'Game Boy Advance'
where platform = 'GBA';

-- 3DS (Nintendo 3DS)
update vgsales
set platform = 'Nintendo 3DS'
where platform = '3DS';

-- PS4 PlayStation 4
update vgsales
set platform = 'Playstation 4'
where platform = 'PS4';

-- N64 Nintendo 64
update vgsales
set platform = 'Nintendo 64'
where platform = 'N64';

-- PS play station
update vgsales
set platform = 'Playstation'
where platform = 'PS';

-- XB XBox
update vgsales
set platform = 'XBox'
where platform = 'XB';
 
-- 2600 Atari 2600
update vgsales
set platform = 'Atari 2600'
where platform = '2600';

-- PSP Play station portable
update vgsales
set platform = 'Playstation Portable'
where platform = 'PSP';

-- XOne XBox One
update vgsales
set platform = 'XBox One'
where platform = 'XOne';

-- GC Game Cube
update vgsales
set platform = 'Game Cube'
where platform = 'GC';

-- WiiU Nintendo Wii U  
update vgsales
set platform = 'Nintendo Wii U'
where platform = 'WiiU';

-- DC Dreamcast console
update vgsales
set platform = 'Dreamcast'
where platform = 'DC';

-- PSV Sony Playstation Vita
update vgsales
set platform = 'Playstation Vita'
where platform = 'PSV';

-- SAT Sega Video Game
update vgsales
set platform = 'Sega Video Game'
where platform = 'SAT';

-- SCD Sega CD 
update vgsales
set platform = 'Sega CD'
where platform = 'SCD';

-- WS Wonderswan
update vgsales
set platform = 'Wonder Swan'
where platform = 'WS';

-- NG Neo Geo
update vgsales
set platform = 'Neo Geo'
where platform = 'NG';

-- TG16 TurboGrafx-16
update vgsales
set platform = 'Turbo Grafx-16'
where platform = 'TG16';

-- GG Game Gear
update vgsales
set platform = 'Game Gear'
where platform = 'GG';

-- Nintendo Entertainment System (NES)
update vgsales
set platform = 'Nintendo Entertainment System '
where platform = 'NES';

-- -------------------------------------------------------------------------------------------

# Q1. Total Video Games present in dataset
select count(Name) as Total_Games from vgsales;

-- ANS = 16327

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q2. Different Video Gaming Platform
select Platform from vgsales;
select count(distinct(Platform)) as Different_Platforms from vgsales;

-- ANS = 31

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q3. Video Game Relase year time line 
select distinct(Year) as TimeLine  from vgsales order by year asc;
select concat('Starting Year= ',min(year) , ',' ,
' Ending Year= ',max(year), "," ,
' Total Years= ',count(distinct(`year`))) as Total_Years 
from vgsales;

select count(distinct(year)) as all_years from vgsales ;

-- ANS = 1980 to 2020

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q4. Different Genre of Video Games
select  distinct(Genre) as Different_Genre from vgsales;
select  count(distinct(Genre)) as Total_Genre_Counts from vgsales;

-- ANS = Total 12 Genre

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q5. Total Different Publisher of Video Games
select count(distinct(Publisher)) as Total_Different_Publisher from vgsales;
select distinct(Publisher) from vgsales;

-- ANS = 577 Video Games Publisher

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q6. Total Sales of Video Games in Different Regions
select 
	round(sum(NA_Sales)) as Total_Sales_North_America, 
	round(sum(EU_Sales)) as Total_Sales_Europe,
    round(sum(JP_Sales)) as Total_Sales_Japan,
    round(sum(Other_Sales)) as Total_Sales_Other_Region,
    round(sum(Global_Sales)) as Total_Sales_Globally
from vgsales;

-- ANS = 4333 Million Sales in North America
-- ANS = 2409 Million sales in Europe
-- ANS = 1284 Million Sales in Japan
-- ANS = 789 Million Sales in Other Regions
-- ANS = 8820 Million Sales Globally
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q7. Platform with most number of games
select Platform ,count(name) as Total_Games 
from vgsales 
group by platform 
order by Total_Games desc;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q8. Total Game Released by Year
select Year ,count(name) as Total_Games_Released 
from vgsales
group by year 
order by Total_Games_Released desc;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q9. Games Releases by Genre
select Genre, count(name) Total_Game_Released_by_Genre 
from vgsales 
group by Genre 
order by count(name)desc;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q10. Top 20 Publisher that Released Most Games
select Publisher, count(name) as Total_Games_Released_By_Publisher 
from vgsales 
group by publisher 
order by count(name) desc limit 20;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q11. Total Sales of Video Games by Publisher who has more than 5 million sales
select Publisher,
	round(sum(Na_Sales) ,2) as North_America_Sales,
	round(sum(EU_Sales) , 2) as Europe_Sales,
	round(sum(JP_Sales) ,2) as Japan_Sales,
	round(sum(other_Sales) ,2) as Other_Sales, 
	round(sum(global_sales) ,2) as Global_Sales
from vgsales  
where global_sales >= 5
group by Publisher 
order by Global_Sales desc;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q12. Which Country Sales is Highest in Every Year 
select year,
round(sum(na_sales)) as North_America_Sales,
round(sum(eu_sales))as Europe_Sales,
round(sum(jp_sales))as Japan_Sales,
round(sum(other_sales)) as Other_Sales,
round(sum(global_sales))as Global_Sales
from vgsales 
group by year
order by global_Sales desc;

create view sales_description
as
	select year,
	round(sum(na_sales),2) as North_America_Sales,
	round(sum(eu_sales),2) as Europe_Sales,
	round(sum(jp_sales),2) as Japan_Sales,
	round(sum(other_sales),2) as Other_Sales,
    round(sum(global_sales),2) as Global_Sales,
	case 
		when 
			round(sum(na_sales),2) > round(sum(eu_sales),2) and
			round(sum(na_sales),2) > round(sum(jp_sales)) and 
			round(sum(na_sales),2) > round(sum(other_sales),2) 
		then 'America has most number of Sales'
		when 
			round(sum(other_sales),2) > round(sum(eu_sales),2) and 
			round(sum(other_sales),2) > round(sum(na_sales),2) and 
			round(sum(other_sales),2) > round(sum(jp_sales),2) 
		then 'Other Region has most number of Sales'
		when 
			round(sum(jp_sales),2) > round(sum(eu_sales),2) and
			round(sum(jp_sales),2) > round(sum(na_sales),2) and 
			round(sum(jp_sales),2) > round(sum(other_sales),2)  
		then 'Japan has most number of Sales'
		when 
			round(sum(eu_sales),2) > round(sum(jp_sales),2)  and
			round(sum(eu_sales),2) > round(sum(na_sales),2) and 
			round(sum(eu_sales),2) > round(sum(other_sales),2)
		then 'Europe has most number of Sales'
	else 'No Sales is Done'
	end as sales
	from vgsales 
	group by year
	order by global_Sales desc; 
    
select * from sales_description;
select sales,count(sales) from sales_description group by sales;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Q13. Games Released of Every Genre each Year
select year, Genre, count(genre) as count from vgsales 
group by genre, year
order by year asc;

select Genre,count(genre) from vgsales group by genre;

# Top 20 Most Sales of Games 
delimiter $$
	create procedure Top_20_most_sold_games()
	begin
		select row_number() over() as `Row_Number`,publisher,year, global_sales 
		from vgsales
		order by global_Sales desc 
		limit 20;
	end $$
delimiter ;

call Top_20_most_sold_games();

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------


