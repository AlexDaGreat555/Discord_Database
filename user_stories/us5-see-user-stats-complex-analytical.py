from common import *

us='''
* Complex Analytical US: See User statistics

   As a:  Server Member
 I want:  view my activity statistics: total num of dm messages sent + # servers involved in.
So That:  I can manage my time accordingly.

'''

print(us)

def view_user_stats(uid):

    cols = 'num_dm_messages num_servers'

    tmpl =  f'''
    
    WITH count_dm_messages as (
        SELECT sent_by, COUNT(dmid) as num_dm_messages
          FROM DM_Messages
         GROUP BY sent_by
    ), count_servers_involved as (
        SELECT uid, COUNT(sid) as num_servers
          FROM Server_Members
         GROUP BY uid
    )
    
    SELECT dm.num_dm_messages, si.num_servers
      FROM count_dm_messages as dm
           JOIN count_servers_involved as si ON dm.sent_by = si.uid
     WHERE dm.sent_by = %s
    
    '''

    cmd = cur.mogrify(tmpl, (uid,))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

view_user_stats(7) 

# python user_stories/us5-see-user-stats-complex-analytical.py