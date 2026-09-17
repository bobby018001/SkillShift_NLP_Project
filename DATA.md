# Data setup

The project uses the Kaggle [LinkedIn Job Postings (2023–2024)](https://www.kaggle.com/datasets/arshkon/linkedin-job-postings) dataset and selected historical versions.

## Versions used

- Version 1
- Version 10
- Version 11
- Version 13 (primary/latest version used by the original project)

The original analysis found that earlier versions contained 2023 observations no longer present in later downloads. The R merge script compares and combines the relevant versions before Python analysis.

## Why data is excluded

Several source and merged CSV files are between roughly 129 MB and 657 MB. They are excluded because they exceed normal GitHub file limits and because redistribution should follow the source dataset's terms. Generated model files and the labeled dataset are excluded as reproducible artifacts rather than source code.

## Expected local layout

Keep downloaded and generated data in ignored directories such as:

```text
data/
├── raw/
│   ├── v01_postings.csv
│   ├── v10_postings.csv
│   ├── v11_postings.csv
│   └── v13_postings.csv
└── processed/
    ├── merged_postings.csv
    ├── merged_job_skills.csv
    ├── merged_job_industries.csv
    ├── merged_skills.csv
    └── merged_industries.csv
```

The historical scripts contain environment-specific paths. Update them before execution. Do not commit credentials, private Drive links, or downloaded source data.
