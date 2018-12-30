# main

最外层配置,用于设置与具体业务无关的参数, 比如进程数,运行身份等等;

- `user` 运行身份,默认为 `nobody`;
- `worker_processes` 工作进程数,推荐与 CPU 数量相同,不确定时候,可使用 `auto`;
- `pid` 记录 pid 的文件位置;
- `error_log` 记录错误信息的文件位置, 级别 debug | info | notice | warn | error | alert | emerg;
- `worker_rlimit_nofile` 所有 web 进程能够打开的文件数，需要服务器也支持;
- `worker_cpu_affinity` `0001 0010` Linux only.使用该选项可以绑定 worker 进程和 CPU;
- `worker_priority` `on` 使用该选项可以给所有的 worker 进程分配优先值;
- `daemon` `off`是否以守护进程方式运行 nginx(需要编译配置添加 --width-debug);
- `master_process` `off` 是否以 master/worker 模型来运行;
