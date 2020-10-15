data {
  int<lower=0> N;              // num individuals
  int<lower=1> K;              // num predictors
  int<lower=1> DZ;             // num latent factors
  matrix[N, K] x;
  vector[N] y;
}

parameters {
  vector[DZ] Z[N];
  real<lower=0> sigma_x;
  real<lower=0> sigma_y;
  matrix[K, DZ] weights_x;
  vector[DZ] weights_y;
}

transformed parameters {
  vector[N] mu_y;
  for (i in 1:N)
    mu_y[i] = dot_product(Z[i], weights_y);
}

model {
  target += cauchy_lpdf(sigma_x | 0, 2.5);
  target += cauchy_lpdf(sigma_y | 0, 2.5);
  target += normal_lpdf(weights_y | 0, 5);
  target += normal_lpdf(to_vector(weights_x) | 0, 5);

  for (i in 1:N) {
    target += std_normal_lpdf(Z[i]);
    target += normal_lpdf(x[i] | weights_x * Z[i], sigma_x);
  }
  target += normal_lpdf(y | mu_y, sigma_y);
}
