import soundfile
import matplotlib.pyplot as plt

import os
os.chdir(os.path.dirname(os.path.realpath(__file__)))

samples, sample_rate = soundfile.read("1100Hz.wav")
plt.plot(samples)
print("Shape of samples:", samples.shape)  # 显示数组的维度
print("Number of dimensions:", samples.ndim)  # 显示维度数
print("Size of samples:", samples.size)  # 显示元素总数
print(sample_rate)
plt.show()