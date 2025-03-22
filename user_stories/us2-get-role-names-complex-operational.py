from common import *

us='''
* Complex Operational US: Get role names

   As a:  Server Owner
 I want:  To get a list of role names within my server 
So That:  I can see if any are out of date

'''

print(us)

def get_role_names(sid):

    cols = 'role_names'

    tmpl =  f'''
        WITH server_roles AS (
            SELECT rid
              FROM Server_Roles
             WHERE sid = %s
        )

        SELECT DISTINCT r.role_name
          FROM Role_Info as r
               JOIN server_roles as s ON r.rid = s.rid
        '''

    cmd = cur.mogrify(tmpl, (sid,))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

get_role_names(3) 

# python user_stories/us2-get-role-names-complex-operational.py