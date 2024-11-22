{ pkgs, version ? "latest", importAlias ? "@/*", language ? "ts"
, packageManager ? "npm", srcDir ? false, eslint ? false, app ? false
, tailwind ? false, ... }: {

  packages = [ pkgs.nodejs_20 pkgs.yarn pkgs.pnpm];

  bootstrap = ''
    			mkdir "$out"
    			pnpm create next-app@${version} "$out" \
					  --yes \
					  --skip-install \
    				--import-alias=${importAlias} \
    				--${language} \
    				--use-${packageManager} \
    				${if eslint then "--eslint" else "--no-eslint"} \
    				${if srcDir then "--src-dir" else "--no-src-dir"} \
    				${if app then "--app" else "--no-app"} \
    				${if tailwind then "--tailwind" else "--no-tailwind"}

    			mkdir -p "$out"/.idx
      		cp ${./dev.nix} "$out"/.idx/dev.nix
    			chmod -R +w "$out"

  '';
}