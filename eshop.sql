-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens



ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Home', 0, '2022-07-24 23:03:26', '2022-07-25 00:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Decors', 1, '2022-07-24 23:03:26', '2022-07-25 00:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Lightings', 2, '2022-07-24 23:03:26', '2022-07-25 00:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Furniture', 3, '2022-07-24 23:03:26', '2022-07-25 00:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-07-24 23:03:26', 'Fan', 'https://m.media-amazon.com/images/I/71VrKE7KqmL._SX679_.jpg', 'Havells Ambrose 1200mm Ceiling Fan (Gold Mist Wood)', 2340.00, 0, 22, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-07-24 23:03:26', 'Cupboard', 'https://m.media-amazon.com/images/I/319MpPibDGL.jpg', 'RW REST WELL Plastic Storage Cabinet 6104 Shoe Racks Multi Purpose Plastic Cupboard for Home (Shoe Racks)', 2560.00, 0, 60, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-07-24 23:03:26', 'TV', 'https://m.media-amazon.com/images/I/61S+ZtblluL._SX679_.jpg', 'AmazonBasics 81 cm (32 inches) HD Ready Smart LED Fire TV AB32E10SS (Black)', 13999.00, 0, 40, '2022-07-25 00:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-07-24 23:03:26', 'Home Decorations', 'https://m.media-amazon.com/images/I/71c8n9OCS3L._SX679_.jpg', 'Crystal Tree for Home Decorations Crystals and Healing Stones Witchy Room Crystal Decor Tree Crystal Gifts Gem Tree Christmas Tree Stands for Real Tree (Gomti Rudraksha Tree)', 1060.00, 0, 22, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-07-24 23:03:26', 'Home Decorations', 'https://m.media-amazon.com/images/I/81rbahBk9BL._SX679_.jpg', 'Saumic Craft Set of Five Framed Wall Painting for Home Decoration , Paintings for Living Room , 3D Scenery for Wall Big Size (75x43 CM )Pb8', 3250.00, 0, 10, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-07-24 23:03:26', 'Home Decorations', 'https://m.media-amazon.com/images/I/81jy5pgm4BL._SX679_.jpg', 'Well Art Gallery Artificial Wisteria Flowers 4 Pack Long Hanging Bush Flowers Silk Wisteria Hanging Vine Garland Party Outdoor Wedding Arch Flowers Decorations, (Baby Pink, 4)', 340.00, 0, 50, '2022-07-25 00:03:26');


INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-07-24 23:03:26', 'LED Tree Light', 'https://m.media-amazon.com/images/I/71KMwA24cDS._SX466_.jpg', 'Midkart Tabletop 108 LED Tree Light, Battery / USB Operated Mini Artificial Tree with Adjustable Branches for Home Decoration, Warm White ', 450.00, 0, 45, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-07-24 23:03:26', ' Solar String Lights 30 LED', 'https://m.media-amazon.com/images/I/61yK3w4vzLL._SX679_.jpg', 'Hardoll Solar String Lights 30 LED Decorative Lighting Bubble Crystal Ball for Garden, Home, Patio Waterproof(20FT,Warm White-Pack of 1)', 570.00, 0, 53, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-07-24 23:03:26', ' 30 LED Blossom String Fairy String Lights', 'https://m.media-amazon.com/images/I/61bxIgvwVFL._SX466_.jpg', 'KharidoLive 30 LED Blossom String Fairy String Lights (Warm White,Corded electric,Plastic) ', 350.00, 0, 70, '2022-07-25 00:03:26');

INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-07-24 23:03:26', 'Trundle Bed for Bedroom', 'https://m.media-amazon.com/images/I/71DESbIgjfL._SX679_.jpg', 'Ebansal Solid Wood Wooden Single Size Trundle Bed for Bedroom, Sheesham Wood, Honey Brown Finish  ', 26785.00, 0, 39, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-07-24 23:03:26', '4 Seater Foldable Sofa Cum Bed 78x36x14 Inches', 'https://m.media-amazon.com/images/I/71VO7bOnabL._SX679_.jpg', 'Fresh Up 4 Seater Foldable Sofa Cum Bed 78x36x14 Inches, 3 Year Warranty, 4 Cushions Incuded-Washable Molphino Chenille Fabric (Dark Brown, Seat Height 14 Inches)', 9326.00, 0, 75, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-07-24 23:03:26', 'Microwave oven', 'https://m.media-amazon.com/images/I/81jv5L8wWAL._SX679_.jpg', 'Samsung 28 L Convection Microwave Oven (CE1041DSB3/TL, Black, SlimFry) ',11000.00, 0, 20, '2022-07-25 00:03:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-07-24 23:03:26', 'Hanging Chair', 'https://m.media-amazon.com/images/I/61znH3T1AwL._SY879_.jpg', 'Carry Bird Outdoor Furniture Single Seater Swing, Beautiful Black Color Hanging Swing Without Stand',7859.00, 0, 20, '2022-07-25 00:03:26');



------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 1, panjagutta, Hyderabad', 'swetha@eshop.com', 'Swetha', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');




CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;