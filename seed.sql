DROP DATABASE IF EXISTS bepractice;
CREATE DATABASE bepractice;

\c bepractive;

CREATE TABLE users (
  "id" SERIAL PRIMARY KEY,
  "fname" VARCHAR NOT NULL,
  "lname" VARCHAR NOT NULL,
  "email" VARCHAR UNIQUE NOT NULL,
  "uid" VARCHAR NOT NULL,
  "address" VARCHAR NOT NULL,
  "city" VARCHAR NOT NULL,
  "state" VARCHAR NOT NULL,
  "zipcode" VARCHAR NOT NULL,
  "seller" BOOLEAN NOT NULL,
  "createdat" TIMESTAMP NOT NULL DEFAULT NOW(),
  "updatedat" TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE stores (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR NOT NULL,
  "user_id" INT NOT NULL,
  "address" VARCHAR NOT NULL,
  "city" VARCHAR NOT NULL,
  "state" VARCHAR NOT NULL,
  "zipcode" VARCHAR NOT NULL,
  "images" JSON,
  "createdat" TIMESTAMP NOT NULL DEFAULT NOW(),
  "updatedat" TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (user_id)
      REFERENCES users(id)
      ON DELETE CASCADE
);

CREATE TABlE products (
  "id" SERIAL PRIMARY KEY,
  "store_id" INT NOT NULL,
  "name" VARCHAR NOT NULL,
  "price" MONEY NOT NULL,
  "category" VARCHAR NOT NULL,
  "description" VARCHAR,
  "url" VARCHAR NOT NULL,
  "stock" JSON NOT NULL,
  "createdat" TIMESTAMP NOT NULL DEFAULT NOW(),
  "updatedat" TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (store_id)
      REFERENCES stores(id)
      ON DELETE CASCADE
);

CREATE TABLE orders (
  "id" SERIAL PRIMARY KEY,
  "customer" INT NOT NULL,
  "total" MONEY NOT NULL,
  "status" VARCHAR NOT NULL,
  "createdat" TIMESTAMP NOT NULL DEFAULT NOW(),
  "updatedat" TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (customer)
      REFERENCES users(id)
      ON DELETE CASCADE
);

CREATE TABLE orderline (
  "id" SERIAL PRIMARY KEY,
  "order_id" INT NOT NULL,
  "product_id" INT NOT NULL,
  "store_id" INT NOT NULL,
  "size" VARCHAR,
  "quantity" INT NOT NULL,
  "createdat" TIMESTAMP NOT NULL DEFAULT NOW(),
  "updatedat" TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (order_id)
      REFERENCES orders(id)
      ON DELETE CASCADE,
    FOREIGN KEY (product_id)
      REFERENCES products(id)
      ON DELETE CASCADE,
    FOREIGN KEY (store_id)
      REFERENCES stores(id)
      ON DELETE CASCADE
);

INSERT INTO users (fname, lname, email, uid, address, city, state, zipcode, seller) VALUES
('Carlos', 'Martinez', 'cm@gmail.com', 'littt', '212 Throop ave', 'Brooklyn', 'New York', '11206', true),
('John', 'Chevy', 'jc@gmail.com', 'littt', '212 Throop ave', 'Brooklyn', 'New York', '11206', false),
('Rigo', 'Berto', 'rb@gmail.com', 'littt', '1 Menahan ave', 'Brooklyn', 'New York', '11345', true),
('Inoue', 'Kizaru', '1@gmail.com', 'littt', '1 Driggs ave', 'Brooklyn', 'New York', '11345', false),
('Anne', 'Diaz', '2@gmail.com', 'littt', '1 Menahan ave', 'Brooklyn', 'New York', '11345', true),
('Ash', 'Ketchum', '3@gmail.com', 'littt', '1 Menahan ave', 'Pallet Town', 'Kanto', '11345', false),
('Joe', 'Cruz', '4@gmail.com', 'littt', '1 Menahan ave', 'Queens', 'New York', '11345', true);

INSERT INTO stores (name, user_id, address, city, state, zipcode, images) VALUES
('SolidBlack', 1, '212 Throop ave', 'Brooklyn', 'New York', '11206', '{ "card": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FsolidBlack%2Ftobias-van-schneider-310434-unsplash.jpg?alt=media&token=9fd664cd-bc48-4155-b747-20a630ff5f7c", "header": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FsolidBlack%2Fivane-goliadze-619016-unsplash.jpg?alt=media&token=9788bca5-66ea-41f5-97a0-5229037ac13e"}'),
('byHOME', 3, '10 Homey ave', 'New York', 'New York', '11001', '{ "card": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FbyHOME%2Fnine-kopfer-1436646-unsplash.jpg?alt=media&token=6a3d2194-5afa-4190-a410-74bed968423a", "header": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FbyHOME%2Falexandra-gorn-485551-unsplash.jpg?alt=media&token=df995bd2-067c-4550-95a2-8714432fcd0f"}'),
('EssentialT', 5, '200 Wayback st', 'Bronx', 'New York', '11306', '{ "card": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FessentialT%2Fsaffu-458935-unsplash.jpg?alt=media&token=66bd2c4c-aa5b-4f32-b6d2-4ed34602e1ef", "header": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FessentialT%2Fkeagan-henman-625488-unsplash.jpg?alt=media&token=c0b21725-060d-4ccc-85cb-5beaec209bfe"}'),
('Thousand Sunny', 6, '200 Going Merry st', 'East Blue', 'Grand Line', '10000', '{ "card": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FthousandSunny%2Fsamuel-zeller-40534-unsplash.jpg?alt=media&token=efe273f0-b0f7-492e-bdc8-e8abe4c5dd38", "header": "https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/storeImages%2FthousandSunny%2Fscott-webb-199470-unsplash.jpg?alt=media&token=91f876cc-6023-4094-8a8c-dcf7c4315087"}');

INSERT INTO products (store_id, name, price, category, description, url, stock) VALUES
(1, 'grey', 25.00, 'tops', 'Grey Shirt', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/grey-1.jpg?alt=media&token=afd3c77d-288d-4b75-bf4c-59dd2e89c504', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(1, 'orange', 25.00, 'tops', 'Orange Shirt', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/orange-1.jpg?alt=media&token=3d74c963-f8e4-413a-867d-601449d238fe', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(1, 'yellow', 25.00, 'tops', 'Yellow Shirt', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/yellow-1.jpg?alt=media&token=4606f0f7-e10c-4f98-888c-2df94ffd4660', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(1, 'white stripes', 9.99, 'tops', 'Shirt w/ Stripes', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/stripe-1.jpg?alt=media&token=938c6ad8-5f05-4333-8f32-a30c63835574', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(1, 'firebrick', 25.00, 'tops', 'Firebrick Shirt', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/burg-1.jpg?alt=media&token=93ee0cf6-a372-4c8e-82c0-2064b647a691', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(1, 'knit tan', 9.99, 'tops', 'Knit Tan Shirt', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/tan-sweater-1.jpg?alt=media&token=8b427fe8-ef58-45ed-af7a-a95df9f9c5a0', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(2, 'Long T-shirt tan', 25.00, 'Long Tan Shirt', '5', 'https://photo-cdn.icons8.com/assets/previews/255/79e00fcd-d720-4135-9742-96f62c4601e92x.jpg', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(2, 'pastel pink', 9.99, 'tops', '25', 'https://photo-cdn.icons8.com/assets/previews/257/d22f24ca-54b6-4623-a6a4-b25f606039c32x.jpg', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(2, 'short pink', 25.00, 'tops', '20', 'https://photo-cdn.icons8.com/assets/previews/413/4225cc56-2bbf-4622-af7a-eedccd3aff3f2x.jpg', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(2, 'short grey', 9.99, 'tops', '20', 'https://photo-cdn.icons8.com/assets/previews/265/602c9ae2-914d-48c2-ad0f-07eaaaca302a2x.jpg', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(2, 'short white', 9.99, 'tops', '20', 'https://photo-cdn.icons8.com/assets/previews/432/22316bc2-8fc0-4529-8653-974c02efb1cf2x.jpg', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(2, 'short green', 9.99, 'tops', '20', 'https://photos.icons8.com/basic-khaki-t-shirt-5ba920738b6588000152f6c3', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(3, 'pants Blue', 9.99, 'bottoms', 'Jeans', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/Star-1.png?alt=media&token=f1032cfc-28ca-4e69-a181-6dac42dbbb70', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(3, 'pants Blue', 9.99, 'bottoms', 'Jeans', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/Star-2.png?alt=media&token=0ca8b1b2-6fc0-45bc-8b6d-8f14172b4d11', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(3, 'pants Blue', 9.99, 'bottoms', 'Jeans', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/Star-3.png?alt=media&token=11bdfccc-6c0c-42b1-bdd3-fdd70c7ab372', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(3, 'pants Blue', 9.99, 'bottoms', 'Jeans', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/Star-4.png?alt=media&token=63ea7b85-3f65-4df9-a7c0-b2b3ec26a944', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(3, 'pants Blue', 9.99, 'bottoms', 'Jeans', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/star-5.png?alt=media&token=584de7a9-e74f-49a0-ba82-4edc45113348', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'Cactii w/ two flowers', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FcactiiFlowers.jpg?alt=media&token=c06a6c1f-82b5-4b5b-8186-92f59c342ea0', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'Cement Pot Plant', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FcementPot.jpg?alt=media&token=7c64c9f8-2715-46f7-9a0a-56b675012471', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'Craxy Cactii', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FcrazyCactii.jpg?alt=media&token=b5fae5ac-06fa-485b-841f-05a1e1c5d299', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'ET Plant', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FetPot.jpg?alt=media&token=98296582-0358-4f26-b1eb-670c31729ac5', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'Pitcher Pot Plant', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FpitcherPot.jpg?alt=media&token=d8506137-904d-461e-b48b-0c0ed5114c23', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'Snail Cactii', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FsnailCactii.jpg?alt=media&token=21c64574-3406-4da1-8a0e-e31aadcc0895', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'Succulent in a bowl', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FsucculentsInBowl.jpg?alt=media&token=87fa66d1-6454-4589-9bd7-e6d088b0aaa3', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'The lonely cactus', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FtheLonelyCactus.jpg?alt=media&token=468d49cc-2d09-4ff8-9110-831791fae5fc', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }'),
(4, 'Gangs all here', 9.99, 'decor', 'plantssss', 'https://firebasestorage.googleapis.com/v0/b/theends.appspot.com/o/productImages%2Fthousandsunny%2FgangsAllHere.jpg?alt=media&token=946c2ec7-e1bf-40f1-8a44-3922dbf462d9', '{ "small": "5", "medium": "4", "large": "5", "xlarge": "5" }');

INSERT INTO orders (customer, total, status) VALUES
(1, 34.99, 'shipped'),
(1, 50, 'shipped'),
(1, 19.98, 'shipped'),
(1, 34.99, 'shipped');

INSERT INTO orderline (order_id, product_id, store_id, size, quantity) VALUES
(1, 9, 2, 'medium', 1),
(1, 10, 2,'medium', 1),
(2, 2, 1, 'large', 1),
(2, 2, 1, 'large', 1),
(3, 4, 1, 'large', 2),
(4, 1, 1, 'x-large', 1),
(4, 4, 1, 'x-large', 1);
