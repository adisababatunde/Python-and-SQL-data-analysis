--select columns
select distinct region from dbo.avocado;

---filter data
select * from dbo.avocado
where region = 'Orlando'

---group data
select region,
AVG(AveragePrice) as price from dbo.avocado
group by region

---conditional column
--select AVG(AveragePrice) from avocado
With region_group as (select region,
AVG(AveragePrice) as price from dbo.avocado
group by region)

select region,
case when price > 1.40 then 'expensive' else 'inexpensive' end as price_category
from region_group

--- unpivot data and top results
--select top 10 type, [Small Bags], [Large Bags] from avocado

select type, category, amount
from avocado
unpivot(
amount for category in ([Small Bags], [Large Bags])
) as unpivot_demo

---merge

--select top 10 * from holidays
select
Date, 
AveragePrice,
case when Holiday is null then 'normal' else Holiday end as Category 
from
(select a.Date,b.Holiday, a.AveragePrice from avocado a
left join holidays b on a.Date = b.Date) tab1

---average price on normal and holiday

select Category, AVG(AveragePrice) as price  from
(select
Date, 
AveragePrice,
case when Holiday is null then 'normal' else Holiday end as Category 
from
(select a.Date,b.Holiday, a.AveragePrice from avocado a
left join holidays b on a.Date = b.Date) tab1)tab2
group by Category
order by 2 desc

---select the average price
select AVG(AveragePrice) from avocado

---select the average price *2
select AVG(AveragePrice)*2.0 from avocado

---select the average price *2 where year= 2018
select AVG(AveragePrice)*2.0 from avocado
where year = 2018

--- dates and prices based on the above condition
select Date, 
AveragePrice 
from avocado
where AveragePrice>=(select AVG(AveragePrice)*2.0 from avocado where year = 2018)




