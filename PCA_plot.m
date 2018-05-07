%--------------------------------------------------------------------------
% This script plots the variance vs. dimension for PCA result
%--------------------------------------------------------------------------

% Set the accuracy of the plot here
highest_variance = 0.95;
step_change = 0.005;

% Collect point data
PCA_count = zeros(highest_variance/step_change+1,2);
for step = 0 : step_change : highest_variance
    for reduction_count = 1 : size(latent_rate, 1)
        if latent_rate(reduction_count) > step
            PCA_count(uint8(step/step_change+1), 1) = reduction_count;
            PCA_count(uint8(step/step_change+1), 2) = step;
            break;
        end
    end
end

% Plot the figure
figure
plot(PCA_count(:,1), PCA_count(:,2))
xlabel('dimension')
ylabel('variance')
axis([0 inf 0 1]);
grid on
legend('variance')
title('Variance vs. Dimension')