function showGraphRC(t, ksi)
    ksi = ksi(:,1:4);
    plot(t,ksi);
    xlabel('Time');
    ylabel('Offset');
    legend('alpha','beta','x','y');
end
