# SkillShift NLP Project

SkillShift analyzes how AI-related skill demand appears in LinkedIn job postings. The project combines multiple versions of a public Kaggle dataset, builds a text-based AI-exposure score, compares labor-market segments, and trains a classifier as a validation exercise.

> Team course project for DSO 560 (Spring 2026). This repository publishes the reproducible code path. Large source datasets, generated models, notebook outputs, and course submission files are intentionally excluded.

## Research questions

- Which industries show the largest changes in AI exposure?
- How does AI exposure vary across roles and experience levels?
- Which skills are most common among postings with different exposure levels?

## Method

1. Merge selected Kaggle dataset versions to recover postings from June 2023 through April 2024.
2. Clean and join postings with industry and skill mappings.
3. Build an AI lexicon from literature-derived terms and LLM-assisted candidate extraction.
4. Vectorize job descriptions and the AI reference text with TF-IDF.
5. Use cosine similarity as a continuous AI-exposure score.
6. Label zero-score postings as non-AI, and split positive scores at the 75th percentile into low- and high-exposure groups.
7. Train a class-weighted logistic-regression model on TF-IDF features and analyze trends by industry, experience level, title, and skill.

## Repository structure

```text
SkillShift_NLP_Project/
├── data/
│   └── reference/
│       └── ai_keywords.csv
├── notebooks/
│   └── skillshift_analysis.ipynb
├── scripts/
│   └── merge_kaggle_versions.R
├── .gitignore
├── DATA.md
├── requirements.txt
└── README.md
```

## Run locally or in Colab

1. Download the required Kaggle versions described in [DATA.md](DATA.md).
2. Use `scripts/merge_kaggle_versions.R` to merge the source versions. Update its input/output paths for your machine.
3. Place generated files under `data/processed/` using the filenames expected by the notebook.
4. Install the Python dependencies:

   ```bash
   pip install -r requirements.txt
   ```

5. Open `notebooks/skillshift_analysis.ipynb`, update `data_path`, and run cells from top to bottom.

The notebook was originally developed in Google Colab. Its outputs and Colab execution metadata have been removed from the public version to avoid publishing user identifiers and sampled job-description text.

## Reported result

The original team run used approximately 144,000 cleaned postings. The validation classifier reported accuracy `0.9770` and F1 `0.9882`. These values are historical notebook outputs, not a guarantee of independent generalization: the target label is derived from the same TF-IDF-based exposure pipeline used to construct the input representation. A stronger follow-up evaluation should use independently annotated labels and temporal or out-of-domain validation.

## Limitations

- Job postings are not a representative census of labor demand.
- Dataset coverage is uneven across industries, experience levels, and months.
- A lexicon-based similarity score may capture broad technical language rather than causal exposure to generative AI.
- The high-exposure cutoff is relative to this dataset.
- LLM-assisted lexicon expansion may introduce model-specific selection bias.
- The analysis is observational and does not establish that AI caused changes in hiring demand.

## Contribution scope

This was a team project. The repository owner primarily contributed to the coding portion of the project. More granular ownership should be documented only where it can be verified from team records or commit history.

## Data and attribution

The source data is the Kaggle **LinkedIn Job Postings (2023–2024)** dataset by Arshkon. Source data is not redistributed here; obtain it directly from Kaggle and follow the dataset's license and terms. See [DATA.md](DATA.md).

No standalone license is currently attached to this repository. The project code remains under its authors' copyright unless the team agrees on a license.
