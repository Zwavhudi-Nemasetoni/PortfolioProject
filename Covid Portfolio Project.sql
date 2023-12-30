Select *
From PortfolioProject..CovidDeaths
Order by 3,4

--Select *
--From PortfolioProject..CovidVaccinations
--Order by 3,4

--select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Order by 1,2

--Looking at Total Cases vs Total Deaths
--shows likelihood of dying if you contract covid in your country

Select location, date, total_cases,total_deaths, (CONVERT(float, total_deaths)/total_cases)*100 as Deathpercentage
From PortfolioProject..CovidDeaths
Where location like'%africa%'
Order by 1,2


--Looking at Total cases vs Population
-- Shows What Percentage of POpulation got Covid

Select location, date, population, total_cases, (CONVERT(float, total_cases)/population)*100 as percentagepopulationInfected
From PortfolioProject..CovidDeaths
--Where location like'%africa%'
Order by 1,2

--Looking at countries with Highest Infection Rate Compared to Population

Select location, population, MAX(total_cases) as HighestInfectionCount, Max((CONVERT(float, total_cases)/population))*100 as PercentagePopulationInfected
From PortfolioProject..CovidDeaths
--Where location like'%africa%'
Group by location, population
Order by PercentagePopulationInfected desc

--showing Countries with Highest Death count per population

Select location, MAX(total_deaths) as TotalDeathsCount
From PortfolioProject..CovidDeaths
--Where location like'%africa%'
Group by location
Order by TotalDeathsCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

Select continent, MAX(total_deaths) as TotalDeathsCount
From PortfolioProject..CovidDeaths
--Where location like'%africa%'
Group by continent
Order by TotalDeathsCount desc

--Showing the Continent with highest death count per populations

Select continent, MAX(total_deaths) as TotalDeathsCount
From PortfolioProject..CovidDeaths
--Where location like'%africa%'
Group by continent
Order by TotalDeathsCount desc

--Global Numbers

SELECT date, MAX(total_cases) as Total_cases,