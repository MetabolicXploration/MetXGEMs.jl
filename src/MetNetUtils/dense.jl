# TODO: make a dense/sparse api
dense_vecs(net::MetNet) = MetNet(net; 
    lb = _dense(net.lb),
    ub = _dense(net.ub),
    c = _dense(net.c),
    b = _dense(net.b),
)