'use strict';

const _ = require('lodash');
const createNode = require('./node');

class LinkedList {
  constructor(data) {
    this.head = createNode(data);
  }

  get tail() {
    return this.traverse(null, node => node);
  }

  get count() {
    return this.traverse(null, (node, index) => index + 1);
  }

  traverse(intermediaryCallback, finalCallback, node, index, previous) {
    node = node || this.head;
    index = index || 0;

    if (_.isFunction(intermediaryCallback)) { intermediaryCallback(node, index, previous); }

    if (node.next) {
      return this.traverse(intermediaryCallback, finalCallback, node.next, index + 1, node);
    }

    if (_.isFunction(finalCallback)) { return finalCallback(node, index, previous); }
  }

  append(data) {
    this.tail.next = createNode(data);
    return this;
  }

  prepend(data) {
    let node = createNode(data);

    node.next = this.head;
    this.head = node;

    return this;
  }

  includes(data) {
    let isInList = false;

    return this.traverse(node => {
      if (node.data === data) { isInList = true; }
    }, () => isInList);
  }

  pop() {
    return this.traverse(null, (node, index, previous) => {
      previous.next = undefined;
      return node;
    });
  }

  insert(data, index) {
    return this.traverse((node, currentIndex, previous) => {
      if (currentIndex === index) {
        let newNode = previous.next = createNode(data);
        newNode.next = node;
      }
    }, () => this);
  }

  findByValue(data) {
    let matchingNode;

    return this.traverse(node => {
      if (node.data === data) { matchingNode = node; }
    }, () => matchingNode);
  }

  findByIndex(index) {
    let matchingNode;

    return this.traverse((node, currentIndex) => {
      if (currentIndex === index) { matchingNode = node; }
    }, () => matchingNode);
  }

  removeByValue(data) {
    return this.traverse((node, currentIndex, previous) => {
      if (node.data === data) { previous.next = node.next; }
    }, () => this);
  }

  removeByIndex(index) {
    return this.traverse((node, currentIndex, previous) => {
      if (currentIndex === index) { previous.next = node.next; }
    }, () => this);
  }

}

module.exports = LinkedList;