#!/usr/bin/env python
def gen_html_table_file(dict):
    table = '<table class="table"><tr>'
    for k in dict.keys():
        table += '<th>{}</th>'.format(k)
    table += '</tr>'
    for i in range(max([len(dict[k]) for k in dict.keys()])):
        table += '<tr>'
        for k in dict.keys():
            if len(dict[k]) <= i:
                table += '<td></td>'
            else:
                table += '<td>{}</td>'.format(dict[k][i])
        table += '</tr>'
    table += '</table>'
    return '''
        <html>
        <head>
            <link 
            rel="stylesheet" 
            href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
            />
        </head>
        <body>
        {}
        </body>
        </html>
        '''.format(table)

if __name__ == '__main__':
    lines = None
    with open('todo.txt', 'r') as f:
        lines = f.readlines()
        f.close()
    lines_str = ''.join(lines)
    vals = lines_str.split(':')[2::2]
    keys = lines_str.split(':')[1::2]
    tasks = {}
    for i in range(len(keys)):
        tasks[keys[i]] = filter(None, [v.rstrip() for v in vals[i].split('*')])
    html_str = gen_html_table_file(tasks)
    with open('todo.html', 'w') as f:
        f.write(html_str)
