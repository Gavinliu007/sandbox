CREATE OR REPLACE FUNCTION "AMANDA"."BUILDING_OWNER_ADDLINE1" (parmFolderRSN number)
   return varchar2  is

vl_addressline1 varchar2(60);

/* Task 333 */

v_NAME                 VARCHAR2(250) := null;
v_ORGANIZATIONNAME      VARCHAR2(250) := null;

begin

     begin
        select rtrim(p.namefirst)||' '||rtrim(p.namelast), p.organizationname
        into v_name, v_organizationname
        from folder f,  property pb,  propertypeople pp, people p
        where f.folderrsn = parmFolderRSN
        and pb.propertyrsn(+) = f.propertyrsn
        and pp.propertyrsn(+) = pb.parentpropertyrsn
        and p.peoplersn(+) = pp.peoplersn
        and rownum = 1;

     exception
	       WHEN NO_DATA_FOUND THEN
            v_name := null;
            v_organizationname := null;
     end;

if v_organizationname is not null then
   vl_addressline1 := v_name;
else
   vl_addressline1 := null;
end if;

return vl_addressline1;

     exception
	       WHEN others THEN
           return null;
           
end building_owner_addline1;