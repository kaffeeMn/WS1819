#!/usr/bin/env python
import os
from copy import deepcopy

def gen_rst(pdf_list, path_list, header = ''):
    bullet_list = ''
    for i, pdf in enumerate(pdf_list):
        bullet_list += '    * :download:`{}<{}>`\n'.format(pdf, path_list[i])
    return '{}{}'.format(header, bullet_list)

def crawl(dir):
    files = []
    paths = []
    for root, _, dir_files in os.walk(dir):
        pdf_list = []
        path_list = []
        for f in dir_files:
            if f[-4:] == '.pdf' and 'UB' in root:
                pdf_list.append(f[:-4])
                relative = '../../'
                dirs = root.split('/')
                relative += '/'.join(dirs[dirs.index('UB'):])
                relative += '/'
                path_list.append('{}{}'.format(relative, f))
                
        if path_list != []:
            rst_str = gen_rst(pdf_list, path_list)
            files.append(deepcopy(rst_str))
            paths.append(
                '{}/rst/source/ubs.rst'.format(
                    root.split(dir)[1].split('/')[0]
                )
            )

    return files, paths

def write(file_str, file_paths):
    header = 'UBs\n===\n\n'
    for fp in file_paths:
        with open(fp, 'w') as f:
            f.write(header)
    for fs, fp in zip(file_str, file_paths):
        with open(fp, 'a') as f:
            f.write(fs)

if __name__ == '__main__':
    files, paths = crawl('./')
    write(files, paths)
    print('wrote:\n\n')
    for f, p in zip(files, paths):
        print('{}\t> {}\n'.format(f,p))
