class Scaler:
    def get_avg(self,data):
        avg = sum(data) / len(data)
        return avg

    def get_std(self,data):
        avg = self.get_avg(data)
        diff_list = [ (avg - x ) ** 2  for x in data ]
        var = sum(diff_list) / len(data) 
        return var ** 0.5  

    def fit_transform(self,data):
        pass
    def transform(self,data):
        pass
    
class StandardScaler(Scaler):
    def fit_transform(self,data):
        self.avg = self.get_avg(data)
        self.std = self.get_std(data)
        
        return self.transform(data)
    def transform(self,data):
        return [(x-self.avg) / self.std for x in data]
    
class MinMaxScaler:
    def __init__(self, data):
        self.data = data
        
    def fit(self):
        self.min = min(self.data)
        self.size = max(self.data) - self.min
        
    def fit_transform(self):
        self.fit()
        return self.transform()
    
    def transform(self):
        return [(x - self.min) / self.size for x in self.data]
    
    def inverse_transform(self):
        return [x * self.size + self.min for x in self.scaled_data]
    
