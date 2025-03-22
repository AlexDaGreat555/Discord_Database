-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-12-04 22:20:38.015

-- tables
-- Table: Basic
CREATE TABLE Basic (
    uid int  NOT NULL,
    uncustom_bio text  NOT NULL,
    CONSTRAINT Basic_pk PRIMARY KEY (uid)
);

-- Table: Channel
CREATE TABLE Channel (
    cid int  NOT NULL,
    channel_name text  NOT NULL,
    sid int  NOT NULL,
    CONSTRAINT Channel_pk PRIMARY KEY (cid)
);

-- Table: Channel_Messages
CREATE TABLE Channel_Messages (
    cid int  NOT NULL,
    mid int  NOT NULL,
    CONSTRAINT Channel_Messages_pk PRIMARY KEY (cid,mid)
);

-- Table: DM_Messages
CREATE TABLE DM_Messages (
    dmid int  NOT NULL,
    message text  NOT NULL,
    timestamp date  NOT NULL,
    sent_to int  NOT NULL,
    sent_by int  NOT NULL,
    CONSTRAINT DM_Messages_pk PRIMARY KEY (dmid)
);

-- Table: Discord_Users
CREATE TABLE Discord_Users (
    uid int  NOT NULL,
    username text  NOT NULL,
    status Status_Type  NOT NULL,
    CONSTRAINT Discord_Users_pk PRIMARY KEY (uid)
);

-- Table: Friends
CREATE TABLE Friends (
    uid1 int  NOT NULL,
    uid2 int  NOT NULL,
    CONSTRAINT Friends_pk PRIMARY KEY (uid1,uid2)
);

-- Table: Message_Info
CREATE TABLE Message_Info (
    mid int  NOT NULL,
    message text  NOT NULL,
    timestamp date  NOT NULL,
    sent_by int  NOT NULL,
    CONSTRAINT Message_Info_pk PRIMARY KEY (mid)
);

-- Table: Nitro
CREATE TABLE Nitro (
    uid int  NOT NULL,
    custom_bio text  NOT NULL,
    CONSTRAINT Nitro_pk PRIMARY KEY (uid)
);

-- Table: Role_Info
CREATE TABLE Role_Info (
    rid int  NOT NULL,
    role_name text  NOT NULL,
    kick_members boolean  NOT NULL,
    ban_members boolean  NOT NULL,
    CONSTRAINT Role_Info_pk PRIMARY KEY (rid)
);

-- Table: Server_Members
CREATE TABLE Server_Members (
    sid int  NOT NULL,
    uid int  NOT NULL,
    CONSTRAINT Server_Members_pk PRIMARY KEY (sid,uid)
);

-- Table: Server_Roles
CREATE TABLE Server_Roles (
    sid int  NOT NULL,
    rid int  NOT NULL,
    uid int  NOT NULL,
    CONSTRAINT Server_Roles_pk PRIMARY KEY (sid,rid,uid)
);

-- Table: Servers
CREATE TABLE Servers (
    sid int  NOT NULL,
    server_name text  NOT NULL,
    oid int  NOT NULL,
    CONSTRAINT Servers_pk PRIMARY KEY (sid)
);

-- foreign keys
-- Reference: Channel_Messages_Channel (table: Channel_Messages)
ALTER TABLE Channel_Messages ADD CONSTRAINT Channel_Messages_Channel
    FOREIGN KEY (cid)
    REFERENCES Channel (cid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Channel_Servers (table: Channel)
ALTER TABLE Channel ADD CONSTRAINT Channel_Servers
    FOREIGN KEY (sid)
    REFERENCES Servers (sid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Discord_Users_Basic (table: Basic)
ALTER TABLE Basic ADD CONSTRAINT Discord_Users_Basic
    FOREIGN KEY (uid)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Discord_Users_Friends (table: Friends)
ALTER TABLE Friends ADD CONSTRAINT Discord_Users_Friends
    FOREIGN KEY (uid1)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Discord_Users_Nitro (table: Nitro)
ALTER TABLE Nitro ADD CONSTRAINT Discord_Users_Nitro
    FOREIGN KEY (uid)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Friends_Discord_Users (table: Friends)
ALTER TABLE Friends ADD CONSTRAINT Friends_Discord_Users
    FOREIGN KEY (uid2)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Message_Info_Channel_Messages (table: Channel_Messages)
ALTER TABLE Channel_Messages ADD CONSTRAINT Message_Info_Channel_Messages
    FOREIGN KEY (mid)
    REFERENCES Message_Info (mid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Message_Info_Discord_Users (table: Message_Info)
ALTER TABLE Message_Info ADD CONSTRAINT Message_Info_Discord_Users
    FOREIGN KEY (sent_by)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Server_joined (table: Server_Members)
ALTER TABLE Server_Members ADD CONSTRAINT Server_joined
    FOREIGN KEY (sid)
    REFERENCES Servers (sid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Server_serverMem_info (table: Server_Roles)
ALTER TABLE Server_Roles ADD CONSTRAINT Server_serverMem_info
    FOREIGN KEY (sid)
    REFERENCES Servers (sid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: User_joined (table: Server_Members)
ALTER TABLE Server_Members ADD CONSTRAINT User_joined
    FOREIGN KEY (uid)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: role_info_serverMem_info (table: Server_Roles)
ALTER TABLE Server_Roles ADD CONSTRAINT role_info_serverMem_info
    FOREIGN KEY (rid)
    REFERENCES Role_Info (rid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: sent_by (table: DM_Messages)
ALTER TABLE DM_Messages ADD CONSTRAINT sent_by
    FOREIGN KEY (sent_by)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: sent_to (table: DM_Messages)
ALTER TABLE DM_Messages ADD CONSTRAINT sent_to
    FOREIGN KEY (sent_to)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: serverMem_info_User (table: Server_Roles)
ALTER TABLE Server_Roles ADD CONSTRAINT serverMem_info_User
    FOREIGN KEY (uid)
    REFERENCES Discord_Users (uid)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

