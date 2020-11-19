# Code Lists

This repository contains documentation and codelists used in research using death certificates, vital statistics, EHR data, and insurnace claims.
<br><br>
All code lists in this repository are [licensed](blob/main/LICENSE) to allow reuse and modification.
<br><br>
Uncover more resrouces from the [Opioid Data Lab](https://www.opioiddata.org)
<br><br>
Want to share your own list? We'd love to see them! Contact us opioiddatalab@unc.edu or [open a new issue](https://github.com/opioiddatalab/Codelists/issues)
<br>

---

### Medications
NDC lists for additional [treatments](docs/treatments)
* [Opioid analgesics](docs/opioids/all_opioids) with [quick access CSV](docs/opioids/all_opioids/opioid_NDCs.csv) file
* [OxyContin](docs/opioids/ADFs/OxyContin/OxyContin_OC_OP.xlsx) before-after abuse deterrent
* [Abuse deterrent formulations](docs/opioids/ADFs) (ADF) with handy [human readable table](docs/opioids/ADFs/index.md)
* [Benzodiazepines](docs/treatments/benzodiazepines)
* [Antidepressants](docs/treatments/antidepressants)
* [Gabapentin](docs/treatments/gabapentin)
* [Ketamine](docs/treatments/ketamine)
* [Triptans](docs/treatments/triptans)
* [Medication-assisted treatment (MAT) for opioid use disorder (OUD)](docs/treatments/MAT_for_OUD)


### Diagnosis Codes

[Diagnostic codes](docs/diagnosis_codes) (ICD-9-CM and ICD-10-CM)

* [Cancer](docs/diagnosis_codes/cancer)
* [Mental health](docs/diagnosis_codes/mental_health) (e.g., depression, anxiety)
* [Pain](docs/diagnosis_codes/pain) 
* [Substance use disorder](docs/diagnosis_codes/MAT_for_OUD) (excluding OUD)
* [Opioid overdose (including cause of death)](docs/diagnosis_codes/opioid_overdose)
  * Codes come from [North Carolina Overdose Surveillance Definitions](https://www.injuryfreenc.ncdhhs.gov/DataSurveillance/poisoning/SummaryTableforPoisoningDefinitions-13Nov18-FINAL.pdf) and [GUIDE TO ICD-9-CM AND ICD-10 CODES RELATED TO POISONING AND PAIN](https://www.cdc.gov/drugoverdose/pdf/pdo_guide_to_icd-9-cm_and_icd-10_codes-a.pdf)
* [Opioid use disorder](docs/diagnosis_codes/opioid_use_disorder)


### Procedure codes

[Procedure (CPT) codes](docs/procedure_codes) for invasive surgeries and non-invasive procedures

 
---

Import code lists into SAS using URLs linked above<br>
`filename testurl url "https://github.com/opioiddatalab/Codelists/blob/main/docs/treatments/gabapentin/gabapentin_NDCs.csv";
proc import file=testurl out=work.gabapentin dbms=csv;
run;`
