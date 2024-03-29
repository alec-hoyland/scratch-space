function [betas] = LevenbergMarquardt2D(x, y, fcn, mu, mu_scale, initial, nIters)
  % nonlinear least-squares fitting

  if ~exist('nIters', 'var')
    nIters = 100;
  end

  betas   = NaN(nIters, length(initial));
  betas(1, :) = initial;
  norm00  = NaN;

  for ii = 2:nIters
    % unpack outputs from input function
    [yhat, J] = fcn(betas(ii-1, :), x(:, 1), x(:, 2));
    J0    = J';
    % compute deviance
    b0    = y - yhat;
    % compute residual
    dx    = mldivide(J0' * J0 + mu * eye(size(J0,2)), J0' * b0);
    r0    = b0 - J0 * dx;
    norm0 = sum(r0.^2);

    % evaluate norm-squared of residual
    for qq = 1:5
      btemp     = betas(ii-1, :) + dx';
      residual  = y - fcn(btemp, x(:, 1), x(:, 2));
      res_norm  = sum(residual.^2);

      if res_norm < norm0
        % update the x-vector
        betas(ii, :) = btemp;
        % decrease trust factor
        mu      = mu / mu_scale(2);
        % terminate inner loop
        break
      else
        % increase trust factor
        mu      = mu * mu_scale(1);
        % compute residual
        dx      = mldivide(J0' * J0 + mu * eye(size(J0, 2)), J0' * b0);
        r0      = b0 - J0 * dx;
        norm0   = sum(r0.^2);

        % give up if qq = 5
        if qq == 5
          % update x regardless
          betas(ii, :) = btemp;
          % terminate inner loop
          break
        end % qq == 5

      end % res_norm < norm0

    end % qq

    % print results
    disp(['[ITER #' num2str(ii-1) '] betas: ' mat2str(betas(ii, :)) ' norm(r): ' num2str(norm0) ' m: ' num2str(qq) ' mu: ' num2str(mu)])

    % check for convergence
    if abs(norm0 - norm00) < 0.0001
      disp('[INFO] solution converged')
      break
    else
      norm00 = norm0;
    end

  end %% ii

  % post-processing
  betas     = reshape(nonnans(betas), [], length(initial));

end % function
