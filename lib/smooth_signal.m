function [signal_smooth, time_out] = smooth_signal(signal, time, n)
    signal_smooth = zeros(length(signal) - n + 1, n);
    for ii = 1:n
        signal_smooth(:, ii) = signal(ii:end - n + ii);
    end
    signal_smooth = mean(signal_smooth, 2);
    time_out = time(1:end - n + 1);
end