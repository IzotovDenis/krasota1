PGDMP     -            	    
    v            krasota_development    9.5.10    9.5.10 T    ,	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            -	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            .	           1262    293282    krasota_development    DATABASE     �   CREATE DATABASE krasota_development WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
 #   DROP DATABASE krasota_development;
             deployer    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            /	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    7            0	           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    7                        3079    12393    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            1	           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1                        3079    293404    intarray 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;
    DROP EXTENSION intarray;
                  false    7            2	           0    0    EXTENSION intarray    COMMENT     g   COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';
                       false    2            �            1259    293292    ar_internal_metadata    TABLE     �   CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 (   DROP TABLE public.ar_internal_metadata;
       public         deployer    false    7            �            1259    293517    auth_tokens    TABLE     �   CREATE TABLE auth_tokens (
    id bigint NOT NULL,
    val character varying,
    expire_at timestamp without time zone,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.auth_tokens;
       public         deployer    false    7            �            1259    293515    auth_tokens_id_seq    SEQUENCE     t   CREATE SEQUENCE auth_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.auth_tokens_id_seq;
       public       deployer    false    195    7            3	           0    0    auth_tokens_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE auth_tokens_id_seq OWNED BY auth_tokens.id;
            public       deployer    false    194            �            1259    293335    brands    TABLE     �   CREATE TABLE brands (
    id bigint NOT NULL,
    title character varying,
    uid character varying,
    items_count integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.brands;
       public         deployer    false    7            �            1259    293333    brands_id_seq    SEQUENCE     o   CREATE SEQUENCE brands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.brands_id_seq;
       public       deployer    false    191    7            4	           0    0    brands_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE brands_id_seq OWNED BY brands.id;
            public       deployer    false    190            �            1259    293324    groups    TABLE     �  CREATE TABLE groups (
    id bigint NOT NULL,
    title character varying,
    ancestry character varying,
    has_items boolean,
    items_count integer,
    parent_uid character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uid character varying,
    disabled boolean DEFAULT false,
    display_name character varying,
    sort integer,
    columns_count integer DEFAULT 1
);
    DROP TABLE public.groups;
       public         deployer    false    7            �            1259    293322    groups_id_seq    SEQUENCE     o   CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.groups_id_seq;
       public       deployer    false    189    7            5	           0    0    groups_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE groups_id_seq OWNED BY groups.id;
            public       deployer    false    188            �            1259    293313    items    TABLE     �  CREATE TABLE items (
    id bigint NOT NULL,
    title character varying,
    uid character varying,
    price integer,
    in_stock double precision,
    discription text,
    group_uid character varying,
    brand_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    code character varying,
    image jsonb DEFAULT '{"exist": false}'::jsonb,
    likes_counter integer DEFAULT 0,
    description text
);
    DROP TABLE public.items;
       public         deployer    false    7            �            1259    293311    items_id_seq    SEQUENCE     n   CREATE SEQUENCE items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.items_id_seq;
       public       deployer    false    187    7            6	           0    0    items_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE items_id_seq OWNED BY items.id;
            public       deployer    false    186            �            1259    293539    likes    TABLE     �   CREATE TABLE likes (
    id bigint NOT NULL,
    item_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.likes;
       public         deployer    false    7            �            1259    293537    likes_id_seq    SEQUENCE     n   CREATE SEQUENCE likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.likes_id_seq;
       public       deployer    false    197    7            7	           0    0    likes_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE likes_id_seq OWNED BY likes.id;
            public       deployer    false    196            �            1259    293346    orders    TABLE     W  CREATE TABLE orders (
    id bigint NOT NULL,
    user_id integer,
    amount integer DEFAULT 0,
    items_count integer DEFAULT 0,
    items jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    received boolean DEFAULT false,
    received_at timestamp without time zone,
    formed boolean DEFAULT false,
    formed_at timestamp without time zone,
    comment text,
    info jsonb DEFAULT '{}'::jsonb,
    is_paid boolean DEFAULT false,
    payable boolean DEFAULT true,
    paid_at timestamp without time zone
);
    DROP TABLE public.orders;
       public         deployer    false    7            �            1259    293344    orders_id_seq    SEQUENCE     o   CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public       deployer    false    193    7            8	           0    0    orders_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE orders_id_seq OWNED BY orders.id;
            public       deployer    false    192            �            1259    293588    payments    TABLE     H  CREATE TABLE payments (
    id bigint NOT NULL,
    order_id integer,
    amount integer,
    merchant_order_id character varying,
    status integer,
    info jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    order_url character varying
);
    DROP TABLE public.payments;
       public         deployer    false    7            �            1259    293586    payments_id_seq    SEQUENCE     q   CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.payments_id_seq;
       public       deployer    false    201    7            9	           0    0    payments_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE payments_id_seq OWNED BY payments.id;
            public       deployer    false    200            �            1259    293284    schema_migrations    TABLE     K   CREATE TABLE schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         deployer    false    7            �            1259    293566    smsmessages    TABLE     ,  CREATE TABLE smsmessages (
    id bigint NOT NULL,
    user_id integer,
    pin character varying,
    tel character varying,
    sended boolean DEFAULT false,
    used boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.smsmessages;
       public         deployer    false    7            �            1259    293564    smsmessages_id_seq    SEQUENCE     t   CREATE SEQUENCE smsmessages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.smsmessages_id_seq;
       public       deployer    false    7    199            :	           0    0    smsmessages_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE smsmessages_id_seq OWNED BY smsmessages.id;
            public       deployer    false    198            �            1259    293302    users    TABLE     �  CREATE TABLE users (
    id bigint NOT NULL,
    email character varying,
    password_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying,
    tel character varying,
    created_from_1c boolean DEFAULT false,
    role character varying DEFAULT 'user'::character varying,
    pin character varying,
    likes_counter integer DEFAULT 0,
    city character varying,
    comment text,
    discount integer DEFAULT 0,
    firstname character varying,
    lastname character varying,
    thirdname character varying,
    zip_code character varying,
    address text
);
    DROP TABLE public.users;
       public         deployer    false    7            �            1259    293300    users_id_seq    SEQUENCE     n   CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       deployer    false    7    185            ;	           0    0    users_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE users_id_seq OWNED BY users.id;
            public       deployer    false    184            �           2604    343514    id    DEFAULT     b   ALTER TABLE ONLY auth_tokens ALTER COLUMN id SET DEFAULT nextval('auth_tokens_id_seq'::regclass);
 =   ALTER TABLE public.auth_tokens ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    195    194    195            x           2604    343515    id    DEFAULT     X   ALTER TABLE ONLY brands ALTER COLUMN id SET DEFAULT nextval('brands_id_seq'::regclass);
 8   ALTER TABLE public.brands ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    190    191    191            w           2604    343516    id    DEFAULT     X   ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);
 8   ALTER TABLE public.groups ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    188    189    189            t           2604    343517    id    DEFAULT     V   ALTER TABLE ONLY items ALTER COLUMN id SET DEFAULT nextval('items_id_seq'::regclass);
 7   ALTER TABLE public.items ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    186    187    187            �           2604    343518    id    DEFAULT     V   ALTER TABLE ONLY likes ALTER COLUMN id SET DEFAULT nextval('likes_id_seq'::regclass);
 7   ALTER TABLE public.likes ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    197    196    197            �           2604    343519    id    DEFAULT     X   ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    192    193    193            �           2604    343520    id    DEFAULT     \   ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);
 :   ALTER TABLE public.payments ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    200    201    201            �           2604    343521    id    DEFAULT     b   ALTER TABLE ONLY smsmessages ALTER COLUMN id SET DEFAULT nextval('smsmessages_id_seq'::regclass);
 =   ALTER TABLE public.smsmessages ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    199    198    199            q           2604    343522    id    DEFAULT     V   ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       deployer    false    184    185    185            	          0    293292    ar_internal_metadata 
   TABLE DATA               K   COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
    public       deployer    false    183   ]       #	          0    293517    auth_tokens 
   TABLE DATA               S   COPY auth_tokens (id, val, expire_at, user_id, created_at, updated_at) FROM stdin;
    public       deployer    false    195   h]       <	           0    0    auth_tokens_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('auth_tokens_id_seq', 49, true);
            public       deployer    false    194            	          0    293335    brands 
   TABLE DATA               N   COPY brands (id, title, uid, items_count, created_at, updated_at) FROM stdin;
    public       deployer    false    191   ^       =	           0    0    brands_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('brands_id_seq', 1, false);
            public       deployer    false    190            	          0    293324    groups 
   TABLE DATA               �   COPY groups (id, title, ancestry, has_items, items_count, parent_uid, created_at, updated_at, uid, disabled, display_name, sort, columns_count) FROM stdin;
    public       deployer    false    189   .^       >	           0    0    groups_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('groups_id_seq', 1287, false);
            public       deployer    false    188            	          0    293313    items 
   TABLE DATA               �   COPY items (id, title, uid, price, in_stock, discription, group_uid, brand_id, created_at, updated_at, code, image, likes_counter, description) FROM stdin;
    public       deployer    false    187   �l       ?	           0    0    items_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('items_id_seq', 31216, false);
            public       deployer    false    186            %	          0    293539    likes 
   TABLE DATA               F   COPY likes (id, item_id, user_id, created_at, updated_at) FROM stdin;
    public       deployer    false    197   �m       @	           0    0    likes_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('likes_id_seq', 61, true);
            public       deployer    false    196            !	          0    293346    orders 
   TABLE DATA               �   COPY orders (id, user_id, amount, items_count, items, created_at, updated_at, received, received_at, formed, formed_at, comment, info, is_paid, payable, paid_at) FROM stdin;
    public       deployer    false    193   �o       A	           0    0    orders_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('orders_id_seq', 23, true);
            public       deployer    false    192            )	          0    293588    payments 
   TABLE DATA               u   COPY payments (id, order_id, amount, merchant_order_id, status, info, created_at, updated_at, order_url) FROM stdin;
    public       deployer    false    201   �q       B	           0    0    payments_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('payments_id_seq', 9, true);
            public       deployer    false    200            	          0    293284    schema_migrations 
   TABLE DATA               -   COPY schema_migrations (version) FROM stdin;
    public       deployer    false    182   v       '	          0    293566    smsmessages 
   TABLE DATA               [   COPY smsmessages (id, user_id, pin, tel, sended, used, created_at, updated_at) FROM stdin;
    public       deployer    false    199   �v       C	           0    0    smsmessages_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('smsmessages_id_seq', 19, true);
            public       deployer    false    198            	          0    293302    users 
   TABLE DATA               �   COPY users (id, email, password_digest, created_at, updated_at, name, tel, created_from_1c, role, pin, likes_counter, city, comment, discount, firstname, lastname, thirdname, zip_code, address) FROM stdin;
    public       deployer    false    185   ~w       D	           0    0    users_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('users_id_seq', 8, true);
            public       deployer    false    184            �           2606    293299    ar_internal_metadata_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);
 X   ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
       public         deployer    false    183    183            �           2606    293525    auth_tokens_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY auth_tokens
    ADD CONSTRAINT auth_tokens_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.auth_tokens DROP CONSTRAINT auth_tokens_pkey;
       public         deployer    false    195    195            �           2606    293343    brands_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.brands DROP CONSTRAINT brands_pkey;
       public         deployer    false    191    191            �           2606    293332    groups_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.groups DROP CONSTRAINT groups_pkey;
       public         deployer    false    189    189            �           2606    293321 
   items_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
       public         deployer    false    187    187            �           2606    293544 
   likes_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.likes DROP CONSTRAINT likes_pkey;
       public         deployer    false    197    197            �           2606    293357    orders_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public         deployer    false    193    193            �           2606    293596    payments_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.payments DROP CONSTRAINT payments_pkey;
       public         deployer    false    201    201            �           2606    293291    schema_migrations_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 R   ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       public         deployer    false    182    182            �           2606    293576    smsmessages_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY smsmessages
    ADD CONSTRAINT smsmessages_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.smsmessages DROP CONSTRAINT smsmessages_pkey;
       public         deployer    false    199    199            �           2606    293310 
   users_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         deployer    false    185    185            �           1259    293526    index_auth_tokens_on_val    INDEX     H   CREATE INDEX index_auth_tokens_on_val ON auth_tokens USING btree (val);
 ,   DROP INDEX public.index_auth_tokens_on_val;
       public         deployer    false    195            �           1259    293359    index_groups_on_uid    INDEX     E   CREATE UNIQUE INDEX index_groups_on_uid ON groups USING btree (uid);
 '   DROP INDEX public.index_groups_on_uid;
       public         deployer    false    189            �           1259    293358    index_items_on_uid    INDEX     C   CREATE UNIQUE INDEX index_items_on_uid ON items USING btree (uid);
 &   DROP INDEX public.index_items_on_uid;
       public         deployer    false    187            �           1259    293387    index_users_on_email    INDEX     G   CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);
 (   DROP INDEX public.index_users_on_email;
       public         deployer    false    185            �           1259    293386    index_users_on_tel    INDEX     C   CREATE UNIQUE INDEX index_users_on_tel ON users USING btree (tel);
 &   DROP INDEX public.index_users_on_tel;
       public         deployer    false    185            	   ?   x�K�+�,���M�+�LI-K��/ ��-tt�ͬ-�L��,,̌�Hq��qqq ��l      #	   �   x�}ͻ�0E�Z��� )��	�P���q�T^w�p��F�\4- �M��#�qFL�
�z�dW��K� ,ק`!@�v����;����^���i�zC�.ϔŔI���,�)���(�,����q���䇲:��T����x;�      	      x������ � �      	   g  x��\Yo�~����]�},� J"�ɰ'�2g`X����&Q����e;F;��\�#E��R����?JU��r��ٞ]�������u|�U5i������[�E�#�)R= j�Ę��z��J�@�$I2&�!��F��CB��B�*Ra�CzEZ�M�燃� ?�>䏧���|??̏KI�/���=�v�؈pZ�n���댏��q�:��J��l��(+h����b��?��Y~>�?��'��|@��1���ָ��L*Ё6	K���D�l@�X�1�#Z{}I��H'E��"��<�A-��� �Z��'����(�����K���$v@�X�15#�t��^ۯ)S� �
>{/?�OQ�����8Ꮶ;��� �Y~0ݭ���ѱ��
9��tL!A�?4Mx�l����W)��Y�߄�.����Z1��g��?v&�9�j,x�l�fb�\4kZ4^�U���_���[��Ԛ ���Y>�7�|<��{���aG��I�!D�����lN�ޏ1XL�#g^gM��i)��,���6�UA�������C1.�\��A�-e�}�[cA嶔3apdms,5��_@���1�E�]���Bp��_�4�~��K�K��Je�)�Xs"�xhcq�e�MzjƔ�8m�t�ulH��.�7��}�V�֝JѺp�h��J+�M�Q�fD���[(���1Aؙ����O?�M<r[���W��'�U	M�x�Sd);X��.���M�0�?A��~4�������V(�g/���!Dm���f�����}L	!
��S�ās�I	Tf�=����r�����l�8G`j�|������lB�kΡ[%8E�ރG�F`o3X�{�@����m)*�*�ʽ�B���!ֹ���b��4,�W㢰����gU�Fk������&=�͇��#��,k��l �D�&�0aYLQ�Y��3x�X=>��e3u�l�ؕf"x#�Y��e�N�p�<��0P���k�D�q2�b$M|��`,4Ksg��N��{w��� C
;9���v�:8��CX�[���6�ޟD�!��u��CX��G� �L\`�po:)Sx�xO�,�n�0�5䜍J���cmB����S"�&xbP���+$�Ф ���:7:qp�8í["����Q�}<�~؈�E_���T��mv�K�_�
,��e�7E�t���.����p���׌��|	�rDb�mfcJ�/��:d;)���"N�������@�2f�� �E���CW\<�~�R��S�!e4�1'V �y��s9���-���Վ*�j��u��cYZUfc�cj�W4�%q��2}.��R6�5�|�N�=�;�u��ko��`�Y��#���Ң��%ovk�1�x��րA�����e�b��J������(�A�S�+P#��C"x���<K'�u������s�2�����5�����[[��^`WZ�2�����-�b;�����x
���C����:�t�
�g����P�b�	2��4e���C(�81ٌUI�)'�u�ms}��ۃW^�����^�q�ֵ�8���_�w����&a��ԄM[r�45����{���4v/ 9�]���* ��Ά��*A����.c'�hm;�.�ڱ�񍏚&i�)�BӶ]x�v���r�;�R�_�G���c'�D�0�Rr
�a;3�1�y�/ʜsW#�Y�J��;y!�X�q��\"+�X_�{�YU�e�����2�����>'����:�=��� �]V�,�"���p�H��
D�sPc�Gͧ@b�Y�qI�f9u)g1`��.��y�Si���ȕJ�滁]��W���
�_��9���Z�����'lY��x�������c�*� �tV?����0LOݒm���� �^
��bj���f!Xb��y�fE�������\x:�v!����D#|�h��dBډhTHw��l��Gt�N���j��D��*�A�_���a�g'�+e�*�Z��Sv
ޗ�;��Ti?p��T��Z�TG�L�9��f�=�,&�etےEj��ĕ��A�A�h��
����"����B�����.2՚l���Ȣ���`���rb�n-O�����ܭY9J��b�4Nֲ!����Y�D�J4�JWѼ���m�T��� ��b�MI?�wF�6�B����o)h�c�Lv���� v�6��و�%�'��E,$#�F:���T\U��m�S˅P���L��
��a�,�-*����\T|R
���4y3�a0��sv����%�S�4	�F����a���p�]�z��\��l%��?��i�}��B.����|�g�ߕ7&�:��W�Ex/:D1ֹ_���D�ZB��l#���À.>��}���{�%�h��Lq�v�kKKD:�^��t���������P4�~�����o\��� $:��X�!�P�H����n��f�8m1��e������j���OKr�hq�'r@X��12]i��F2�$]wM$TeH�s��/�b��4"֏)�A]��{#�����yz�NZ7"j�&d	�@i�[��:�L&�IҜ��HB^x����n^�����:$�ww�)�p:a
��P
��Xb�ې�Ch��t��<�� �O/�Q~�7��{����З�q�Ƈ������>���c[v��7���e/�#n��_=u1�?\tN����H(�P�MHR_:�uR�������=UdQ�d'��Ƭ��y �s8��/'��(��@6�e ���@�X��'
��W9�g�M?#�Z�i�̍���#�X#���6tj��ѫ"�sj�f4շ�I�b�Z��Ya�[��D��Ql0]�N��N��6����8�:�Grm�^� �0�\V���cO,O�EʥL6�
��e�do����;|c~��3�Rv�Vs���B& �FQ�F.��la���W$Y�{��TI�!�����?�q���N�
u��ٚ9��{l��>���*w��4c
^�J��#{���,�P~�bO�s"�4���vajoх��Zz8%�x8�#C����&n%��ȕ󥲟[�L�,3J#�4��OS�Nw�}�[�C�~��Ĩ02oD
�~n��X?�L+�5�̍���.׮�0��`\X���`�[��#��1:bRS�ȍFG�P8��#�w�T!�*̶�
�k%���:UH{�
��0�S�J���.D�G��
�����h?c�b|�<^�����/s�pd�[8D�◌)	�,v���˫��p���ca%�Rz�>���h�6�2���z�����Ź�>6"��h����<�9;�N�=��i���M����3���RtQK���'�4�Iq�c#� ��ks�����S�x�O���&*�k3S��"q���,����%�el���+M2�u�-޵����Kv*�(6 �I�\	'>2\ߏk�N
I��.��o�X;������E��Rن�$U��e(-��I�#���Ҍ��8 �=,�\B�J��Z;��r�U?Wn2��L��ܴ��x_�a�߅��#7�C]l}�.$��^Ղ���fŔ�#*Z:��,I�!!E�V�,�P.i�K�Ȫ���o5��./©^�JٖS����5@�W�`��z�ᐎ�P?�P���ʕ+�����      	   �   x�uOKJ1]�Of��R�T�sQ��鞤Ap7.�.DEťA�����if6���W�GY5ߟ�<l�6Ʋ�)D�����Z����Og��py<�z莖�LMw+TQ˛���und�W�л{;ږ�����D ��5�f6}v��Ԅ�	���)��إ�כ�~���3 H�|枻�48"Elkf�o]�em&D�zG�d%�򢋻�-Or/���u!r-�%�+qU�몪��pn	      %	   �  x�}��m!@��*�� ���%���R��, �������tQ\t1R|a�B�1�0mξ'�|�.]k,}O��"Y���"j�=�tiGK����.⥝M$SWg�"����p�2���d'�K�T5�8.�z3�Wtd'R�Z�Xd7ʠ: I�%B���N�'��ϕ�Ԉ)$���,:�}������'�K���g�цƐl���͙n+_�ag�< �������Y�Tt���>��M�yI��R? P��,}k�A=�Q��+�J�"�����m�gV���Vv�N��I��s*p�{�/%�w����h��X���R�w5����/�4> ��@��ƚ�(�Am�\�}��㦁����L���*���*��\�����&2Ƽ��ͫ��R����3<Q�8!�^�{,���x����s��XE�G�"�כ���*Ck�k�����e��&�������:F���f��K���=�� ?x'�I      !	   9  x��WMn�0^�w�([����/^�BB X�jQ�&~`��)�C@�6�,�W������1NEUP�p%���3��/�3�q:^�[ /�d�N�Nr&K��B����bv���F��̞������Aσ�<4����,ߍV^�FJ˛�[Q ^�k�al#��cN����S|��<�ªz������E�����m��5�݇~왃��u�.�>��p6|�?y�,�.c�M���ǁA��>��M}����	]݆m6k�w���[6�:	�k�y��N)� 
{MT��ΈR�,�_Ʊ�3%HC,��q�u��F��۵!t'��WU��݃�b�n$�iZ�u{�V�ڿ�2TY��mYu��Z�,��������G����J��]��V�����u:�p�*��o����������ܡ`V�9�$�t`M�1f
�C7���B������<��[�4� 7�G�80�T9�*���q�e��0�*��hy%JVrRNA����$�v`�����R��ML�Cd���R�C��ʸ^�gT���v�P�r8d������      )	     x����n�6Ư��t1�E)�HJE1xq�Y�"���u((���ؒ@Im� ���^a��a�nֽ��F#9��0`_�9���w��z�G���d����>��1�_IL$�����޻�ލ��n����0�ݗ���Z�8�I bP`���M^�D{
�&��j���	޴�rn���h<q�C�[uh����H�����K��ŗ��w����ޚ5q����k�Z�Һ�˝ڈ��Ȼ�5&�ZgQS��~�q�n�yr���惜5ml�r����]�zz���fnuh�c7��R_�H�W&��Y�L�Vz��r6JZ	&�gvqam��"c&�˪ڴ?�Ƶ�kw�MS&�|�1���R'������������`����m���w�I[�Oe���^;	�5!K�ڔhY��Ky=Wy=��j����x�v6���ru�>>;n{�6�DU���o���.���m����ʦ�v�V8�Ҹ~{6M��_�d�t,�J�<YI�`�ʢ���p��i_^���Vj948�.>VJ�����1�K�hm�tca�J�j������b�Y�A��td����� \7Vi��U�I�k6�ɾ�A��E�'��t� ��W�	0�����sgP�3u������{�9ώ�LN~x�̲+�|���s8��\�ל8c�J�u��P�y��󳓣��zx����uV.�ҽ�� A���Ha�P��Q��C�<� ��7��
���*�tT5���bޗQ��__�Y,g�nڼi=�}�]�w��Y�k���� I�GȔD����9�_t�^��!�!ƞq�-�7�.��Z1�Q�} a
�T�VH���Ѕ>	�?�>�b[jo�]��ў���4%��0B�� �@�Xn��!%!��@\�-���v���X�Fb$|� �̴<
" I ��߂fީ $f���跥�������.0�%@�c8�c P��Q���
Lݖ�n�kp�tp"F(`� 8NS $� PT�\`_+sgP�AJH�oK����5�w����7:�      	   �   x�]��u!C���=�� zI�uD���I>/F�4L��-��ō��
��M��,Â]ss�<�2r��e3[�X�
�6z"�Ac�Ê��(W�#{Z�3��Y�/&<Z;��� ��Č����4R��>�{�TH�q./��PE�O9x;'���Sո(�x��G̓Pj-<(#_�jcV���6V��[[�>���u]��T`�      '	   �   x����1�q4p���$v���{S���$N��hG�����G��� ٭=ڳ�!7؆�Y�~�IV���-;��<B�Z�X�/Nͪ(~�0c!�\�\6�3���4��Y����Y�p��O5����JGV ���� C6?      	   d  x�͑MO�0����+��8v��
M֒6	-iY�%I�H�wrچ����;L��ؐ�|�-ec��z�8L�������	����7螛󔆖TiAk����T�A��W�����4�иR��~�_���H�ɛn"�E8�<$�1�	]��2��(JPh�Q0\N�r����2�iQ��Ժ��4�hj�����\*�:Ӯ6D��W�5ߚ�y�Z���x��YS�@BDq]�B���#RQ�g�f�_.��#�H���%������?-N��W~�k��G��3�)=�8+�;q�s6(ע$p�V�1��ň��U�+ղ=��[�D��!���"�XdX^�����!�_xѰ7~ttg��G��S�ȴ1���;� 5s����	���<�!p��4�D�=y���L�eJ�$+^������b�D�m�Fk�:1p2.jFH��~(����kTo�;��~�iA�1ә�>�'ȄI�	��ъ����?��כ��-����Ҏ��7�dL,a&,N���4}�H�����7�<˿�,���� +�[������P�������~bZ]�����S)�n�b)4��^���n?hAdy	B����h� �?k� d2������     