-- use group_concat to get product set of each date
select 
sell_date, 
count( DISTINCT product ) as num_sold ,
GROUP_CONCAT( DISTINCT product order by product ASC ) as products
FROM Activities 
GROUP BY sell_date 
order by sell_date ASC;
