% Encoder
encoder_freq = 1e4;
encoder_Tss = 1/encoder_freq;
encoder_resol = 2000;
encoder_cnt_init = 2^24;

% PMW
pwm_Ts =  1e-5;
pwm_timer_period = floor(1e8*pwm_Ts/2);
pwm_set_point = floor(pwm_timer_period/2);