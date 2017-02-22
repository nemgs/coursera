'use strict';

angular.module('confusionApp')
    //Changed the "m" of menuController to upper case "M", since that is the convention followed in angular
    .controller('MenuController', ['$scope', 'menuFactory', function ($scope, menuFactory) {
        $scope.tab = 1;
        $scope.filtText = "";
        $scope.showDetails = false;
        $scope.dishes = menuFactory.getDishes();
        $scope.select = function (setTab) {
            $scope.tab = setTab;

            if (setTab === 2) {
                $scope.filtText = "appetizer";
            }
            else if (setTab === 3) {
                $scope.filtText = "mains";
            }
            else if (setTab === 4) {
                $scope.filtText = "dessert";
            }
            else {
                $scope.filtText = "";
            }
        };

        $scope.isSelected = function (checkTab) {
            return ($scope.tab === checkTab);
        };

        $scope.toggleDetails = function () {
            $scope.showDetails = !$scope.showDetails;
        };
    }])
    .controller('ContactController', ['$scope', function ($scope) {
        $scope.feedback = { mychannel: "", firstName: "", lastName: "", agree: false, email: "" };

        var channels = [{ value: "tel", label: "Tel." }, { value: "Email", label: "Email" }];
        $scope.channels = channels;
        $scope.invalidChannelSelection = false;
    }])
    .controller('FeedbackController', ['$scope', function ($scope) {
        $scope.sendFeedback = function () {
            console.log($scope.feedback);
            if ($scope.feedback.agree && ($scope.feedback.mychannel == "") && !$scope.feedback.mychannel) {
                $scope.invalidChannelSelection = true;
                console.log('incorrect');
            }
            else {
                $scope.invalidChannelSelection = false;
                //At this point we can send this information to a server using ajax
                $scope.feedback = { mychannel: "", firstName: "", lastName: "", agree: false, email: "" };
                $scope.feedback.mychannel = "";
                $scope.feedbackForm.$setPristine();
                console.log($scope.feedback);
            }
        };
    }])
    .controller('DishDetailController', ['$scope', '$routeParams', 'distDetailFactory',
        function ($scope, $routeParams, distDetailFactory) {
            $scope.sortOrder = "-rating";
            $scope.dishDetail = distDetailFactory.getDish(parseInt($routeParams.id, 10));
            console.log($scope.dishDetail);
        }])
    .controller('DishCommentController', ['$scope', function ($scope) {
        $scope.starOptions = [1, 2, 3, 4, 5];
        $scope.comment = { yourname: "", numstars: 5, commenttext: "", createDate: Date };
        $scope.comment.createDate = new Date().toISOString();

        //Step 1: Create a JavaScript object to hold the comment from the form
        $scope.submitComment = function () {
            //Step 2: This is how you record the date
            //"The date property of your JavaScript object holding the comment" = new Date().toISOString();

            // Step 3: Push your comment into the dish's comment array
            $scope.dish.comments.push({
                rating: $scope.comment.numstars,
                comment: $scope.comment.commenttext,
                author: $scope.comment.yourname,
                date: $scope.comment.createDate
            });

            //Step 4: reset your form to pristine
            $scope.commentForm.$setPristine();

            //Step 5: reset your JavaScript object that holds your comment
            $scope.comment = { yourname: "", numstars: 5, commenttext: "", createDate: new Date().toISOString() };
        };
    }])
    ;