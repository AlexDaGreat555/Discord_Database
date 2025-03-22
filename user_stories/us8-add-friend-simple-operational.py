from common import *

us='''
* Simple Operational US: Add Friend

   As a:  Server Member
 I want:  To add my friend on discord
So That:  I can message and call them on discord

'''

print(us)

def add_friend(uid1, uid2):

    cols = 'uid1 uid2'

    tmpl =  f'''
        SELECT add_friend(%s, %s);
        SELECT * FROM Friends
        '''

    cmd = cur.mogrify(tmpl, (uid1, uid2,))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

add_friend(5,2) 

# python user_stories/us8-add-friend-simple-operational.py