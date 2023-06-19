*** Settings ***
Library    SeleniumLibrary
Library    XML
Library    DatabaseLibrary

Resource    ..//resources/home_page.resource
Resource    ..//configs/env.resource

*** Variables ***

*** Keywords ***
Prepare Unreviewed Product
    Execute Sql String    Update [nop].[dbo].[Product] Set [ApprovedTotalReviews]=0
    Execute Sql String    Delete From [nop].[dbo].[ProductReview]  Where Title <> 'Some sample review'
     
Prepare Reviewed Product
    Execute Sql String    Update [nop].[dbo].[Product] Set [ApprovedTotalReviews]=5
