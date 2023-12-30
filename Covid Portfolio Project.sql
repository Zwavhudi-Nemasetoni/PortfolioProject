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

SELECT date, MAX(total_cases) as Total_cases,MAX(CAST(COALESCE(total_deaths, '0') as float))as Total_deaths,MAX(CAST (COALESCE(total_deaths, '0') as float))/MAX (total_cases) *100 as DeathPercentage FROM PortfolioProject..CovidDeathsWHERE continent is not nullGROUP BY dateORDER BY 1,2--looking at Total population vs vaccinations--CTEWith popsvsVac(continent, location, date, population, new_vaccinations, rollingpeoplevaccinated)as(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,MAX(CAST(COALESCE(vac.new_vaccinations, '0') as float)) over(partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated--,(rollingpeoplevaccinated/population)*100from PortfolioProject..CovidDeaths deajoin PortfolioProject..CovidVaccinations vac    ON dea.location = vac.location	and dea.date = vac.datewhere dea.continent is not null--order by 2,3)select *, (rollingpeoplevaccinated/population)*100from popsvsVac--Temp TableDrop Table if exists #percentpopulationvaccinatedCreate Table #percentpopulationvaccinated(continent nvarchar(255),location nvarchar(255),Date datetime,Population numeric,new_vaccinations numeric,rollingpeoplevaccinated numeric)insert into #percentpopulationvaccinatedselect dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,MAX(CAST(COALESCE(vac.new_vaccinations, '0') as float)) over(partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated--,(rollingpeoplevaccinated/population)*100from PortfolioProject..CovidDeaths deajoin PortfolioProject..CovidVaccinations vac    ON dea.location = vac.location	and dea.date = vac.date--where dea.continent is not null--order by 2,3select *,(rollingpeoplevaccinated/population)*100from #percentpopulationvaccinated--creating View to store data for later visualizationscreate view #percentpopulationvaccinated asselect dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,MAX(CAST(COALESCE(vac.new_vaccinations, '0') as float)) over(partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated--,(rollingpeoplevaccinated/population)*100from PortfolioProject..CovidDeaths deajoin PortfolioProject..CovidVaccinations vac    ON dea.location = vac.location	and dea.date = vac.datewhere dea.continent is not null--order by 2,3