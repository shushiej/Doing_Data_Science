### Naive Bayes Theorem

Naive Bayes is a linear classification method that works with probabilities to determine the accuracy of an event.

```
p(y|x) = ( p( x | y ) * p( y ) / p( x ) )
```

#### Spam or Ham
Let's say we have 100,000 emails and we needed to classify whether the email was spam or not spam (ham).
Applying Naive Bayes:

```
p(spam | word) = ( p(word|spam) * p(spam) / p(word))
```

The `p(word)` is given by:

```
p(word) = p(spam | word)*p(spam) + p(ham |  word) * p(ham)
```

Lets put some numbers to this. Let's try to find some common words that occur in emails. For example `meetings`. The word meetings occurs in the spam text 16 times, and it appears in the ham folder 153 times. 

Lets say 
* `p(spam)` = 1500 / (1500 + 3672) = `0.29 (29%)`
* `p(ham)` = 1 - `p(spam)` = `0.71 (71%)`
* `p(meeting | spam)` = 16 / 1500 = `0.0106 (0.106%)`
* `p(meeting | ham)` = 153 / 3672 = `0.0414 (4.16%)`
* `p(spam | meeting)` = `p(meeting | spam) * p(spam) / p(meeting)` = (0.0106 * 0.29) / (0.0106 * 0.29 + 0.0416* 0.71) = 0.09 = 9%
  
We can repeat this process for every word