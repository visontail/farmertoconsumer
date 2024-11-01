## Authorization

### Login

```js
POST /auth/login

body: {
    email: string;
    password: string;
}

response: {
    token: string;
}
```

### Register

```js
POST /auth/register

body: {
    email: string;
    name: string;
    password: string;
    confirmPassword: string;
}

response: {
    id: number;
}
```

### Profile


```js
@Authenticated

GET /auth/profile

response: {
    id: number;
    email: string;
    name: string;
}
```

## User

### Get user by ID

```js
GET /users/{id}

response: {
    id: number;
    email: string;
    name: string;
    producerData:? {
        id: number;
        description: string;
    }
}
```

### Get user's producer data

```js
GET /users/{id}/producerData

response: {
    id: number;
    description: string;
}
```

## User upgrade requests

### Get all user upgrade request

```js
@Authenticated
@Admin

GET /user-upgrade-requests

queryParams: {
    filter:? "with_response" | "no_response" | "approved" | "declined"
    userId:? number;
    skip:? number;
    take:? number;
}

response: {
    requests: {
        id: number;
        user: {
            id: number;
            name: string;
            email: string;
        },
        description: string;
        approved: boolean?;
    }[];
    total: number;
    current: number;
}
```

### Get one user upgrade request

```js
@Authenticated
@Admin
@Self

GET /user-upgrade-requests/{id}

response: {
    id: number;
    user: {
        id: number;
        name: string;
        email: string;
    },
    description: string;
    approved: boolean?;
}
```

### Submit user upgrade request
```js
@Authenticated
@NoRequestYet

POST /user-upgrade-requests

body: {
    description: string;
}

response: {
    id: number;
}
```

### Response to user upgrade request
```js
@Authenticated
@Admin
POST /user-upgrade-requests/{id}/response

body: {
    approve: boolean;
}

response: {}
```

## Products

```js
GET /products

queryParams: {
    search:? string;
    categoryId:? number;
    producerId:? number;
    skip:? number;
    take:? number;
}

response: {
    products: {
        id: number;
        name: string;
        producer: {
            id: number;
            name: string;
            email: string;
        }
        category: {
            id: number;
            name: string;
        };
        quantity: number;
        quantityUnit: {
            id: number;
            name: string;
        }
        price: number;
    }[],
    total: number;
    current: number;
}
```

### Get product by ID

```js
GET /product/{id}

response: {
    id: number;
    name: string;
    producer: {
        id: number;
        name: string;
        email: string;
    }
    category: {
        id: number;
        name: string;
    };
    quantity: number;
    quantityUnit: {
        id: number;
        name: string;
    }
    price: number;
}
```

### Create product

```js
@Authenticated
@Producer

POST /products

body: {
    name: string;
    categoryId: number;
    quantity: number;
    quantityUnitId: number;
    price: number;
}

response: {
    id: number;
}
```

### Update product

```js
@Authenticated
@Owner

PATCH /products/{id}

body: {
    name:? string;
    categoryId:? number;
    quantity:? number;
    quantityUnitId:? number;
    price:? number;
}

response: {
    id: number;
    name: string;
    category: {
        id: number;
        name: string;
    };
    quantity: number;
    quantityUnit: {
        id: number;
        name: string;
    }
    price: number;
}
```

## Orders

### Get user's orders

```js
@Authenticated
@Self

GET /orders

body: {
    userId: number;
    userType: "consumer" | "producer";
    filter:? "with_response" | "no_response" | "approved" | "declined"
    skip:? number;
    take:? number;
}

response: {
    orders: {
        id: number;
        user: {
            id: number;
            name: string;
            email: string;
        };
        product: {
            id: number;
            name: string;
            user: {
                id: number;
                name: string;
                email: string;
            };
            category: {
                id: number;
                name: string;
            };
            quantity: number;
            quantityUnit: {
                id: number;
                name: string;
            }
            price: number;
        };
        quantity: number;
        quantityUnit: {
            id: number;
            name: string;
        }
        price: number;
        approved: boolean?;
    }[],
    total: number;
    current: number;
}
```

### Get order by id

```js
@Authenticated
@Owner
GET /orders/{id}

response: {
    id: number;
    user: {
        id: number;
        name: string;
        email: string;
    };
    product: {
        id: number;
        name: string;
        user: {
            id: number;
            name: string;
            email: string;
        };
        category: {
            id: number;
            name: string;
        };
        quantity: number;
        quantityUnit: {
            id: number;
            name: string;
        }
        price: number;
    };
    quantity: number;
    quantityUnit: {
        id: number;
        name: string;
    };
    price: number;
    approved: boolean?;
}
```

### Give response to order

```js
@Authenticated
@Producer
@ProductOwner

POST /orders/{id}/response

body: {
    approve: boolean;
}

response: {}
```
