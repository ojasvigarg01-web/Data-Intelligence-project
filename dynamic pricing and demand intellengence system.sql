use pricing_system;
create table products (
product_id int primary key,
product_name varchar(50),
base_price int,
current_price int
);
create table sales (
sale_id int primary key auto_increment,
product_id int,
quantity int,
sale_date date,
foreign key (product_id) references products(product_id)
);
insert into products values
(1,'Laptop',50000,50000),
(2,'Mobile',20000,20000),
(3,'Headphones',2000,2000);
insert into sales (product_id, quantity, sale_date) values
(1,5,'2024-01-01'),
(1,10,'2024-01-02'),
(2,2,'2024-01-01'),
(3,20,'2024-01-01');
select product_id, sum(quantity) as total_demand
from sales
group by product_id;
update products p
join (
    select product_id, sum(quantity) as total_demand
    from sales
    group by product_id
) s
on p.product_id = s.product_id

set p.current_price =
case
    when s.total_demand > 10 then p.base_price * 1.1
    when s.total_demand < 5 then p.base_price * 0.9
    else p.base_price
end;

SET SQL_SAFE_UPDATES = 0;
select * from products;
select p.product_name, sum(s.quantity) as demand
from products p
join sales s on p.product_id = s.product_id
group by p.product_name
order by demand desc;
