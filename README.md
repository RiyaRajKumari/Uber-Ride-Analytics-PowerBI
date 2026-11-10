# 🚗 Uber Ride Bookings Intelligence Platform (Power BI)

An enterprise-grade, end-to-end Business Intelligence analytics project evaluating **150,000+ ride-hailing bookings**. This project investigates booking fulfillment, multi-modal fleet dynamics, operational friction, driver vs. customer cancellations, geospatial demand patterns, and top-line revenue realization.

---

## 📌 Executive Summary
Urban ride-hailing platforms operate in high-volatility environments marked by sharp peak-hour demand surges, localized driver supply deficits, and substantial cancellation friction. This project delivers an executive dashboard suite tracking operational health, route corridor efficiency, cancellation root causes, and revenue realization across a multi-modal fleet (*Auto, Bike, eBike, Go Mini, Go Sedan, Premier Sedan, and Uber XL*).

### 🌟 Key Performance Highlights (Full Dataset)
* **Total Ride Bookings Evaluated**: 150,000
* **Gross Fulfilled Revenue**: ₹5.18+ Crores (51.85M)
* **Booking Success Rate**: 62.07% (93,000 completed rides)
* **Driver-Side Cancellations**: 18.0% (27,000 trips) — *Largest operational bottleneck*
* **Customer-Side Cancellations**: 7.0% (10,500 trips)
* **Unmet Demand ("No Driver Found")**: 7.0% (10,500 trips)
* **Incomplete Rides**: 6.0% (9,000 trips)
* **Overall Customer Satisfaction**: 4.41 / 5.0 ★

---

## 🎯 Project Objectives

The primary objective of this project is to develop an enterprise-grade Business Intelligence platform that diagnoses operational inefficiencies, quantifies revenue leakage, and evaluates fleet performance across **150,000+ urban ride bookings**.

### Specific Objectives:
1. **Fulfillment & Drop-Off Analysis**: Measure the platform's baseline booking conversion rate (62.07%) and quantify the volume of unfulfilled demand resulting from cancellations and driver deficits.
2. **Fleet Mix & Revenue Contribution**: Analyze revenue realization and trip volume across seven distinct vehicle segments (*Auto, Bike, eBike, Go Mini, Go Sedan, Premier Sedan, Uber XL*) to evaluate multi-modal fleet efficiency.
3. **Cancellation Forensics**: Conduct a root-cause investigation into the disparity between driver-side cancellations (18%) and customer-side cancellations (7%) to identify friction points.
4. **Temporal Demand Profiling**: Map 24-hour demand rhythms to identify peak operational stress windows (morning commute vs. evening rush).
5. **Financial Leakage Quantification**: Model and estimate gross revenue lost to unfulfilled booking requests and analyze commuter payment preferences (UPI, Cash, Wallet, Cards).
6. **Actionable Strategic Interventions**: Provide leadership with concrete, data-backed operational recommendations to enhance driver retention and commuter satisfaction.

---

## 🔬 Methodology & Technical Architecture

This project followed a rigorous 6-stage Business Intelligence and Data Analytics lifecycle:
┌──────────────────┐ ┌──────────────────┐ ┌─────────────────┐ │ 1. Data Ingestion│ ──> │ 2. Power Query │ ──> │ 3. Star Schema │ │ (150K Rows) │ │ ETL & Feature │ │ Modeling │ └──────────────────┘ └──────────────────┘ └─────────────────┘ │ ┌──────────────────┐ ┌──────────────────┐ ▼ │ 6. Strategic │ <── │ 5. Executive UI │ <── ┌─────────────────┐ │ Insights │ │ Dashboard UX │ │ 4. DAX Measures │ └──────────────────┘ └──────────────────┘ │ & Calculations│ └─────────────────┘


### Stage 1: Data Profiling & Audit
* **Dataset Scope**: Evaluated 150,000 ride booking logs covering 21 transactional attributes (timestamps, booking outcomes, vehicle types, geospatial hubs, operational turnaround times, fare values, customer/driver ratings, and cancellation reasons).
* **Anomaly Identification**: Identified literal text `"null"` strings, extra quotation marks on alphanumeric IDs, and conditional missingness across cancellation and payment fields.

### Stage 2: ETL & Power Query Transformation (M Code)
* **Data Cleansing**: Stripped nested quotes from `Booking ID` and `Customer ID` using `Text.Replace`.
* **Null Handling**: Replaced literal string `"null"` with native database nulls across numeric columns, preserving mathematical accuracy in `AVERAGE()` calculations. Replaced missing categorical values with clean labels (`"Not Applicable"`, `"Unpaid / Cancelled"`).
* **Feature Engineering**:
  * `Hour`: Extracted hourly integer (0–23) from booking timestamps.
  * `Time Slot`: Categorized rides into *Morning Peak (6–11 AM)*, *Mid-Day (11 AM–5 PM)*, *Evening Peak (5–10 PM)*, and *Night (10 PM–6 AM)*.
  * `Day Type`: Classified records into *Weekday* vs. *Weekend*.
  * `Distance Category`: Binned trips into *Short (<5 km)*, *Medium (5–15 km)*, *Long (15–30 km)*, and *Very Long (>30 km)*.

### Stage 3: Dimensional Data Modeling (Star Schema)
* **Fact Table (`Fact_RideBookings`)**: Contains transactional trip metrics, fares, ratings, and foreign keys.
* **Dimension Table (`Dim_Date`)**: Dedicated M-generated calendar table (2024-01-01 to 2024-12-31) connected via a **1-to-Many active relationship** to ensure robust Time Intelligence.
* **Column Sorting Integrity**: Applied `Month Number` sorting to `Month Name` and `Day of Week` sorting to `Day Name` to prevent alphabetical distortion.
* **Measures Group**: Created an isolated `_Measures` table housing all business KPIs for modular governance.

### Stage 4: DAX Business Logic Formulation
* Authored 15+ measures covering volume, fulfillment rates, driver/customer cancellation rates, revenue, and turnaround times.

### Stage 5: UI/UX Design & Executive Dashboards
* **Theme Engineering**: Injected a custom theme (`MetroPulse_Theme.json`) with an executive corporate palette (`#2563EB`, `#10B981`, `#F59E0B`, `#EF4444`), rounded card corners (`8px`), and subtle drop shadows (`transparency: 92%`).
* **Multi-Page Architecture**: Partitioned analytical workflows into 4 specialized pages.
* **Interactive Navigation**: Implemented an intuitive top Page Navigator and synchronized slicers.

### Stage 6: Business Synthesis & Strategic Recommendations
* Synthesized quantitative metrics into strategic operational takeaways addressing driver supply shortages, surge pricing strategies, and turnaround time (VTAT) thresholds.

---

## 📊 Dashboard Architecture & Page-by-Page Walkthrough

### Page 1: Executive Summary (Macro Performance & Demand Pulse)
* **Purpose**: Serves as the executive control tower, offering leadership a real-time pulse of platform health, conversion rates, and hourly demand.
* **Key Components**:
  * **Top KPI Cards**: Total Bookings (66K–150K), Fulfilled Revenue (₹22.76M–₹51.85M), Booking Success Rate (62.07%), and Average Customer Rating (4.41 ★).
  * **Booking Outcome Distribution (Donut Chart)**: Visually partitions the 150,000 requests into Completed (62%), Driver Cancelled (18%), Customer Cancelled (7%), No Driver Found (7%), and Incomplete (6%).
  * **24-Hour Demand Rhythm (Area Chart)**: Displays the diurnal rhythm of ride requests. Highlights high-stress surge windows during the evening office commute (5:00 PM – 9:00 PM).
  * **Interactive Controls**: Date range timeline slider, Vehicle Type dropdown slicer, and Page Navigation bar.

### Page 2: Fleet & Route Performance (Mobility Hierarchy & High-Demand Hubs)
* **Purpose**: Evaluates multi-modal fleet utilization, commercial contribution by vehicle category, and transit corridor behavior.
* **Key Components**:
  * **Revenue & Bookings by Vehicle Type (Clustered Column Chart)**: Benchmarks the commercial contribution of each vehicle category. Demonstrates that Auto is the top gross revenue generator (~₹1.3 Cr), followed by Go Mini (~₹1.04 Cr) and Go Sedan (~₹0.94 Cr).
  * **Top 10 High-Demand Pickup Hubs (Horizontal Bar Chart)**: Identifies major transit nodes (e.g., IGI Airport, Cyber Hub Gurgaon, Noida Sector 62, AIIMS).
  * **Fleet Mix by Distance Category (Stacked Column Chart)**: Proves fleet specialization—two-wheelers and autos dominate micro-trips (<5 km), while sedans and XL vehicles dominate long-haul intercity/airport corridors (>20 km).

### Page 3: Cancellation Analysis (Operational Friction & Root Causes)
* **Purpose**: Investigates the primary operational friction point: why 38% of booking requests fail to complete.
* **Key Components**:
  * **Operational KPIs**: Driver Cancelled Rides (27K / 18%), Customer Cancelled Rides (10.5K / 7%), and Average Vehicle Arrival Time (8.46 mins).
  * **Driver Cancellation Reasons (Bar Chart)**: Isolates the top driver rejection triggers (*Personal/car issues, passenger count violations, sick passengers*).
  * **Customer Cancellation Reasons (Bar Chart)**: Breaks down passenger churn drivers (*Driver not moving to pickup, driver requested cancellation, long ETA*).
  * **Cancellations by Vehicle Category (Clustered Column Chart)**: Compares Driver vs. Customer cancellations side-by-side, proving drivers cancel nearly 3x more often across all fleet categories.

### Page 4: Revenue & Ratings (Financial Realization & Quality Benchmarks)
* **Purpose**: Connects financial realization, payment channel adoption, and customer/driver satisfaction metrics.
* **Key Components**:
  * **Revenue & Quality KPIs**: Fulfilled Revenue (₹51.85M), Average Trip Fare (₹557), Average Customer Rating (4.38 ★), and Average Driver Rating (4.37 ★).
  * **Payment Method Distribution (Donut Chart)**: Analyzes transaction channels, highlighting the heavy dominance of **UPI (45%)** and **Cash (25%)**.
  * **Driver vs. Customer Rating by Vehicle (Column Chart)**: Compares mutual satisfaction scores across vehicle types, showing consistent ratings between 4.3 and 4.5.
  * **Monthly Revenue Trajectory (Line Chart)**: Tracks gross booking value month-over-month throughout 2024.

---

## 📈 Detailed Analytical Results & Findings

### 1. Overall Operational Performance Breakdown
| Metric | Value | % of Total | Business Significance |
| :--- | :--- | :--- | :--- |
| **Total Booking Requests** | **150,000** | 100.0% | Total market demand logged across the network. |
| **Fulfilled / Completed Rides** | **93,000** | **62.07%** | Successful platform conversion rate. |
| **Driver-Side Cancellations** | **27,000** | **18.00%** | **Primary operational bottleneck** (2.57x higher than rider cancels). |
| **Customer-Side Cancellations** | **10,500** | **7.00%** | Churn driven by wait times and driver non-movement. |
| **Unmet Demand ("No Driver Found")** | **10,500** | **7.00%** | Pure supply deficit during sudden demand spikes. |
| **Incomplete Trips** | **9,000** | **6.00%** | Mid-trip terminations (breakdowns, disputes). |

---

### 2. Fleet Revenue & Contribution Hierarchy
| Vehicle Category | Fulfilled Revenue | Strategic Role in Fleet |
| :--- | :--- | :--- |
| **Auto** | **~₹1.30 Crores (13.0M)** | **Top Revenue Engine**: High turnover, affordable, city-wide commuter transit. |
| **Go Mini** | **~₹1.04 Crores (10.4M)** | **Core 4-Wheeler**: Reliable, AC economy commute for professionals. |
| **Go Sedan** | **~₹0.94 Crores (9.4M)** | **Mid-Tier Premium**: Favored for longer commutes and family travel. |
| **Bike** | **~₹0.80 Crores (8.0M)** | **Micro-Mobility Leader**: Fast navigation through traffic-dense corridors. |
| **Premier Sedan** | **~₹0.63 Crores (6.3M)** | **High-Yield Tier**: Highest average fare-per-trip and top customer ratings. |
| **eBike** | **~₹0.36 Crores (3.6M)** | **Fast-Growing Clean Fleet**: Zero-emissions micro-transit. |
| **Uber XL** | **~₹0.15 Crores (1.5M)** | **Group Transit**: Lowest volume due to fleet supply constraints. |

---

### 3. Cancellation Forensics & Root-Cause Analysis

#### Driver Cancellation Drivers (27,000 Total Trips)
1. **Customer-Related Issues** (~6,837 rides): Commuter delay at pickup or inability to locate.
2. **Passenger Health Concerns** (~6,751 rides): Drivers declining passengers who were visibly unwell.
3. **Personal & Vehicle Contingencies** (~6,726 rides): Mechanical issues, fuel stops, or personal emergencies.
4. **Capacity Violations** (~6,686 rides): Passengers attempting to exceed vehicle capacity limits.

#### Customer Cancellation Drivers (10,500 Total Trips)
1. **Pickup Location / Wrong Address** (~2,362 rides)
2. **Change of Plans** (~2,353 rides)
3. **Driver Not Moving Towards Pickup** (~2,335 rides)
4. **Driver Requested Cancellation** (~2,295 rides)
5. **Air Conditioning Issues** (~1,155 rides)

---

### 4. Financial Realization & Payment Method Share
* **Gross Fulfilled Revenue**: **₹5.18+ Crores**
* **Estimated Revenue Leakage**: **₹2.5+ Crores** lost to unfulfilled bookings (Driver Cancels + Customer Cancels + No Driver Found).
* **Payment Method Distribution**:
  * **UPI**: **45.0%** (Dominant digital channel)
  * **Cash**: **24.9%** (Significant physical cash usage remains)
  * **Uber Wallet**: **12.0%**
  * **Credit & Debit Cards**: **18.1%** combined
* **Turnaround Time (VTAT) Impact**: Average vehicle arrival time is **8.46 minutes**. When arrival times exceed **10 minutes**, customer cancellation probability increases by over 40%, and ratings fall below 4.1.

---

## 🛠️ Data Modeling & DAX Formulas

### Star Schema Architecture
* **Fact Table**: `Fact_RideBookings` (150,000 rows, 21 attributes)
* **Dimension Table**: `Dim_Date` (Calendar dimension with custom Year, Quarter, Month, Day, and Weekday sorting)
* **Measures Group**: Dedicated `_Measures` table housing all business logic

### Key DAX Measures
```dax
// 1. Volume & Fulfillment
Total Bookings = COUNTROWS('Fact_RideBookings')

Completed Bookings = 
CALCULATE(
    COUNTROWS('Fact_RideBookings'), 
    'Fact_RideBookings'[Booking Status] = "Completed"
)

Booking Success Rate % = 
DIVIDE([Completed Bookings], [Total Bookings], 0)

// 2. Financials
Fulfilled Revenue = SUM('Fact_RideBookings'[Booking Value])

Avg Trip Fare = AVERAGE('Fact_RideBookings'[Booking Value])

// 3. Cancellation Forensics
Driver Cancelled Rides = 
CALCULATE(
    COUNTROWS('Fact_RideBookings'), 
    'Fact_RideBookings'[Booking Status] = "Cancelled by Driver"
)

Driver Cancellation Rate % = 
DIVIDE([Driver Cancelled Rides], [Total Bookings], 0)

Customer Cancelled Rides = 
CALCULATE(
    COUNTROWS('Fact_RideBookings'), 
    'Fact_RideBookings'[Booking Status] = "Cancelled by Customer"
)

// 4. Operational Turnaround & Quality
Avg Vehicle Arrival Time = AVERAGE('Fact_RideBookings'[Avg VTAT])
Avg Customer Rating = AVERAGE('Fact_RideBookings'[Customer Rating])
Avg Driver Rating = AVERAGE('Fact_RideBookings'[Driver Ratings])

## 💡 Strategic Business Recommendations
Dynamic Peak-Hour Driver Incentives: Driver cancellations peak heavily between 5:00 PM and 9:00 PM. Introducing targeted surge incentives during this 4-hour window can reclaim up to ₹15M in lost gross booking value.
Turnaround Time (VTAT) Reduction: Data demonstrates customer cancellation risk spikes when driver ETA exceeds 9 minutes. Implementing tighter geo-fenced dispatching in dense commercial hubs will drastically reduce rider drop-offs.
Fleet Rebalancing: Auto-rickshaws and two-wheelers maintain the highest asset turnover; prioritizing EV adoption (eBikes) in congested transit belts offers substantial margin expansion.
