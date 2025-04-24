use dominoes;
-- 1.calculate total revenue generated from pizza sales
select sum(order_details.quantity*pizzas.price) as tot_revenue
from order_details join pizzas  on pizzas.pizza_id = order_details.pizza_id;

-- 2.identifying most common pizza size odered
SELECT 
    p.size, COUNT(od.quantity) AS pizza_quant
FROM
    pizzas p
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY p.size
order by pizza_quant desc;
-- 3.Identify top 5 most ordered pizza types along with their quantity
SELECT 
    pt.name, COUNT(od.quantity) AS order_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY order_quantity DESC
LIMIT 5;

-- 4.Identify no. of orders placed  on hour basis in  a day
SELECT 
    HOUR(time), COUNT(order_id)
FROM
    dominoes.orders
GROUP BY HOUR(time);
select pizza_types.name as name, pizzas.price
from pizza_types join pizzas on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by pizzas.price desc;

-- 5.Identify the no. of pizzas ordered per day and then the average no of pizzas ordered per day
SELECT 
    orders.date, SUM(order_details.quantity)
FROM
    orders
        JOIN
    order_details ON order_details.order_id = orders.order_id
GROUP BY orders.date;

SELECT 
    round(AVG(quantity), 0 ) as avg_per_day
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) as quantity
    FROM
        orders
    JOIN order_details ON order_details.order_id = orders.order_id
    GROUP BY orders.date) a;
    
-- 6. Determine the top 3 most ordered pizza type(by name and category) on the basis of revenue generated
select pizza_types.name, sum(order_details.quantity * pizzas.price) as sum
from order_details join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.name
order by sum desc
limit 3;


select pizza_types.category, sum(order_details.quantity * pizzas.price) as sum
from order_details join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.category
order by sum desc
;
