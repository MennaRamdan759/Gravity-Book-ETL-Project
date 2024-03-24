----------script source Dim BOOK SSIS------------
SELECT b.book_id 
      ,b.[title]
      ,b.[isbn13]
      ,b.[num_pages]
      ,b.[publication_date]
      ,l.[language_id]
      ,l.[language_code]
      ,l.[language_name],p.[publisher_id]
      ,p.[publisher_name]
  FROM [gravity_books].[dbo].[book] as b
 left join [gravity_books].[dbo].[book_language] as l on b.language_id = l.language_id

  left join [gravity_books].[dbo].[publisher] as p on b.[publisher_id] = p.[publisher_id]

  ----------script source Dim_Address SSIS------------
  select a.address_id,a.city,a.street_name,a.street_number,c.country_id,c.country_name
from address as a left join country as c on a.country_id=c.country_id


 ----------script source get_last_load_date SSIS------------
 SELECT [Last_load_date]
      
  FROM [DWH_Gravity_books].[dbo].[Meta_Control_Fact_orderline_load]
  where SalesOrderline = 'order_date'


  ----------script source get_last_load_order_id SSIS------------
  SELECT last_load_orderdate_BK
      
  FROM [DWH_Gravity_books].[dbo].[Meta_Control_Fact_orderline_load]
  where SalesOrderline = 'order_date'


    ----------script source Fact_Orderline Data flow SSIS------------

  select co.customer_id,co.order_id,co.shipping_method_id,l.line_id,l.book_id,l.price,co.order_date
from cust_order as co inner join order_line as l on co.order_id = l.order_id
 where l.line_id >?  --user variable last_load_order_id
  and co.order_date >= ?      --user variable last_load_date
  and co.order_date < ?       --System variable startTime

  
    ----------script source Fact_OrderHistory Data flow SSIS------------
	
 select oh.history_id,oh.status_id,h.*
from All_History h, order_history oh
where h.order_id= oh.order_id


----------script source Dim customer_address SSIS------------

Select ca.address_id ,ca.customer_id,a.status_id,a.address_status
from customer_address ca , address_status a
where ca.status_id = a.status_id


    ----------script source Fact_OrderHistory Data flow SSIS------------
select oh.history_id,oh.status_id,Received_at,Pending_Dleivery_at,Dleivery_in_progress_at,
from All_History h, order_history oh
where h.order_id= oh.order_id

