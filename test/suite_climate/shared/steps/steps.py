# -*- coding: utf-8 -*-

import names

@Given("the application \"Outpace Square\" is started")
def step(context):
    startApplication("OutpaceSquare")

@When("The user taps on the AC decrease button 1 times")
def step(context):
    mouseClick(waitForObject(names.outpace_Square_colorize_MultiEffect), 8, 13, Qt.LeftButton)
