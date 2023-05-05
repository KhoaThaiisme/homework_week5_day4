SELECT *
FROM orders

DROP FUNCTION replace_shipping_status;
CREATE OR REPLACE FUNCTION replace_shipping_status(
	_order_id INTEGER,
	_shipping_method VARCHAR(20)
)
RETURNS VARCHAR AS 
$$
	BEGIN 
	UPDATE orders
	SET shipping_method = _shipping_method
	WHERE order_id = _order_id;
	RETURN _shipping_method;
	END;
$$
LANGUAGE plpgsql;

SELECT replace_shipping_status(2, 'expidite')

SELECT * 
FROM orders

--========================================================--

CREATE OR REPLACE PROCEDURE update_return_date(
	_order_id INTEGER,
	_customer_id INTEGER
)
AS $$
	BEGIN 
		UPDATE orders
		SET order_shipped = current_date
		WHERE order_id = _order_id AND customer_id = _customer_id;
		COMMIT;
	END;
$$
LANGUAGE plpgsql;

CALL update_return_date(3, 2);

SELECT *
FROM orders