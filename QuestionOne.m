portfolios = zeros(100,3);
expectedvalues = zeros(100,1);
variances = zeros(100,1);

m = [0.10;0.20;0.15];

C = [0.005, -0.010, 0.004; -0.010, 0.040, -0.002; 0.004, -0.002, 0.023];

for n = 1:100
    nums = rand(3,1);
    factor = 1/(nums(1) + nums(2) + nums(3));
    nums(1) = (nums(1)*factor);
    nums(2) = (nums(2)*factor);
    nums(3) = (nums(3)*factor);
    portfolios(n,:) = nums;
    
    e = transpose(nums) * m;
    v = transpose(nums) * C * nums; 
    
    variances(n,:) = v;
    expectedvalues(n,:) = e;
end

figure
scatter(variances,expectedvalues);