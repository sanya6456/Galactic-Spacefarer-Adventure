using { cuid, managed } from '@sap/cds/common';
using { Departments } from './department.schema';
using { Positions } from './position.schema';

entity Spacefarers : cuid, managed {
  name               : String(100);
  originPlanet       : String(100);
  stardustCollection : Integer;
  wormholeSkill      : Integer;
  spacesuitColor     : String(50);

  department         : Association to Departments;
  position           : Association to Positions;
}