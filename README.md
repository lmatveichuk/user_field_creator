# Custom Field Management Example

## Program Logic

This application is designed to provide a dynamic and flexible approach to managing custom fields, tailored to meet the administrative and user-specific needs within the system. The operational logic of the program is structured as follows:

1. **Admin User Creation:** 
   - Administrators can add new users, either via the Rails console or through direct manipulation of the database.

2. **Adding Custom Fields:**
   - Admins have the ability to add custom fields to the system, encompassing a variety of types. For certain field types, the admin can also specify options for responses. This is done through a POST request. Example request format is provided below the description.

3. **Assigning Custom Fields to Users:**
   - Custom fields are assigned to selected users with initial empty values. This process is designed to be flexible, allowing admins to effectively manage which users are required to provide additional information. This is achieved through a POST request.

4. **User Updates:**
   - Users are empowered to update their assigned custom fields by setting values that adhere to established validations, ensuring the integrity and relevance of the data collected. This is also done through a POST request. Example request format is provided below the description.

## Implementation Details

The system's architecture is centered around enhancing flexibility and scalability in managing custom fields and their values:

- **Custom Fields Entity:**
  - This entity represents the diverse custom fields defined within the system, detailing their types and, for some, specifying the choices available for responses.

- **Custom Field Values Table:**
  - A critical link between users and their respective custom fields, this table stores the values set by users for each field. It plays a key role in maintaining the relationship between users and the custom information they provide.

- **Choice Options and Results:**
  - For fields requiring selection from predefined options (either single or multiple choices), I utilize the `jsonb` data type. This choice enables storing complex structures for both the options presented to users and their selections, facilitating advanced querying of this structured data.

This structure provides a basic implementation for managing custom fields, allowing for different data types and scalability. It's a simplified version without extra validations, tests, or additional gems.

## Examples of Requests

### User Updates Custom Field Values

```bash
curl --location --request PUT 'http://localhost:3000/api/v1/users/1' \
--header 'Content-Type: application/json' \
--data '{
    "custom_fields": {
        "1": {"value": "Test"}
    }
}'
```

### Admin Creates Custom Field 

```bash
curl --location 'http://localhost:3000/api/v1/custom_fields' \
--header 'Content-Type: application/json' \
--data '{"custom_field": {"name": "New field", "field_type": "select", "options": {"choices": ["a"] }}}'
```
