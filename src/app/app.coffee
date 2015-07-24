'use strict'

PortfolioController = ($scope, PortfolioService) ->
	PortfolioService.get()
		.success (data, status, headers) ->
			$scope.portfolio_items = data.results
			console.log data.results
		.error (data) ->
			console.error(data)

PortfolioController.$inject = ['$scope', 'PortfolioService']


PortfolioService = ($http) ->
	URL = 'https://www.remontnik.ru/api/v1/portfolio/all/'

	get: ->
		$http.get URL 

PortfolioService.$inject = ['$http']


PortfolioItemDirective = () ->
	restrict: 'E'
	controller: PortfolioItemController









core = angular.module 'slushAngularTask', [
  'ngRoute'
]

core.config ($routeProvider) ->
		$routeProvider
			.when '/', 
				templateUrl: 'templates/portfolio.html'
				controller: 'PortfolioController'

core.service('PortfolioService', PortfolioService)
core.controller('PortfolioController', PortfolioController)
core.directive 'portfolioitem', PortfolioItemDirective
