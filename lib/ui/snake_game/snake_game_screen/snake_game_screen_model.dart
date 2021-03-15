import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate_app/bloc/constant/color.dart';
import 'package:flutter_boilerplate_app/bloc/util/responsive_screen.dart';
import 'package:stacked/stacked.dart';

class SnakeGameScreenModel extends BaseViewModel {

  final double boardSpacing = 2;

  late int _blockCountX;
  late int _blockCountY;
  late int _blockCountTotal;
  late int _blockSize;
  bool _hasGameStarted = false;

  static const kdPerfectMovementScore = 100;
  int _score = 0;
  int get score => this._score;

  int get blockSize => this._blockSize;

  get blockCountX => this._blockCountX;

  get blockCountTotal => this._blockCountTotal;

  final int _snackStartPoint = 5;
  final List<int> _snakeObj = [];

  int _shortestPath = 0;
  int get shortestPath => this._shortestPath;

  int _currentSnakeMovementScore = 0;

  late int _food;
  int get food => this._food;

  final int _gameSpeedInMilli = 250;
  Direction _snakeDirection = Direction.Down;

  /// prevents moving to same direction with multi input on a single snake frame update
  late Direction _lastMovedDirection;

  final rng = Random();

  generateNewFood() {
    _food = rng.nextInt(blockCountTotal);
    var index = _snakeObj.indexOf(_food);
    if (index != -1) {
      generateNewFood();
    }
    _shortestPath = _shortestPathCalculation();
  }

  init() {}

  calculateBlocks({required BoxConstraints constraints}) {
    if (!_hasGameStarted) {
      setBusy(true);

      double boardWidth = constraints.maxWidth;
      double boardHeight = constraints.maxHeight - boardSpacing * 3;

      _blockCountX = (boardWidth <= kTabletScreenSize) ? 15 : 20;

      _blockCountTotal = ((boardWidth ~/ _blockCountX) * boardHeight).toInt();

      _blockSize = boardWidth ~/ _blockCountX;
      _blockCountY = boardHeight ~/ blockSize;
      _blockCountTotal = _blockCountX * _blockCountY;

      //makeLog('_blockSize $_blockSize boardHeight $boardHeight   ${_blockCountY * _blockSize}');

      _snakeObj
        ..clear()
        ..addAll([
          _snackStartPoint, /* _snackStartPoint + _blockCountX */
        ]);
      generateNewFood();
      setBusy(false);
      _startGame();
    }
  }

  _startGame() {
    // init snake detail
    _hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: _gameSpeedInMilli), (Timer timer) {
      _updateSnake();
      _currentSnakeMovementScore++;

      if (_snakeObj.last == _food) {
        // snake ate the food
        updateScore();
        generateNewFood();
      } else {
        _snakeObj.removeAt(0);
      }
      if (_checkIsGameOver()) {
        timer.cancel();
        showGameOverUi();
      }

      notifyListeners();
    });
  }

  updateScore() {
    int newScore =
        (_shortestPath / _currentSnakeMovementScore * kdPerfectMovementScore)
            .toInt();
    _score += newScore;
    //makeLog('_shortestPath $_shortestPath _currentSnakeMovementScore $_currentSnakeMovementScore newScore $newScore');
    _currentSnakeMovementScore = 0;
  }

  bool _checkIsGameOver() {
    var index = _snakeObj.indexOf(_snakeObj.last);

    return (index != (_snakeObj.length - 1));
  }

  _updateSnake() {
    // current direction check
    switch (_snakeDirection) {
      case Direction.Up: // [20, 0, 0+320-20 = 300]
        if (_snakeObj.last < _blockCountX)
          _snakeObj.add(_snakeObj.last + _blockCountTotal - _blockCountX);
        else
          _snakeObj.add(_snakeObj.last - _blockCountX);
        break;
      case Direction.Down: // [280,300,]
        if ((_snakeObj.last + _blockCountX) >= _blockCountTotal)
          _snakeObj.add(_snakeObj.last + _blockCountX - _blockCountTotal);
        else
          _snakeObj.add(_snakeObj.last + _blockCountX);
        break;
      case Direction.Left: // [301,300]
        if ((_snakeObj.last) % _blockCountX == 0)
          _snakeObj.add(_snakeObj.last + _blockCountX - 1);
        else
          _snakeObj.add(_snakeObj.last - 1);
        break;
      case Direction.Right: // [318,319]
        if ((_snakeObj.last + 1) % _blockCountX == 0)
          _snakeObj.add(_snakeObj.last - _blockCountX + 1);
        else
          _snakeObj.add(_snakeObj.last + 1);
        break;
      default:
    }

    _lastMovedDirection = _snakeDirection;
  }

  Color getColor(int index) {
    var isSnake = _snakeObj.indexOf(index);
    if (isSnake == -1) {
      // not a snake part
      return kcGameBoardSquares;
    } else {
      // Snake part. Paint color with opacity corresponding to index //
      int alpha = (255 * pow(.9, (_snakeObj.length - isSnake - 1))).toInt();
      return kcSnake.withAlpha(alpha < 100 ? 100 : alpha);
    }
  }

  bool isFood(int index) {
    return index == _food;
  }

  handleVerticalDragInput({required DragUpdateDetails details}) {
    if (_snakeDirection != Direction.Up && details.delta.dy > 0)
      _updateSnakeDirection(Direction.Down);
    else if (_snakeDirection != Direction.Down && details.delta.dy < 0)
      _updateSnakeDirection(Direction.Up);
  }

  handleHorizontalDragInput({required DragUpdateDetails details}) {
    if (_snakeDirection != Direction.Left && details.delta.dx > 0)
      _updateSnakeDirection(Direction.Right);
    else if (_snakeDirection != Direction.Right && details.delta.dx < 0)
      _updateSnakeDirection(Direction.Left);
  }

  handleKeyboardInputEvent({required RawKeyEvent event}) {
    if (_lastMovedDirection != Direction.Up &&
        event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      _updateSnakeDirection(Direction.Down);
    } else if (_lastMovedDirection != Direction.Down &&
        event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      _updateSnakeDirection(Direction.Up);
    } else if (_lastMovedDirection != Direction.Right &&
        event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      _updateSnakeDirection(Direction.Left);
    } else if (_lastMovedDirection != Direction.Left &&
        event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      _updateSnakeDirection(Direction.Right);
    }
  }

  _updateSnakeDirection(Direction newDirection) {
    _snakeDirection = newDirection;
  }

  showGameOverUi() {
    // todo
  }

  int _shortestPathCalculation() {
    bool isOppositeMovementX = false;
    bool isOppositeMovementY = false;
    int x = (_food % _blockCountX - _snakeObj.last % _blockCountX).abs();

    if (x > _blockCountX / 2) {
      x = _blockCountX - x;
      isOppositeMovementX = true;
    }

    int y = ((_snakeObj.last / _blockCountX).floor() -
            (_food / _blockCountX).floor())
        .abs();

    if (y > _blockCountY / 2) {
      y = _blockCountY - y;
      isOppositeMovementY = true;
    }
    if (x == 0 && (_isMovingOppositeX() ^ isOppositeMovementY)) {
      x += 2;
    }
    if (y == 0 && (_isMovingOppositeY() ^ isOppositeMovementX)) {
      y += 2;
    }

    //makeLog('head ${_snakeObj.last} food $_food, x $x y $y');

    return x + y;
  }

  bool _isMovingOppositeX() {
    if (_food < _snakeObj.last && _snakeDirection == Direction.Down)
      return true;
    else if (_food > _snakeObj.last && _snakeDirection == Direction.Up)
      return true;
    else
      return false;
  }

  bool _isMovingOppositeY() {
    if (_food < _snakeObj.last && _snakeDirection == Direction.Right)
      return true;
    else if (_food > _snakeObj.last && _snakeDirection == Direction.Left)
      return true;
    else
      return false;
  }
}

enum Direction { Up, Down, Left, Right }
