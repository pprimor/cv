# Writing style for the CV

The CV is written in Pedro's own voice, taken from his MSc dissertation
*Optimization problems in the postal sector* (NOVA, September 2022), which predates
AI-assisted writing. The dissertation is the reference; this file is the summary of it.

## Habits of the voice

| Habit | Example from the dissertation |
|---|---|
| Explain the *why* behind a choice | "The decision to use a hierarchical algorithm instead of a simple clustering method was because most clustering methods take as parameters the number of clusters…" |
| Define a thing plainly before using it | "A segment is, simply put, an indivisible section of a route and is composed of a set of CP7s." |
| Lead with what a component *does*, in ordinary words | "The application server is the component which does all the hard work." |
| Concrete example after an abstraction | "For example, the delivery of a small package using a D+1 standard to a PO box is a viable flow." |
| Honest about what is unfinished | "Given the time frame, it was not possible to produce a fully-fledged integration system… What did, however, get built was a sample project…" |
| Real numbers, never invented | "In Alverca, for example, it accounts for 37.7%." |
| Oxford spelling | labour, centre, modelling, analyse, but optimization, organized |
| Earnest, slightly formal register; contractions rare | "That's why solving this problem and integrating the proposed model with SISMA is one of the most important contributions of this dissertation." |

The dissertation also signposts heavily (Firstly, Secondly, Moreover, Finally). The CV
drops that habit to stay short; everything else carries over.

## Rules for the CV

1. Full sentences with a subject. First person singular where the CV already implies it
   ("I built…"); the thing itself as subject otherwise ("The Jira integration links a proof to its issue…").
2. Every bullet says **what** was built or what it does, plus **one** reason or consequence.
   No bullet is a list of features alone.
3. Say what a product or plugin is for before naming the technology. Technology names appear
   once, at the end, and are not bolded.
4. Plain verbs: built, created, designed, made, moved, proposed.
   Avoid: shipped, own, primary engineer, leverage, spearhead, drive.
5. Unfinished work is stated as unfinished in the same breath: "is in final testing", "is in progress".
6. At most one "For example" in the whole document. No "Firstly / Secondly / Finally", no "Moreover".
7. Oxford spelling in English. European Portuguese in `cv_pt.tex`, transposed into the same voice
   rather than translated word for word.
8. No bold keywords in prose. Hyperlinks stay. The Skills section stays a list; it is data, not prose.
9. Both PDFs must stay at one A4 page (CI enforces it). If a rewrite overflows, trim the last
   PageProof bullet first, then the project's second bullet. Never shrink fonts or margins.
