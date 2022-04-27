function [] = graph_labels(str_array)
    % функция, настраивающая шрифт и подписи графика
    title(str_array(1));
    xlabel(str_array(2));
    ylabel(str_array(3));
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 14);
end

