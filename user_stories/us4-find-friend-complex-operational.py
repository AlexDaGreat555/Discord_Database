from common import *

us='''
* Complex Operational US: Find Friend

   As a:  Server Member
 I want:  To see which of my friends are online
So That:  I can easily message them without bothering them

'''

print(us)

def find_friend_status(uid1):

    cols = 'Online_Friends'

    tmpl =  f'''
        WITH my_friends AS (
            SELECT uid2
              FROM Friends
             WHERE uid1 = %s
        )
        SELECT username
          FROM Discord_Users as u
               JOIN my_friends as m ON u.uid = m.uid2
         WHERE status = 'online'
        '''

    cmd = cur.mogrify(tmpl, (uid1, ))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

find_friend_status(1) 

# python user_stories/us4-find-friend-complex-operational.py