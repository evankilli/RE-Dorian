-- Count the number of dorian points in each county
-- Count the number of november points in each county
-- Set counties with no points to 0 for the november count
-- Calculate the normalized difference tweet index (made this up, based on NDVI), where
-- ndti = (tweets about storm – baseline twitter activity) / (tweets about storm + baseline twitter activity)
-- remember to multiply something by 1.0 so that you'll get decimal devision, not integer division
-- also if the denominator would end up being 0, set the result to 0


create table dorian_county1 as
  select a.status_id as status_id,
  b.geoid as geoid
  b.geometry as geom
  from dorian a
  join counties b
  on st_intersects(a.geom,b.geometry)

  create table dorian_county2 as
    select geoid, count(status_id)
    from dorian_county1
    group by geoid

  create table nov_county1 as
    select a.status_id as status_id,
    b.geoid as geoid
    b.geometry as geom
    from november a
    join counties b
    on st_intersects(a.geom, b.geometry)

  create table nov_county2 as
    select geoid, count(status_id)
    from nov_county1
    group by geoid

    create table counties2 as
      select a.geoid as geoid,
      a.count as dorian_count,
      b.geometry as geom
      from dorian_county2 a
      full join counties b
      on a.geoid = b.geoid

  create table county_tweets as
    select a.geoid as geoid,
    a.dorian_count as dorian_count,
    b.count as nov_count,
    a.geom as geom
    from counties2 a
    full join nov_county2 b
    on a.geoid = b.geoid

  update county_tweets
    set nov_count = 0
    where nov_count is null

  update county_tweets
    set dorian_count = 0
    where dorian_count is null

  alter table county_tweets add column ndti real

  update county_tweets set ndti = (dorian_count-nov_count)*1.0/(dorian_count+nov_count)*1.0,

  update county_tweets set ndti = 0 where ndti is null
