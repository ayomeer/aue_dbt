{% set datetime = run_started_at.astimezone(modules.pytz.timezone("Europe/Zurich")) %}
{% set ts = datetime.strftime('%Y-%m-%d %H:%M:%S') %}

SELECT {{run_started_at.astimezone(modules.pytz.timezone("Europe/Zurich"))}}