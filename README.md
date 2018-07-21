# Futurewars

Futurewars is a text-based game modeled on the old Tradewars 2002 BBS game, written in Ruby & Rails.

> TradeWars® is the classic space trader game originally released in the 
> late 1980s for Bulletin Board Systems. For 25 years, it has been 
> actively played by a devoted community of gameops and players. It is a 
> seminal game, credited as an early inspiration by many of today’s game
> developers.

This code is made available under the **Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)** license. I wanted to make the source available for others to study, and to be able to openly distribute it for people to play, but keep some restrictions over its use. https://creativecommons.org/licenses/by-nc-sa/4.0/

***THIS IS HEAVY ALPHA.*** The game is in a heavy state of flux due to research/reversing the original game. None of this work is intended to infringe upon the trademarks or copyrights of the original authors. You can buy a copy of the original game here http://www.eisonline.com

# Development Plan

The goal of Futurewars is develop a working, API-based version of the tradewars game in its original 2002 stock state, gameplay-wise. This will allow a variety of frontends, from traditional console-based to more complicated SPA-based applications. More importantly, it will allow easy creation of automated players. This will allow the development and testing of AI players using the kinds of machine learning techniques available in the present day. Most likely I'll start with some basic decision-tree based models. Additions to the game will be made that will not affect the gameplay where possible. Examples may be additional sector data, player avatars etc.

## Game Theory
Because of TW2002's design, it allows a range of gameplay strategies with varying levels of morality, and many of the decisions mimic moral choices. Akin to an iterated prisoner's dilemma, this could produce some interesting results if an entire universe were to be filled with AI players.

# v0.2 Feature Set
* Ability to scan and trade with ports
* Ability to see when other players have entered or exited the sector I'm in
* Test coverage of existing features

# v0.1 Initial Feature Set [COMPLETE]
* Player creation and authentication
* Ability to create a player
* Ability to see current location and move to other locations in space

# Plan
For the most part, the game will stick to the same format as TW2002 until I see reasons to change features, but a few changes are planned:
* Removing Star Trek references. I can come up with some better aliens and stuff

# Documentation

# Services
Each service represents a game action to be carried out.

* CreatePlayerService
* MovePlayerService
* PortCreatorService
* SectorCreatorService
* PortQueryService
* TradeWithPortService
* ConsiderOfferService

* PathFinderService
* ExpressMovePlayerService
* AttackPlayerService
* AttackPortService
* RobPortService

# Entities
## Player
A player is an entity within the game. Players may be human playing via a frontend, or an AI player.
## Sector
A sector is an area of space. It may or may not contain a planet, and may or may not also contain a port. Sectors of space are connected to each other in a random configuration and nonlinearly. I.e, Sector 10 and Sector 11 are not more likely to be neighbours than Sector 10 and Sector 1900. Two sectors are connected via a **warp**.
## Warp
A warp is a connection between two parts of space.
