# Framework

All global action always return 4 consecutive values by the specified order.

1 -> Error (true/false) according if the GA returned error or not.

2 -> Error Code that allows you to search for the place in the code were the error is coming from.

3 -> Error description.

4 -> Result from the GA in case of no error or error equals false.

In case of any error the GA will insert information in the table framework_Logs

------

### Available Global Actions



#### framework_log_event

Logs an event/error into the framework_Logs local table. Only keeps seven days of logs.

Entry parameters: 

- LogEvent (string)
- LogDescription (string)
- LogErrorMessage (string)
- LogSeverity (integer) (1 -> Usage) (2 -> Usage Error) (3 -> Fatal Error)

Returns: Nothing



#### framework_create_parameter (01X0000)

Creates a parameter with a specified value and type in the local database framework_Parameters.

Entry parameters:

- Parameter (string) (key)
- Type (string) (Possible values: string / numeric / password)
- Value (string)
- Description (string)

Returns: Returns on the value position true or false if correctly created. On error check the error position and the error message.



framework_decrypt_value

framework_encrypt_value

framework_generate_random_password

framework_get_os_name

framework_get_parameter

framework_set_parameter

framework_validate_email

woocommerce_execute_api_request

wordpress_execute_api_request

