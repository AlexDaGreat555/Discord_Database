from common import *

us='''
* Simple Operational US: Kick User

   As a:  Server Owner
 I want:  To remove roles from server members when I kick them
So That:  I can uphold the guidelines of the server

'''

print(us)

def kick_user(sid, uid):

    cols = 'sid uid'

    tmpl =  f'''
        DELETE FROM Server_Members
         WHERE sid = %s AND uid = %s;

        SELECT * FROM Server_Members
        '''

    cmd = cur.mogrify(tmpl, (sid, uid))
    print_cmd(cmd)
    cur.execute(cmd)
    conn.commit()
    rows = cur.fetchall()
    show_table( rows, cols )
    
    cols2 = 'sid rid uid'
    
    tmpl2 = f'''
    SELECT * FROM Server_Roles
    '''
    cmd2 = cur.mogrify(tmpl2, ())
    print_cmd(cmd2)
    cur.execute(cmd2)
    rows2 = cur.fetchall()
    show_table( rows2, cols2 )

kick_user(3,7) 

# psql -d postgres -U isdb -f initialize.sql
# psql -d postgres -U isdb -f show_all.sql
# python user_stories/us7-kick-user-simple-operational.py