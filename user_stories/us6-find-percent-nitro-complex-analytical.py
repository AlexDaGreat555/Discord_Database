from common import *

us='''
* Complex Analytical US: Count subscriptions

   As a:  Discord Manager
 I want:  Find the percentage of Discord users that have nitro
So That:  I can edit marketing plan accordingly

'''

print(us)

def find_percent():
    cols = 'percent_nitro'
    tmpl =  f'''

        SELECT ROUND(COUNT(n.uid)/(COUNT(n.uid) + COUNT(b.uid)*1.0)*100, 2) as percent_nitro
          FROM Nitro as n
               FULL OUTER JOIN Discord_Users as d ON n.uid = d.uid
               LEFT JOIN Basic as b ON b.uid = d.uid 
        '''

    cmd = cur.mogrify(tmpl, ())
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    show_table( rows, cols )

find_percent() 
# psql -d postgres -U isdb -f initialize.sql
# psql -d postgres -U isdb -f show_all.sql
# python user_stories/us6-find-percent-nitro-complex-analytical.py
