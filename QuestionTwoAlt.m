startDate = '18/02/2013';
endDate = '18/02/2016';

c = yahoo;
d = fetch(c,'ARM',endDate,startDate);
close(c);