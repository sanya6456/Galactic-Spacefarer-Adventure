using { Departments as DepartmentsDB } from '../db/department.schema';
using { Positions as PositionsDB } from '../db/position.schema';
using { Spacefarers as SpacefarersDB } from '../db/spacefarer.schema';

service SpacefarerService @(requires: 'authenticated-user') {
    @restrict: [
        { grant: ['READ', 'WRITE'], to: 'Admin' },
        { grant: ['READ'], to: 'User' },
        { grant: ['READ'], to: 'PlanetX', where: 'originPlanet = ''PlanetX''' }
    ]
    @odata.draft.enabled
    entity Spacefarers as projection on SpacefarersDB;
    entity Departments as projection on DepartmentsDB;
    entity Positions as projection on PositionsDB;
}