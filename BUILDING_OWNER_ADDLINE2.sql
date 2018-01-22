-- Unable to render FUNCTION DDL for object AMANDA.BUILDING_OWNER_ADDLINE2 with DBMS_METADATA attempting internal generator.
CREATE FUNCTION AMANDA.BUILDING_OWNER_ADDLINE2 (parmFolderRSN number)
   return varchar2  is

vl_addressline1 varchar2(60);
vl_addressline2 varchar2(60);



v_NAME                 VARCHAR2(50) := null;
v_ORGANIZATIONNAME      VARCHAR2(50) := null;

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
   vl_addressline2 := v_organizationname;
else
   vl_addressline1 := null;
   vl_addressline2 := v_name;
end if;

return vl_addressline2;

end building_owner_addline2;
  GRANT EXECUTE ON "AMANDA"."BUILDING_OWNER_ADDLINE2" TO PUBLIC;
