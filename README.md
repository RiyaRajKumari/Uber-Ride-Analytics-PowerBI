# 🚗 Uber Ride Bookings Intelligence Platform (Power BI)

An enterprise-grade, end-to-end Power BI analytics project evaluating **150,000+ ride-hailing bookings**. This project investigates booking fulfillment, multi-modal fleet dynamics, operational friction, driver vs. customer cancellations, and top-line revenue realization.

---

## 📌 Executive Summary
Urban ride-hailing platforms operate in high-volatility environments marked by sharp demand spikes, localized supply shortages, and cancellation friction. This project delivers an executive dashboard suite tracking operational health, route corridor efficiency, cancellation root causes, and revenue realization across a multi-modal fleet.

### 🌟 Key Performance Highlights (Full Dataset)
* **Total Ride Bookings Evaluated**: 150,000
* **Gross Fulfilled Revenue**: ₹5.18+ Crores (51.85M)
* **Booking Success Rate**: 62.07%
* **Driver-Side Cancellations**: 18.0% (27,000 trips) — *Largest operational bottleneck*
* **Customer-Side Cancellations**: 7.0% (10,500 trips)
* **Unmet Demand ("No Driver Found")**: 7.0% (10,500 trips)
* **Overall Customer Satisfaction**: 4.41 / 5.0 ★

---

## 📊 Dashboard Architecture (4 Interactive Analytical Views)

### 1. Executive Summary
* **Macro KPI Cards**: Total Bookings, Fulfilled Revenue, Success Rate %, and Average Rating.
* **Booking Status Distribution**: Donut chart breakdown revealing the 62% fulfillment vs. 38% operational drop-off.
* **24-Hour Demand Rhythm**: Area chart tracking hourly ride demand, proving morning office rushes (8–10 AM) and steep evening surges (5–9 PM).
* **Interactivity**: Dynamic Date slider, multi-select Vehicle Type slicers, and seamless Page Navigation.

### 2. Fleet & Route Performance
* **Revenue Engine by Vehicle Category**: Clustered column chart demonstrating that **Auto** is the #1 gross revenue driver (~₹1.3 Cr), followed by **Go Mini** (~₹1.04 Cr) and **Go Sedan** (~₹0.94 Cr).
* **High-Demand Corridor Analysis**: Top 10 pickup and drop hotspots (e.g., IGI Airport, Cyber Hub, AIIMS, Noida Sector 62).
* **Distance Tier Fleet Mix**: Proves micro-mobility (Bikes and Autos) dominates short commutes (<5 km) while Sedans dominate high-fare airport corridors (>20 km).

### 3. Operational Friction & Cancellation Forensics
* **Driver Cancellation Root Causes**: Forensics uncovering why 27,000 rides were rejected by drivers (*Vehicle/personal issues, Passenger count exceedance, Sick passenger*).
* **Customer Cancellation Drivers**: Investigates the 10,500 passenger cancellations (*Driver not moving to pickup, Driver requested cancellation, Long wait times*).
* **Supply-Side Disparity**: Proves that **drivers cancel 2.5x to 3x more frequently than riders across every single vehicle type**.
* **Vehicle Turnaround Time (VTAT)**: Tracking the critical 8.5–10 minute pickup arrival threshold before cancellation probability spikes.

### 4. Revenue Realization & Service Quality
* **Payment Gateway Adoption**: Revenue breakdown highlighting the dominance of **UPI** (~45%) and **Cash** (~25%) over Cards and Wallets.
* **Rating Gap Analysis**: Direct comparison between Driver Ratings and Customer Ratings across vehicle segments.
* **Revenue Leakage Quantification**: Estimating the ₹25M+ unrealized revenue lost to cancellations and unassigned trips.

---

## 🛠️ Data Modeling & DAX Formulas

### Star Schema Architecture
* **Fact Table**: `Fact_RideBookings` (150,000 rows, 21 attributes)
* **Dimension Table**: `Dim_Date` (Calendar dimension with custom Year, Quarter, Month, Day, and Weekday sorting)
* **Measures Group**: Dedicated `_Measures` table housing all business logic

### Core DAX Measures
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
