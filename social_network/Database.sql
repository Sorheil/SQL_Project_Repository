CREATE DATABASE IF NOT EXISTS Test;

USE Test;

CREATE TABLE
    IF NOT EXISTS community_roles (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        name varchar(255)
    );

CREATE TABLE
    IF NOT EXISTS community_permissions (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        name varchar(255)
    );

CREATE TABLE
    IF NOT EXISTS community_roles_permissions (
        role_id bigint unsigned,
        permission_id bigint unsigned,
        FOREIGN KEY (role_id) REFERENCES community_roles (id),
        FOREIGN KEY (permission_id) REFERENCES community_permissions (id),
        PRIMARY KEY (role_id, permission_id)
    );

CREATE TABLE
    IF NOT EXISTS users (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        email varchar(255),
        phone varchar(255),
        first_name varchar(255),
        last_name varchar(255),
        phone_verified_at TIMESTAMP,
        email_verified_at TIMESTAMP,
        password varchar(255),
        api_token varchar(255),
        remember_token varchar(100),
        created_at TIMESTAMP,
        updated_at TIMESTAMP,
        deleted_at TIMESTAMP,
        reason_deleted varchar(255)
    );

CREATE TABLE
    IF NOT EXISTS profiles (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        user_id bigint unsigned,
        username varchar(255),
        active tinyint (1),
        created_at TIMESTAMP,
        updated_at TIMESTAMP,
        deleted_at TIMESTAMP,
        reason_deleted varchar(255),
        FOREIGN KEY (user_id) REFERENCES users (id)
    );

CREATE TABLE
    IF NOT EXISTS likes (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        likeable_type varchar(255),
        likeable_id bigint unsigned,
        liker_id bigint unsigned,
        liked_at TIMESTAMP,
        deleted_at TIMESTAMP,
        reason_deleted varchar(255),
        FOREIGN KEY (likeable_id) REFERENCES profiles (id)
    );

CREATE TABLE
    IF NOT EXISTS communities (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        owner_id bigint unsigned,
        name varchar(255),
        description varchar(255),
        is_private tinyint (1),
        visitor_role_id bigint unsigned,
        member_default_role_id bigint unsigned,
        members_count bigint unsigned,
        created_at TIMESTAMP,
        updated_at TIMESTAMP,
        deleted_at TIMESTAMP,
        reason_deleted varchar(255),
        FOREIGN KEY (owner_id) REFERENCES profiles (id),
        FOREIGN KEY (member_default_role_id) REFERENCES community_roles_permissions (role_id),
        FOREIGN KEY (visitor_role_id) REFERENCES community_roles_permissions (role_id)
    );