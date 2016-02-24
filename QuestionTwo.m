
ftsedata = csvread('ftse.csv',1,1);

filenames = dir('stocks');
%filenames = zeros(length(f),1);
filenames = filenames(3:length(filenames),1);

nums = randperm(length(filenames));
files = [];

stockOneFile = filenames(nums(1),1);
stockTwoFile = filenames(nums(2),1);
stockThreeFile = filenames(nums(3),1);

stockOne = csvread(strcat('fixed_stocks/',stockOneFile.name),1,1);
stockTwo = csvread(strcat('fixed_stocks/',stockTwoFile.name),1,1);
stockThree = csvread(strcat('fixed_stocks/',stockThreeFile.name),1,1);

stockOneLength = floor(length(stockOne)/2);
stockTwoLength = floor(length(stockTwo)/2);
stockThreeLength = floor(length(stockThree)/2);

returnsOne = zeros(stockOneLength,1);
returnsTwo = zeros(stockTwoLength,1);
returnsThree = zeros(stockThreeLength,1);

stockOneAverage = 0;
dayReturnOne = 0;
dayReturnTwo = 0;
dayReturnThree = 0;
for i=1:stockOneLength
    if i ~= 0
        oldReturn = dayReturnOne;
        dayReturnOne = stockOne(i,6)-oldReturn;
    end
    
    returnsOne(i) = dayReturnOne;
    stockOneAverage = stockOneAverage + dayReturnOne;
end
stockOneAverage = stockOneAverage/(stockOneLength);

stockTwoAverage = 0;
for i=1:stockTwoLength
    if i ~= 0
        oldReturn = dayReturnTwo;
        dayReturnTwo = stockTwo(i,6)-oldReturn;
    end
    
    returnsTwo(i) = dayReturnTwo;
    stockTwoAverage = stockTwoAverage + dayReturnTwo;
end
stockTwoAverage = stockTwoAverage/(stockTwoLength);

stockThreeAverage = 0;
for i=1:stockThreeLength
    if i ~= 0
        oldReturn = dayReturnThree;
        dayReturnThree = stockThree(i,6)-oldReturn;
    end
    
    returnsThree(i) = dayReturnThree;
    stockThreeAverage = stockThreeAverage + dayReturnThree;
end
stockThreeAverage = stockThreeAverage/(stockThreeLength);

expectedReturns = [stockOneAverage';stockTwoAverage';stockThreeAverage'];

returns = [returnsOne'; returnsTwo'; returnsThree'];
one = zeros(3,length(returns));
two = zeros(3,length(returns));
for i=1:length(returns)
    one(1,i) = (returns(1,i)-expectedReturns(1));
    one(2,i) = (returns(2,i)-expectedReturns(2));
    one(3,i) = (returns(3,i)-expectedReturns(3));
    
    two(1,i) = (returns(1,i)-expectedReturns(1));
    two(2,i) = (returns(2,i)-expectedReturns(2));
    two(3,i) = (returns(3,i)-expectedReturns(3));
end

C = one*two';
C = one*(two');
