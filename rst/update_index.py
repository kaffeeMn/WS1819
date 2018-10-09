#!/usr/bin/env python
import os
import os.path as path

def gen_page(li):
    return '''
<head>
    <link 
        rel="stylesheet" 
        href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        />
</head>
<body>
    <div class="jumbotron mx-3 my-3">
        <H1 class="display-3">MODULES</H1>
        <div class="list-group">
            <a class="list-group-item list-group-item-action list-group-item-warning" 
                href="todo.html"
                >TODO</a>
            {}
        </div>
    </div>
</body>
</html>
    '''.format(''.join(li)).strip()

if __name__ == '__main__':
    dir = path.dirname(path.realpath(__file__))
    modules = [m 
        for m in os.listdir(dir) 
        if path.isdir('{}/rst/build/html'.format(m))
        ]
    index_html = ['index.html' in os.listdir('{}/rst/build/html'.format(m)) 
        for m in modules
        ]
    li_str = []
    for i, m in enumerate(modules):
        if index_html[i]:
            li_str.append(
                '''
                <a 
                class="list-group-item  
                    list-group-item-action 
                    list-group-item-success
                    " 
                href="{}/rst/build/html/index.html"
                >
                    {}
                    </a>
                '''.format(
                    m, m.split('/')[0]
                    )
                )
    index = gen_page(li_str)
    with open('index.html', 'w') as out:
        out.write(index)
