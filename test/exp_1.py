import sys
from eth_abi import encode
import mpmath

mpmath.mp.dps = 50

try:
    x = int(sys.argv[1])
    
    # 严格对齐 Solidity 合约中的下溢阈值 (-0x4000000000000000 对应的十进制是 -4611686018427387904)
    # 如果你的 Solidity 阈值不同，把下面这里改成对应的数值
    if x <= -0x4000000000000000:
        result = 0
    else:
        LOG2_E = 0x171547652B82FE1777D0FFDA0D23A7D12
        scaled_x = (x * LOG2_E) >> 128
        
        if scaled_x < -1000 * (1 << 64):
            result = 0
        else:
            val = mpmath.mpf(scaled_x) / mpmath.power(2, 64)
            res_mp = mpmath.power(2, val) * mpmath.power(2, 64)
            result = int(res_mp)
except Exception:
    result = 0

encoded = "0x" + encode(["int128"], [result]).hex()
print(encoded)