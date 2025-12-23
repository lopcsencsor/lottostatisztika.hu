<?php
namespace app\model;

    class Szimpla {
        private int $id;
        private string $firstName;
        private string $lastName;
        private int $categoryId;
        private int $salary;
        private string $jobStart;
        private bool $status;

        function __construct(string $firstName, string $lastName, int $categoryId, int $salary, string $jobStart, bool $status){
            $this->firstName = $firstName;
            $this->lastName = $lastName;
            $this->categoryId = $categoryId;
            $this->salary = $salary;
            $this->jobStart = $jobStart;
            $this->status = $status;
        }

        /**
         * Get the value of id
         */ 
        public function getId(){
            return $this->id;
        }

        /**
         * Get the value of firstName
         */ 
        public function getFirstName(){
            return $this->firstName;
        }

        /**
         * Get the value of lastName
         */ 
        public function getLastName()
        {
            return $this->lastName;
        }

        /**
         * Get the value of categoryId
         */ 
        public function getCategoryId(){
            return $this->categoryId;
        }

        /**
         * Get the value of salary
         */ 
        public function getSalary(){
            return $this->salary;
        }

        /**
         * Get the value of jobStart
         */ 
        public function getJobStart(){
            return $this->jobStart;
        }

        /**
         * Get the value of status
         */ 
        public function getStatus(){
            return $this->status;
        }
    }
