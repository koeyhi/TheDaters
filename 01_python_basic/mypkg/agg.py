def get_std(num_list):
    avg = sum(num_list) / len(num_list)
    dev_list = []
    for num in num_list:
        dev = (num - avg) ** 2
        dev_list.append(dev)

    var = sum(dev_list) / len(dev_list)
    return var ** 0.5