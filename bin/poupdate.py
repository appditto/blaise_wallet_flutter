import os
import json
from poeditor import POEditorAPI
from settings import PO_API_KEY, PROJECT_ID

client = POEditorAPI(api_token=PO_API_KEY)

languages = client.list_project_languages(PROJECT_ID)

language_codes = []

for l in languages:
    if l['percentage'] > 50:
        language_codes.append(l['code'])

for code in language_codes:
        client.export(PROJECT_ID, code, file_type='json', local_file=f'lib/l10n/intl_{code}.json')

for fname in os.listdir('lib/l10n'):
        if fname.endswith('.json'):
                fname = f'lib/l10n/{fname}'
                out_file = fname.replace(".json", ".arb")
                ret = {}
                with open(fname) as json_file:
                    data = json.load(json_file)
                    for obj in data:
                        ret[obj['reference']] = obj['definition'].replace("<newline>", "\n")
                with open(out_file, 'w') as outf:
                    json.dump(ret, outf, indent=2, ensure_ascii=False)
                    print(f"Wrote {out_file}")
                os.remove(fname)