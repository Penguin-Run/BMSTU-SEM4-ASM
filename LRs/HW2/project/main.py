import string

class CPPAnalyzer:
    def __init__(self, str_):
        self.str = str_
        self.counter = 0

    def validate_function_declaration(self):

        # skip part with void
        if self.str.split()[0] != 'void':
            return False
        self.skip_spaces()
        self.counter += 4

        syntax_states_description = {
            'void': 0,
            'void func_name': 1,
            'void func_name (': 2,
            'void func_name ( int': 3,
            'void func_name ( int a': 4,
            'void func_name ( int a )': 5,
            'void func_name ( int a );': 6,
            'error': 9
        }
        syntax_transitions_description = {'other': 0, 'identificator': 1, '(': 2, 'variable type': 3, ')': 4, ';': 5}
        syntax_table = [
            [9, 1, 9, 9, 9, 9],
            [9, 9, 2, 9, 9, 9],
            [9, 9, 9, 3, 5, 9],
            [9, 4, 9, 9, 9, 9],
            [9, 9, 9, 9, 5, 2],
            [9, 9, 9, 9, 9, 6],
        ]

        state = 0
        while True:
            self.skip_spaces()

            if state == 6:
                self.qq_6()
                return True
            if state == 9:
                self.qq_9()
                return False

            if self.str[self.counter] == '(':
                what = '('
                self.counter += 1
            elif self.validate_type():
                what = 'variable type'
            elif self.str[self.counter] == ')':
                what = ')'
                self.counter += 1
            elif self.str[self.counter] == ';':
                what = ';'
                self.counter += 1
            elif self.validate_name():
                what = 'identificator'
            else:
                what = 'other'

            if state == 0:
                self.qq_0()
            if state == 1:
                self.qq_1()
            if state == 2:
                self.qq_2()
            if state == 3:
                self.qq_3()
            if state == 4:
                self.qq_4()
            if state == 5:
                self.qq_5()

            state = syntax_table[state][syntax_transitions_description[what]]
            # print()

    def validate_name(self):
        letters = [s for s in string.ascii_letters] + ['_']
        digits = [str(d) for d in range(10)]
        splitters = [' ', ';', '(', ')']

        name_states_description = {'first letter of the name': 0,
                                   'inside name': 1,
                                   'end of the name': 2,
                                   'error': -1
                                   }
        name_transitions_description = {'letter': 0, 'digit': 1, 'splitter': 2, 'other': 3}
        name_table = [
            [1, -1, -1, -1],
            [1, 1, 2, -1]
        ]

        old_counter = self.counter

        state = 0
        name = []

        while True:
            if state == -1 or self.counter >= len(self.str):
                self.q_err(old_counter)
                return False
            if state == 2:
                self.q_2(name)
                return True

            if self.str[self.counter] in letters:
                what = 'letter'
            elif self.str[self.counter] in digits:
                what = 'digit'
            elif self.str[self.counter] in splitters:
                what = 'splitter'
            else:
                what = 'other'

            if state == 0:
                self.q_0(name)
            if state == 1:
                self.q_1(name)

            state = name_table[state][name_transitions_description[what]]
            #print()

    def validate_type(self):
        scalar_types = ['int', 'double', 'float', 'bool', 'char', 'unsigned char', 'unsigned int', 'long', 'long long']
        old_counter = self.counter

        for type in scalar_types:
            if self.str[self.counter: self.counter + len(type)] == type:
                self.counter += len(type)
                return True

        return False

    def q_err(self, old_counter):
        self.counter = old_counter

    def q_0(self, name):
        name.append(self.str[self.counter])
        self.counter += 1

    def q_1(self, name):
        name.append(self.str[self.counter])
        self.counter += 1

    def q_2(self, name):
        self.counter -= 1

    def skip_spaces(self):
        while self.counter < len(self.str) and self.str[self.counter] == ' ':
            self.counter += 1

    def qq_6(self):
        pass

    def qq_0(self):
        pass

    def qq_9(self):
        pass

    def qq_1(self):
        pass

    def qq_4(self):
        pass

    def qq_3(self):
        pass

    def qq_2(self):
        pass

    def qq_5(self):
        pass


while True:
    str_ = input()
    c = CPPAnalyzer(str_)
    if str_ == 'end':
        break

    if c.validate_function_declaration():
        print('Конструкция распознана')
    else:
        print('Обнаружена ошибка')



#    void func(int a; double feel; long looom);