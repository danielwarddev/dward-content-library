Do we need to understand these concepts and terms in order to use AI effectively? Not strictly, no. However, you will be regularly confused by terms like "token" and "model," and may not be able to talk as intelligently about them in general. With language comes understanding, and with understanding comes confidence.

In general, I think it's a good idea to know a bit about how whatever tool you use works one level deeper than you use it. You don't have to know it intimately, but I find that knowing how things work "under the covers" a bit helps me use the tool better. 

What is an LLM? How do they work? How do they know so much stuff? What's a token and a model? This section is to answer all these questions, though it's not the main focus of the book.

In order to understand where we are, we need to understand a bit about where we came from. It may surprise you to know that we had computers solving English-worded math problems, playing checkers, and holding simple conversations as far back as the 1960s. What, then, was the catalyst for the AI explosion all the way in the 2020s? What took so long?

In 1950, Alan Turing made the Turing Test as a standard for computer intelligence. First, you have a human and a computer hold an English conversation with each other. Then, you print out that conversation and give it to a second human. If the second human can't tell which is the computer in the conversation and which is the human, then the computer has passed the test.

The Turing Test is still the standard for artificial intelligence today, even if we don't mention it explicitly. It's the question of, "is the computer indistinguishable from a human?" With LLMs, it often is, but as you know if you've used it enough, it's nowhere close to 100%.

This is true when we talk about games made with AI, as well. These do not use LLMs, but the intent is the same - we want the enemies to mimic human behavior. They do a pretty good job of it, too, in their limited context, and all through deterministic code.

In the 1960s, we had neural networks. These are still used by LLMs today, and they are the exact same concept as the original ones. Most computer programs are deterministic - they will produce the same output for the same input every single time, and they are written with code that does the same thing every single time. By contract, neural networks take inspiration from real brains and are made of connections of "neurons."

Each of these neurons is a very small math computation, and is in itself deterministic. However, when neural nets become very deep (AKA, lots of nodes), we run into a strange situation. Despite us being the ones who made it, and that we could say what a single neuron would produce, the overarching computation of the network becomes so impossibly complex that it's no longer possible to tell how a neural net produced the answer it did or why.

Ultimately, every computation in a neural net is a math computation. This is done by converting your words into semantic meaning, then converting that semantic meaning into vectors. How is this done? The answer is essentially brute force!

Neural networks had some limited success in the next decade or two. They played checkers, answered English math problems, and held conversations with humans. However, progress hit a wall after that, which largely would not be overcome until the late 2010s.

Neural networks were already established, but their potential hadn't been reached yet. There were two driving factors behind the AI explosion around 2020.

First is the raw compute power we have available now. Compared to a few decades ago, hardware now is laughably cheap and worryingly powerful. The fact that companies can throw money at the cloud now to scale that hardware up means AI could also scale up easily.

Second is the actual algorithm improvement. In 2017, Google published a research paper called, "Attention Is All You Need" which ultimately made current AI possible. It involved a new mechanism called an "attention block" that I won't go into here, but the summary is that it made processing input to the neural net both faster and in parallel. The intent of this paper was actually to make language translation possible, which makes sense.

After all, the marvel of current LLMs isn't that we can create semantic meaning out of anything, since that was around since the 1960s. The marvel is that we can convert that semantic meaning into English, both in and out.

So, back to the question: do LLMs "understand" in the same sense we do? After reviewing how LLMs work, I think this becomes rather a more philosophical question than a technical one. What does "understanding" mean, and what does it mean to have an idea? Anyway, if you want my personal answer, I don't believe LLMs do understand in the same way we do.

If you'd like to learn about this more in detail and from people who can explain it much better than I can, check out these sources:
- Oreilly owl book
- 3blue1brown
- Andrej Karpathy