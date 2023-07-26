#!/usr/bin/env bash
=======
read -d $'' ShowText <<EOF
<html>
<head>
  <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <style>
    .lds-ring {
      display: inline-flex;
      position: absolute;
      width: 100%;
      height: 100%;
      align-items: center;
      justify-content: center;
    }
    .lds-ring div {
      box-sizing: border-box;
      display: block;
      position: absolute;
      width: 60px;
      height: 60px;
      margin: 8px;
      border: 8px solid rgba(0, 255, 255, .1);
      border-top-color: #00a8e8;
      border-radius: 50%;
      animation: lds-ring 1.2s infinite steps(24);
      /*border-color: #fff transparent transparent transparent;*/
    }
    .lds-ring div:nth-child(1) {
      animation-delay: -0.45s;
    }
    .lds-ring div:nth-child(2) {
      animation-delay: -0.3s;
    }
    .lds-ring div:nth-child(3) {
      animation-delay: -0.15s;
    }
    @keyframes lds-ring {
      0% {
        transform: rotate(0deg);
      }
      100% {
        transform: rotate(360deg);
      }
    }
>>>>>>> upstream/main

