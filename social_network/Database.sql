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
        PRIMARY KEY (role_id, permission_id),
        FOREIGN KEY (role_id) REFERENCES community_roles (id),
        FOREIGN KEY (permission_id) REFERENCES community_permissions (id)
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

CREATE TABLE
    IF NOT EXISTS communities_members (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        profile_id bigint unsigned,
        community_id bigint unsigned,
        role_id bigint unsigned,
        joined_at TIMESTAMP,
        updated_at TIMESTAMP,
        FOREIGN KEY (profile_id) REFERENCES profiles (id),
        FOREIGN KEY (community_id) REFERENCES communities (id),
        FOREIGN KEY (role_id) REFERENCES community_roles (id)
    );

CREATE TABLE
    IF NOT EXISTS notifications (
        id char(36) PRIMARY KEY NOT NULL,
        type varchar(255),
        notifiable_type bigint unsigned,
        notifiable_id bigint unsigned,
        data json,
        read_at TIMESTAMP,
        created_at TIMESTAMP,
        updated_at TIMESTAMP
    );

CREATE TABLE
    IF NOT EXISTS profile_data (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        profile_id bigint unsigned,
        website_url varchar(255),
        country varchar(255),
        city varchar(255),
        address varchar(255),
        FOREIGN KEY (profile_id) REFERENCES profiles (id)
    );

CREATE TABLE
    IF NOT EXISTS posts (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        author_id bigint unsigned,
        title varchar(255),
        body text,
        uuid62 varchar(255),
        pageable_type varchar(255),
        pageable_id bigint unsigned,
        slug varchar(255),
        created_at TIMESTAMP,
        updated_at TIMESTAMP,
        deleted_at TIMESTAMP,
        reason_deleted varchar(255),
        FOREIGN KEY (author_id) REFERENCES profiles (id)
    );

CREATE TABLE
    IF NOT EXISTS post_views (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        viewer_id bigint unsigned,
        post_id bigint unsigned,
        viewed_count smallint unsigned,
        viewed_at TIMESTAMP,
        deleted_at TIMESTAMP,
        reason_deleted varchar(255),
        FOREIGN KEY (viewer_id) REFERENCES profiles (id),
        FOREIGN KEY (post_id) REFERENCES posts (id)
    );

CREATE TABLE
    IF NOT EXISTS users_settings (
        user_id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        id bigint unsigned,
        FOREIGN KEY (user_id) REFERENCES users (id)
    );

CREATE TABLE
    IF NOT EXISTS images (
        id bigint unsigned PRIMARY KEY AUTO_INCREMENT,
        imageable_type varchar(255),
        imageable_id bigint unsigned,
        purpose varchar(255),
        sha256 char(64),
        type tinyint unsigned,
        width smallint unsigned,
        height smallint unsigned,
        size bigint unsigned,
        origin_name varchar(255),
        mime varchar(255),
        extension varchar(255),
        sfw_score decimal(2, 1),
        created_at TIMESTAMP,
        updated_at TIMESTAMP,
        deleted_at TIMESTAMP,
        reason_deleted varchar(255),
        FOREIGN KEY (imageable_id) REFERENCES profiles (id)
    );