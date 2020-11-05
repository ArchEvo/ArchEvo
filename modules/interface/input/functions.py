#!/usr/bin/python

import subprocess


def tty_width():
    h, w = subprocess.check_output('stty size', shell=True).decode().split(' ')
    return int(w)    


def print_request(request):
    print('\n\u001b[31m\u001b[1m' + request + '\u001b[7m\u001b[0m\n')


def print_head(head, request):
    line = '-'
    head_text = ''

    tty_w = tty_width()
    tty_w_half = tty_w / 2
    head_text_position = tty_w_half - (len(head) / 2)

    while len(line) < tty_w:
        line += '-'

    while len(head_text) < head_text_position:
        head_text += ' '
    head_text += head

    print('')
    print(line)
    print(head_text)
    print(line)
    print_request(request)
    return


def selection_table(data_list, spaces):
    max_len = 0
    for i in data_list:
        if len(i) > max_len:
            max_len = len(i)

    max_len += spaces

    max_entries_per_row = int(tty_width() / max_len)

    terminal_output = ''
    accu = ''
    count_terminal_output = ''
    for data in data_list:
        while len(data) < max_len:
            data += ' '

        count_terminal_output += data

        if accu != data[:1].lower():
            accu = data[:1].lower()
            data = '\u001b[36m\u001b[1m\u001b[4m' + data + '\u001b[7m\u001b[0m'

        terminal_output += data

        if (max_entries_per_row * max_len) == len(count_terminal_output):
            print(terminal_output)
            terminal_output = ''
            count_terminal_output = ''

    if terminal_output:
        print(terminal_output)
