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


PortfolioItemDirective = ($compile) ->

	largeImgTemplate = '<div class="pure-u-1" ><img ng-src="https://www.remontnik.ru/{{content.images[0].image_fullsize}}" alt=""></div>'
	mediumImgTemplate = '<div class="pure-u-1" ><img ng-src="https://www.remontnik.ru/{{content.images[0].image_large}}" alt=""></div>'
	smallImgTemplate = '<div class="pure-u-1" ><img ng-src="https://www.remontnik.ru/{{content.images[0].image_medium}}" alt=""></div>'

	getTemplate = (index) ->
		template = ''
		if index in [0, 10] then template = largeImgTemplate
		if index in [6,7,16,17] then template = mediumImgTemplate
		if index in [1,2,3,4,5,8,9,11,12,13,14,15,18,19] then template = smallImgTemplate
		template


	linker = (s, e, a) ->
		console.log s
		e.html(getTemplate(s.index))
		$compile(e.contents())(s)


	restrict: 'E'
	controller: PortfolioItemController
	link: linker
	scope:
		content: '='
		index: '='


PortfolioItemController = () ->






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
