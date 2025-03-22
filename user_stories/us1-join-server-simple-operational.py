from common import *

us='''
* Simple Operational US: Join Server

   As a:  Server Member
 I want:  To join a server
So That:  I can engage in a community

'''

print(us)

def join_server(sid, uid):

    cols = 'sid uid'

    tmpl =  f'''
    SELECT join_server(%s, %s);
    SELECT * FROM Server_Members
    '''

    cmd = cur.mogrify(tmpl, (sid, uid,))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

join_server(3,1) 

# python user_stories/us1-join-server-simple-operational.py