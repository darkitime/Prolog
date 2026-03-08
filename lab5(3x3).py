import janus_swi
import random
import ast

def generate_board(n):
    board = list(range(n * n))
    random.shuffle(board)
    return board

def get_default_target(n):
    return list(range(1, n * n)) + [0]

# Подключаем Prolog файл
janus_swi.consult('lab5(3x3).pl')

print("Ввод размера поля N:")
n_val = int(input().strip())

# Генерируем стандартный таргет для введенного N
default_target = get_default_target(n_val)

print(f"\nСтандартная финальная доска: {default_target}")
print("Нажмите [Enter], чтобы использовать её, ИЛИ введите свой список:")
user_input = input().strip()

if user_input == "":
    target_val = default_target
    print("Используется стандартная доска.")
else:
    target_val = ast.literal_eval(user_input)
    print("Используется пользовательская доска.")

# Генерируем случайную начальную доску
current_board = generate_board(n_val)
print(f"\nНачальная доска: {current_board}")

query_str = "start(N, TargetBoard, Board, Path)"
inputs = {'N': n_val, 'TargetBoard': target_val, 'Board': current_board}

print("\nПроверка на разрешимость и поиск пути (пожалуйста, подождите)...")
res = janus_swi.query_once(query_str, inputs)

if res and res.get('truth'):
    print("\nРешение найдено!")
    print(f"Количество шагов: {len(res['Path']) - 1}")
    for step, state in enumerate(res['Path']):
        print(f"Шаг {step}: {state}")
else:
    print("\nРешение не существует (доска неразрешима).")