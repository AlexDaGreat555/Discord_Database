from common import *

us='''
* Complex Operational US: get usernames

   As a:  Server Owner
 I want:  To Filter members that have a specific role
So That:  So that I can look for members more efficiently 
'''

print(us)

def get_usernames(rid):

    cols = 'u.username'

    tmpl =  f'''
SELECT {c(cols)}
  FROM Discord_Users as u
       JOIN Server_Roles as s ON u.uid = s.uid
 WHERE %s = s.rid
'''

    cmd = cur.mogrify(tmpl, (rid,))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

get_usernames(1) 

# python user_stories/us3-get-usernames-complex-analytical.py