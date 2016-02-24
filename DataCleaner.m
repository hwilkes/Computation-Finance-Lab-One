stockFiles = dir('stocks');
stockFiles = stockFiles(3:length(stockFiles),1);

duration = daysact('18-feb-2013',  '18-feb-2016');

genericHeaders = cellstr(['Date     ';'Open     ';'High     ';'Low      ';'Close    ';'Volume   ';'Adj Close']);
genericHeaders = genericHeaders';
for i=1:length(stockFiles)
    %stockData = xlsread(strcat('stocks/',stockFiles(i,1).name));
    
    [stockData,b,c]=xlsread(strcat('stocks/',stockFiles(i,1).name));
    dates=b(2:length(b),1);
    
    dates = flipud(dates);
    stockData = flipud(stockData);
    
    finalStockData = zeros(duration,length(stockData(1,:)));
    finalDates = cell(duration,1);
    
    averageValues = zeros(1,length(stockData(1,:)));
    
    for n=1:length(stockData)
       for x=1:length(stockData(n,:))
          averageValues(1,x) =  averageValues(1,x) + stockData(n,x);
       end
    end
    
    for x=1:length(averageValues(1,:))
          averageValues(1,x) =  averageValues(1,x)/length(stockData);
       end
    
    index = 2;
    oldDt = datetime(dates(1),'InputFormat','dd/MM/uuuu');
    olddays = 1;
    
    finalDates{1} = datestr(oldDt,'dd/mm/yyyy');
    for n=2:duration
        dt = datetime(dates(index),'InputFormat','dd/MM/uuuu');
        newDate = oldDt + caldays(1);
            
        finalDates{n} = datestr(newDate,'dd/mm/yyyy');
        oldDt = newDate;
    end
    
    for n=1:duration
        dateString = finalDates{n};
        index = -1;
        for x=1:length(dates)
            if(dates{x}==dateString)
               index = x;
               break;
            end
        end
        
        if index > -1
            finalStockData(n,:) = stockData(index,:);
        else 
            finalStockData(n,:) = averageValues(1,:);
        end
    end
    
    %outputMatrix = [finalDates num2cell(finalStockData)];
    csvwrite(strcat('imputed_stocks/',stockFiles(i,1).name),finalStockData);
    %dlmwrite(strcat('imputed_stocks/',strcat('_dates_',stockFiles(i,1).name)),finalDates);
    
    
end