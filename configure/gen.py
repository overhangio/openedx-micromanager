#! /usr/bin/env python3
import argparse
import os
import yaml


def main():
    parser = argparse.ArgumentParser(
        description="""Generate an env.sh file that can be sourced to define
        environment variables for building Open edX MFEs."""
    )
    parser.add_argument("-b", "--base", default="/env.yml", help="Base environment file")
    parser.add_argument("-a", "--app", default="/app/.env", help="App environment file")
    parser.add_argument(
        "-o", "--output", default="/app/env.sh", help="Destination file"
    )
    args = parser.parse_args()

    # 1) Load base env variables from bind mount
    with open(args.base) as f:
        base = yaml.safe_load(f) or {}

    # 2) Load env variables from app/.env (in js format)
    app = {}
    with open(args.app) as f:
        for line in f:
            key, value = line.split("=")
            app[key] = value

    # 3) Override variables
    final = {}
    for key in app.keys():
        if key not in base:
            print(
                "WARNING variable '{}' is defined in app env file but not overridden".format(
                    key
                )
            )
            continue
        final[key] = base[key]

    # 4) Store result in app/env.sh
    with open(args.output, "w") as f:
        for key, value in final.items():
            f.write(f'export {key}="{value}"\n')

    # 5) Set file ownership
    if "USERID" in os.environ:
        user_id = int(os.environ["USERID"])
        os.chown(args.output, user_id, user_id)


if __name__ == "__main__":
    main()
