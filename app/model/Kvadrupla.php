<?php
namespace app\model;

    class Kvadrupla {
            private int $nyeroSzam1;
            private int $nyeroSzam2;
            private int $nyeroSzam3;
            private int $nyeroSzam4;
            private string $elsoHuzas;
            private string $utolsoHuzas;
            private int $huzasDb;
            private int $ismetlodes1;
            private int $ismetlodes2;
            private int $ismetlodes3;
            private int $ismetlodes4;

        function __destruct(){
            }

        function __construct (int $nyeroszam1, int $nyeroszam2, int $nyeroszam3, int $nyeroszam4, string $elsohuzas, string $utolsohuzas,int $huzasdb, int $ismetlodes1, int $ismetlodes2,int $ismetlodes3,int $ismetlodes4){
            $this->nyeroSzam1  = $nyeroszam1;
            $this->nyeroSzam2  = $nyeroszam2;
            $this->nyeroSzam3  = $nyeroszam3;
            $this->nyeroSzam4  = $nyeroszam4;
            $this->elsoHuzas   = $elsohuzas;
            $this->utolsoHuzas = $utolsohuzas;
            $this->huzasDb     = $huzasdb;
            $this->ismetlodes1 = $ismetlodes1;
            $this->ismetlodes2 = $ismetlodes2;
            $this->ismetlodes3 = $ismetlodes3;
            $this->ismetlodes4 = $ismetlodes4;
        }

        public function getNyeroSzam1() :int {
            return $this->nyeroSzam1;
        }
        
        public function getNyeroSzam2() :int {
            return $this->nyeroSzam2;
        }
        
        public function getNyeroSzam3() :int {
            return $this->nyeroSzam3;
        }
        
        public function getNyeroSzam4() :int {
            return $this->nyeroSzam4;
        }
        
        public function getElsoHuzas() :string {
            return $this->elsoHuzas;
        }

        public function getUtolsoHuzas() :string {
            return $this->utolsoHuzas;
        }

        public function getHuzasDb() :int {
            return $this->huzasDb;
        }

        public function getIsmetlodes1() :int {
            return $this->ismetlodes1;
        }

        public function getIsmetlodes2() :int {
            return $this->ismetlodes2;
        }

        public function getIsmetlodes3() :int {
            return $this->ismetlodes3;
        }

        public function getIsmetlodes4() :int {
            return $this->ismetlodes4;
        }

        public function printKvadruplas() :void {
            echo "<pre>";
            var_dump($this);
            echo "</pre>";
        }
    }