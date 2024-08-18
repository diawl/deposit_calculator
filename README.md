# deposit_calculator

## Installation
-----------

### Install Ruby 3.2.3

See [this ruby install guide ](https://www.ruby-lang.org/en/documentation/installation/) for instructions.

### Install bundler
```
gem install bundler
```
### Install gems needed
```
bundle install
```

## Run the app
------------
### See options
```
ruby app.rb -h
```

### Run calculator
```
ruby app.rb -d 10000 -r 5 -t 59 -c year
```

## Test the app
------------

### Run tests
```
rspec
```

## Constraints and Assumptions
---------------------------
- The smallest interst cycle is a month.
- Results will be rounded to integer.
- Deposits range from 1,000 to 1,500,000. The input must be a positive number. 
- The interest rate from the input is treated as an annual percentage rate, i.e. 1.15 means 1.15% p.a.
- The term from the input is treated as number of months and it ranges from 3 to 60. Only integer number will be accepted.
- The interest paymen cycle input allows values of `month`, `quarter`, `year`, or `at_maturity`.
- For interest paid at maturity, there is no compound interest. The final balance is calculated as `deposit * (1 + (months_in_term * annual_rate / 12))`.
- For interest paid monthly, the interest is reinvested, and the final balance is calculated as `deposit * (1 + annual_rate / 12) ^ months_in_term`.
- For interest paid quarterly or annually, the term might not be an integer number of interest cycles. For example, if the term is 13 months and interest is paid quarterly, there will be an extra month after the 4th quarter. Interest for this remaining period, which is less than a full cycle, will be calculated using a monthly rate. 
- This monthly rate is calculated as `(1 + months_in_interest_cycle * annual_rate / 12) ^ 1/months_in_interest_cycle`. It works as if it's reinvesting every month, and by the end of an interest cycle, the total interest earned would be the same as if calculated using a quarterly or annual rate.