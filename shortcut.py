with open ("TPORT.txt", "w") as outfile:
    for i in range(1,16):
        st = "local TPort{} = {{map.TPort{}.Position.X, round_map.TPort{}.Position.Y, round_map.TPort{}.Position.Z}}\n".format(i,i,i,i)
        outfile.writelines(st)