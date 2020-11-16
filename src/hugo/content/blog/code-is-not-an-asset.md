---
title: "Code Is Not An Asset"
date: "2020-10-21"
draft: false

---

Your software source code is not the asset that you might think it is. It is a
liability. More code means more liability. Are you making the right trade-offs?

Let me explain what I mean by “code is a liability”.

<!--more-->


{{< tallVimeo "479351595" >}}

In what follows, I use the term “tests” to refer to automated test software. I
use the term “code” to refer to software source that implements features but
that is not “tests”. In other words, “code” is non-test software.


### Technical Debt

In the software world, we have all heard of “technical debt”. It is some
property that your code has in some measure, and it is “paid down” with
software development efforts, such as code refactorings. Supposedly.

Who is to say whether a given line of code is part of a debt? Who is to say
whether a given programming language expression is debt-free? A given code
fragment is part of a debt depending on whether it impedes some further
improvement to the code, right? This is the opinion of the developer.

Or, does it depend merely on the context in which the code operates? Code that
was debt-free (and bug-free) when the software operated in one context becomes
debt-ridden (and buggy) when the software operates in a new context. (Example:
Y2K bugs.)

Context and opinion give code technical debt. So, any unit of code can become
debt. The best way to model code as a financial construct is to consider it all
debt.

But, “tech debt” is not really debt.


### Liabilities

Debt is easy to understand. It is a financial contract in which there is an
obligation to pay money (or some value) in the future. Everyone understands
debt because everyone has had debts.

Typically, one accrues debt via a loan. A loan is a kind of liability.
Liabilities are obligations.

Not all liabilities are loans. There can be other kinds of liabilities. One
kind is a “warranty liability”. This is a liability whose value represents the
possibility that products or services that your company has already sold (with
a warranty) are returned for repair or refund.

In accounting, liabilities are classified into “current” (short-term),
“non-current” (long term), and “contingent”.
A [contingent liability](https://www.investopedia.com/terms/c/contingentliability.asp)
is a liability that may or may not arise, depending on a certain event. An
example of a contingent liability is a pending lawsuit against your company for
$1M.

If you understand software development, then you know that without tests that
check your code for the presence of desirable features, the desirable features
may be absent. That is, code breaks. Bugs happen, and when they do, you must
pay the expense of fixing them.

So, code is a contingent liability.


### Tech Debt Is Really Unhedged Call Options

“Technical debt” is not like a loan. Loans have known repayment schedules and
amounts. Bugs arise from code at unknown times with unknown quantities of
effort that must be paid to correct them. This is not like a loan. “Tech debt”
is a misnomer - it is actually an unhedged call option, a kind of contingent
liability that must be paid at an unknown time at an unbounded cost. This is
explained by
[blogger Steve Freeman](https://www.higherorderlogic.com/2010/07/23/bad-code-isnt-technical-debt-its-an-unhedged-call-option/).


### Conclusion

In the world of software, the goal is working features, not lines of source
code. Working tests that prove the continued existence of those features behave
like assets. Code that produces those features is a liability.

Reduce your risk; balance code with tests.
