function out = decoder(in)
rus = [1040:1103 1025 1105];            % russian code symbols
if numel(find(rus == max(abs(in)))) > 0 % if russian code symbol
out = in;
else                                    % decode from dos
a   = unicode2native(in,'windows-1251');
out = native2unicode(abs(a),'cp-866');
end
