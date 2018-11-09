{% from "powershell/map.jinja" import powershell with context -%}

include: 
  - netframework

{% if 'installer' in powershell %}
powershell-test:
  file.managed:
    - name: c:\alkivi\packages\powershell\test.ps1
    - source: salt://powershell/templates/test.ps1
    - makedirs: True

wmf5-packages:
  file.managed:
    - name: c:\alkivi\packages\powershell\{{ powershell.installer }}
    - source: {{ powershell.url  }}
    - source_hash: sha256={{ powershell.hash }}
    - show_changes: False
    - makedirs: True
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\powershell\test.ps1

wmf5-install:
  cmd.run:
    - name: wusa.exe {{ powershell.installer }} /quiet /norestart
    - cwd: c:\alkivi\packages\powershell\
    - shell: powershell
    - unless: powershell -NoProfile -ExecutionPolicy Bypass -Command c:\alkivi\packages\powershell\test.ps1
    - require:
      - file: c:\alkivi\packages\powershell\{{ powershell.installer }}
{% endif %}
