-- drop the trax database if it exists
DROP database if EXISTS project;

-- create it afresh
CREATE database project;
\c project

CREATE TYPE Status_Type AS ENUM( 'online', 'idle', 'do not disturb');

\i create.SQL

-- load the data

\copy Discord_Users(uid, username, status) FROM data/Users.csv csv header;
\copy Servers(sid, server_name, oid) FROM data/Servers.csv csv header;
\copy Role_Info(rid, role_name, kick_members, ban_members) FROM data/role_info.csv csv header;
\copy Server_Roles(sid, rid, uid) FROM data/Server_Roles.csv csv header;
\copy Server_Members(sid, uid) FROM data/server_members.csv csv header;
\copy Basic(uid, uncustom_bio) FROM data/Basic.csv csv header;
\copy Nitro(uid, custom_bio) FROM data/Nitro.csv csv header;
\copy Friends(uid1, uid2) FROM data/Friends.csv csv header;
\copy DM_Messages(dmid, message, timestamp, sent_to, sent_by) FROM data/DM_Messages.csv csv header;
\copy Channel(sid, cid, channel_name) FROM data/Channel.csv csv header;
\copy Message_Info(mid, message, timestamp, sent_by) FROM data/Message_Info.csv csv header;
\copy Channel_Messages(cid, mid) FROM data/Channel_Messages.csv csv header;

CREATE FUNCTION fn_kick_members()
RETURNS trigger 
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM Server_Roles
    WHERE (uid = old.uid AND sid = old.sid);
RETURN NULL;
END
$$; 

CREATE TRIGGER tr_kick_member
AFTER DELETE ON Server_Members
FOR EACH ROW
    EXECUTE FUNCTION fn_kick_members();

CREATE FUNCTION join_server(p_sid int, p_uid int)
RETURNS VOID
LANGUAGE plpgsql AS
$$
BEGIN
    IF NOT EXISTS (SELECT 1
                     FROM Servers
                    WHERE sid = p_sid) THEN
        RAISE EXCEPTION 'server %s does not exist: ', p_sid;
    END IF;

    IF NOT EXISTS (SELECT 1
                     FROM Discord_Users
                    WHERE uid = p_uid) THEN
        RAISE EXCEPTION 'user %s does not exist: ', p_uid;
    END IF;


    INSERT INTO Server_Members
    VALUES (p_sid, p_uid)
    ON CONFLICT DO NOTHING;
END;
$$;

CREATE FUNCTION add_friend(p_uid1 int, p_uid2 int)
RETURNS VOID
LANGUAGE plpgsql AS
$$
BEGIN
    IF NOT EXISTS (SELECT 1
                     FROM Discord_Users
                    WHERE uid = p_uid1) THEN
        RAISE EXCEPTION 'user %s does not exist: ', p_uid1;
    END IF;

    IF NOT EXISTS (SELECT 1
                     FROM Discord_Users
                    WHERE uid = p_uid2) THEN
        RAISE EXCEPTION 'user %s does not exist: ', p_uid2;
    END IF;

    INSERT INTO Friends
    VALUES (p_uid1, p_uid2)
    ON CONFLICT DO NOTHING;

    INSERT INTO Friends
    VALUES (p_uid2, p_uid1)
    ON CONFLICT DO NOTHING;
END;
$$;