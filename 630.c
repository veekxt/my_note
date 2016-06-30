
case in_start:
    if(OK)
    {
        stat = disp_loop;
    }
case disp_loop:
    if(net_is_normal)
    {
        if(which_times>=0 && which_times<5) {
            intensity(h, i);
        }else if (which_times>=5 && which_times<10) {
            status_transmitting(h);
        }else if (which_times>=10 && which_times<15) {
            status_video(h);
        }
        which_times += 1;
        if(which_times>=15) {
            which_times = 0;
        }
    }else {
        which_times = 0;
        vg_i_ctrl_t -> stage = NET_CONNECTING;
        //递归或者
        display_("正在连接");
    }

