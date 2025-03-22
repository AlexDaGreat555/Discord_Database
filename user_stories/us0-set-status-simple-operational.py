from common import *

us='''
* Simple Operational US: Set Status

   As a:  Server Member
 I want:  To set my status to Do Not Disturb
So That:  My friends know not to bother me

'''

print(us)

def set_status(status,uid):

    cols = 'uid username status'

    tmpl =  f'''
        UPDATE Discord_Users
           SET status = %s
         WHERE uid = %s;

         SELECT * FROM Discord_Users
        '''
    cmd = cur.mogrify(tmpl, (status, uid))
    print_cmd(cmd)
    cur.execute(cmd)
    cur.connection.commit()
    rows = cur.fetchall()
    show_table(rows, cols)

set_status('do not disturb', 6) 
# psql -d postgres -U isdb -f initialize.sql
# psql -d postgres -U isdb -f show_all.sql
# python user_stories/us0-set-status-simple-operational.py

