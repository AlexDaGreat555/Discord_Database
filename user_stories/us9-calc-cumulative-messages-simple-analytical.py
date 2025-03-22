from common import *

us='''
* Complex Analytical US: Calculate cumulative messages (sum + per user)

   As a:  Discord Manager
 I want:  To produce a cumulative sum of messages for all users in specified channel
So That:  So that I can track activity of channel, along with discord members

'''

print(us)

def calc_cum_channel_messages(cid):

    # cols = 'cid mid message timestamp sent_by'
    cols = 'uid username num_messages cumulative_sum'

    tmpl =  f'''
    WITH channel_messages as (
        SELECT cm.cid, mi.mid, mi.message, mi.timestamp, mi.sent_by as sent_by
          FROM Channel_Messages as cm
               JOIN Message_Info as mi ON cm.mid = mi.mid
         WHERE cm.cid = %s
    ),  channel_messages_count as (
        SELECT  cm.sent_by as uid, du.username as username, COUNT(cm.mid) as num_messages
          FROM channel_messages as cm
               JOIN Discord_Users as du ON cm.sent_by = du.uid
         GROUP BY cm.sent_by, du.username 
    )
    SELECT uid, username, num_messages, SUM(num_messages) OVER w as cumulative_sum
      FROM channel_messages_count
    WINDOW w as (ORDER BY uid)
    
    '''

    cmd = cur.mogrify(tmpl, (cid,))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

calc_cum_channel_messages(5) 

# python user_stories/us9-calc-cumulative-messages-simple-analytical.py

