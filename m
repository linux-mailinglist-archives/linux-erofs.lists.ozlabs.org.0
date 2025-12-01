Return-Path: <linux-erofs+bounces-1467-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D1C965FF
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Dec 2025 10:26:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dKdn45Pm7z2yvG;
	Mon, 01 Dec 2025 20:26:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764581160;
	cv=none; b=UdxIoVFGQBmP/B8fudtEPU64DHa/ExvSUPzZUM4v4q0qrzPj7bmGD3BcDfCXgSv58iCWWOvlxXng47tnn0DCGpQnwQnB5h8O5+tZatT7EHXtpizYWmZjEwVCUf+C5+XeEn4b+S0nbpCevwJE1ZI6moTA4ph9OderCcE8sDI3+ukXxKZKjupjUaab0Au8dnSIyeEggD/qKjtjJNDDmsbnpgV9KYLeUqT5YfAXxjnerZE/Prm+O0AHh6ZmV3TJMKdjpdNZJKrzCatyDHzuqcalQ4mrsE0iR3Ec7JoWqp81T1UwejsSzhctR5PrDRHe3kqW3PanvJupRK3Xk1lzO9RzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764581160; c=relaxed/relaxed;
	bh=hcPabAnWorJQO7L2duv/HfHm6KrxDJ7/D6lIoRvwvGk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WCZ1hbBniOngagg5FMIoRAfbLeQPoSWLmwr59RinqYnETqLG0UsJ4BV6aVfJLi4RtKpLz25B+g376dCZUVzXXg7LlgQL9XCoFWrt6xUnmv9eCY0oJH6y/d8mEsJdFwRVtoEI2gWYMuCItfDRPZG8KRoquRQQHBa6BvOBe5y1igAmwy2hVovHsFx1Hm7JmgrEN87+kU7bxytxCdZUHLVnssGPCv/UOJKSCzKJHmOQ29ENmbYJsF/Aw93fefKWdj8/2bSky2QYyTg1A+3a437jZi37VeP0S1KLOAlNwKD7FKYMtzJFwxIHfz1nSRqRB6BFGyymL3PGyRbTeEnfn8nTcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.55; helo=out28-55.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.55; helo=out28-55.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-55.mail.aliyun.com (out28-55.mail.aliyun.com [115.124.28.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dKdn16qzXz2yv4
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 20:25:55 +1100 (AEDT)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.faENIeX_1764581148 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 01 Dec 2025 17:25:49 +0800
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 2/2] erofs-utils: lib: oci: allow HTTP connections to
 registry
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <20251130104257.877660-2-zhaoyifan28@huawei.com>
Date: Mon, 1 Dec 2025 17:25:38 +0800
Cc: linux-erofs@lists.ozlabs.org,
 hsiangkao@linux.alibaba.com,
 hudsonzhu@tencent.com,
 wayne.ma@huawei.com,
 jingrui@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
 <20251130104257.877660-2-zhaoyifan28@huawei.com>
To: Yifan Zhao <zhaoyifan28@huawei.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Thanks for this patch, Yifan !=20

It looks good to me. I have tested the patch and it works as expected.
One suggestion: it would be nice to have similar functionality in
mount.erofs as well, for consistency across the toolkit.=20

Reviewed-and-tested-by: Chengyu Zhu <hudsonzhu@tencent.com>

Thanks,
Chengyu

> 2025=E5=B9=B411=E6=9C=8830=E6=97=A5 18:42=EF=BC=8CYifan Zhao =
<zhaoyifan28@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Currently, the URL used to send requests to the registry is hardcoded
> with "https://". This patch introduces an optional insecure option for
> `--oci`, enabling registry access via the HTTP protocol.
>=20
> Also, this patch refactors the deeply nested logic in the `--oci`
> argument parsing.
>=20
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
> lib/liberofs_oci.h |  3 ++
> lib/remotes/oci.c  | 40 +++++++++++--------
> mkfs/main.c        | 97 ++++++++++++++++++++--------------------------
> 3 files changed, 70 insertions(+), 70 deletions(-)
>=20
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 5298f18..9e0571f 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -23,6 +23,7 @@ struct erofs_importer;
>  * @password: password for authentication (optional)
>  * @blob_digest: specific blob digest to extract (NULL for all layers)
>  * @layer_index: specific layer index to extract (negative for all =
layers)
> + * @insecure: use HTTP for registry communication (optional)
>  *
>  * Configuration structure for OCI image parameters including registry
>  * location, image identification, platform specification, and =
authentication
> @@ -37,6 +38,7 @@ struct ocierofs_config {
> 	int layer_index;
> 	char *tarindex_path;
> 	char *zinfo_path;
> +	bool insecure;
> };
>=20
> struct ocierofs_layer_info {
> @@ -57,6 +59,7 @@ struct ocierofs_ctx {
> 	struct ocierofs_layer_info **layers;
> 	char *blob_digest;
> 	int layer_count;
> +	const char *schema;
> };
>=20
> struct ocierofs_iostream {
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index c1d6cae..d5afd6a 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -496,8 +496,8 @@ static char =
*ocierofs_discover_auth_endpoint(struct ocierofs_ctx *ctx,
>=20
> 	api_registry =3D ocierofs_get_api_registry(registry);
>=20
> -	if (asprintf(&test_url, =
"https://%s/v2/%s/manifests/nonexistent",
> -	     api_registry, repository) < 0)
> +	if (asprintf(&test_url, "%s%s/v2/%s/manifests/nonexistent",
> +	     ctx->schema, api_registry, repository) < 0)
> 		return NULL;
>=20
> 	curl_easy_reset(ctx->curl);
> @@ -528,9 +528,9 @@ static char *ocierofs_get_auth_token(struct =
ocierofs_ctx *ctx, const char *regis
> 				     const char *password)
> {
> 	static const char * const auth_patterns[] =3D {
> -		"https://%s/v2/auth",
> -		"https://auth.%s/token",
> -		"https://%s/token",
> +		"%s%s/v2/auth",
> +		"%sauth.%s/token",
> +		"%s%s/token",
> 		NULL,
> 	};
> 	char *auth_header =3D NULL;
> @@ -561,8 +561,8 @@ static char *ocierofs_get_auth_token(struct =
ocierofs_ctx *ctx, const char *regis
>=20
> 		api_registry =3D ocierofs_get_api_registry(registry);
>=20
> -		if (asprintf(&test_url, =
"https://%s/v2/%s/manifests/nonexistent",
> -		     api_registry, repository) >=3D 0) {
> +		if (asprintf(&test_url, =
"%s%s/v2/%s/manifests/nonexistent",
> +		     ctx->schema, api_registry, repository) >=3D 0) {
> 			curl_easy_reset(ctx->curl);
> 			ocierofs_curl_setup_common_options(ctx->curl);
>=20
> @@ -598,7 +598,7 @@ static char *ocierofs_get_auth_token(struct =
ocierofs_ctx *ctx, const char *regis
> 	for (i =3D 0; auth_patterns[i]; i++) {
> 		char *auth_url;
>=20
> -		if (asprintf(&auth_url, auth_patterns[i], registry) < 0)
> +		if (asprintf(&auth_url, auth_patterns[i], ctx->schema, =
registry) < 0)
> 			continue;
>=20
> 		auth_header =3D ocierofs_get_auth_token_with_url(ctx, =
auth_url,
> @@ -629,8 +629,8 @@ static char *ocierofs_get_manifest_digest(struct =
ocierofs_ctx *ctx,
> 	int ret =3D 0, len, i;
>=20
> 	api_registry =3D ocierofs_get_api_registry(registry);
> -	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
> -	     api_registry, repository, tag) < 0)
> +	if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
> +	     ctx->schema, api_registry, repository, tag) < 0)
> 		return ERR_PTR(-ENOMEM);
>=20
> 	if (auth_header && strstr(auth_header, "Bearer"))
> @@ -749,8 +749,8 @@ static int ocierofs_fetch_layers_info(struct =
ocierofs_ctx *ctx)
> 	ctx->layer_count =3D 0;
> 	api_registry =3D ocierofs_get_api_registry(registry);
>=20
> -	if (asprintf(&req.url, "https://%s/v2/%s/manifests/%s",
> -		     api_registry, repository, digest) < 0)
> +	if (asprintf(&req.url, "%s%s/v2/%s/manifests/%s",
> +		     ctx->schema, api_registry, repository, digest) < 0)
> 		return -ENOMEM;
>=20
> 	if (auth_header && strstr(auth_header, "Bearer"))
> @@ -1124,10 +1124,18 @@ static int ocierofs_init(struct ocierofs_ctx =
*ctx, const struct ocierofs_config
> 	if (!ctx->registry || !ctx->tag || !ctx->platform)
> 		return -ENOMEM;
>=20
> +	ctx->schema =3D config->insecure ? "http://" : "https://";
> +
> 	ret =3D ocierofs_parse_ref(ctx, config->image_ref);
> 	if (ret)
> 		return ret;
>=20
> +	if (config->insecure && (!strcmp(ctx->registry, =
DOCKER_API_REGISTRY) ||
> +				 !strcmp(ctx->registry, =
DOCKER_REGISTRY))) {
> +		erofs_err("Insecure connection to Docker registry is not =
allowed");
> +		return -EINVAL;
> +	}
> +
> 	ret =3D ocierofs_prepare_layers(ctx, config);
> 	if (ret)
> 		return ret;
> @@ -1152,8 +1160,8 @@ static int ocierofs_download_blob_to_fd(struct =
ocierofs_ctx *ctx,
> 	};
>=20
> 	api_registry =3D ocierofs_get_api_registry(ctx->registry);
> -	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
> -	     api_registry, ctx->repository, digest) =3D=3D -1)
> +	if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
> +	     ctx->schema, api_registry, ctx->repository, digest) =3D=3D =
-1)
> 		return -ENOMEM;
>=20
> 	if (auth_header && strstr(auth_header, "Bearer"))
> @@ -1344,8 +1352,8 @@ static int ocierofs_download_blob_range(struct =
ocierofs_ctx *ctx, off_t offset,
> 		length =3D (size_t)(blob_size - offset);
>=20
> 	api_registry =3D ocierofs_get_api_registry(ctx->registry);
> -	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
> -	     api_registry, ctx->repository, digest) =3D=3D -1)
> +	if (asprintf(&req.url, "%s%s/v2/%s/blobs/%s",
> +	     ctx->schema, api_registry, ctx->repository, digest) =3D=3D =
-1)
> 		return -ENOMEM;
>=20
> 	if (length)
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 7aa8eae..5710948 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -218,11 +218,12 @@ static void usage(int argc, char **argv)
> #endif
> #ifdef OCIEROFS_ENABLED
> 		" --oci=3D[f|i]           generate a full (f) or =
index-only (i) image from OCI remote source\n"
> -		"   [,=3Dplatform=3DX]      X=3Dplatform (default: =
linux/amd64)\n"
> +		"   [,platform=3DX]       X=3Dplatform (default: =
linux/amd64)\n"
> 		"   [,layer=3D#]          #=3Dlayer index to extract =
(0-based; omit to extract all layers)\n"
> 		"   [,blob=3DY]           Y=3Dblob digest to extract =
(omit to extract all layers)\n"
> 		"   [,username=3DZ]       Z=3Dusername for =
authentication (optional)\n"
> 		"   [,password=3DW]       W=3Dpassword for =
authentication (optional)\n"
> +		"   [,insecure]         use HTTP instead of HTTPS =
(optional)\n"
> #endif
> 		" --tar=3DX               generate a full or index-only =
image from a tarball(-ish) source\n"
> 		"                       (X =3D f|i|headerball; f=3Dfull =
mode, i=3Dindex mode,\n"
> @@ -744,7 +745,7 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
>  * Parse OCI options string containing comma-separated key=3Dvalue =
pairs.
>  *
>  * Supported options include f|i, platform, blob|layer, username, =
password,
> - * and zinfo.
> + * and insecure.
>  *
>  * Return: 0 on success, negative errno on failure
>  */
> @@ -772,67 +773,55 @@ static int mkfs_parse_oci_options(struct =
ocierofs_config *oci_cfg, char *options
> 		if (q)
> 			*q =3D '\0';
>=20
> -
> -		p =3D strstr(opt, "platform=3D");
> -		if (p) {
> +		if ((p =3D strstr(opt, "platform=3D"))) {
> 			p +=3D strlen("platform=3D");
> 			free(oci_cfg->platform);
> 			oci_cfg->platform =3D strdup(p);
> 			if (!oci_cfg->platform)
> 				return -ENOMEM;
> -		} else {
> -			p =3D strstr(opt, "blob=3D");
> -			if (p) {
> -				p +=3D strlen("blob=3D");
> -				free(oci_cfg->blob_digest);
> +		} else if ((p =3D strstr(opt, "blob=3D"))) {
> +			p +=3D strlen("blob=3D");
> +			free(oci_cfg->blob_digest);
>=20
> -				if (oci_cfg->layer_index >=3D 0) {
> -					erofs_err("invalid --oci: blob =
and layer cannot be set together");
> -					return -EINVAL;
> -				}
> +			if (oci_cfg->layer_index >=3D 0) {
> +				erofs_err("invalid --oci: blob and layer =
cannot be set together");
> +				return -EINVAL;
> +			}
>=20
> -				if (!strncmp(p, "sha256:", 7)) {
> -					oci_cfg->blob_digest =3D =
strdup(p);
> -					if (!oci_cfg->blob_digest)
> -						return -ENOMEM;
> -				} else if =
(asprintf(&oci_cfg->blob_digest, "sha256:%s", p) < 0) {
> +			if (!strncmp(p, "sha256:", 7)) {
> +				oci_cfg->blob_digest =3D strdup(p);
> +				if (!oci_cfg->blob_digest)
> 					return -ENOMEM;
> -				}
> -			} else {
> -				p =3D strstr(opt, "layer=3D");
> -				if (p) {
> -					p +=3D strlen("layer=3D");
> -					if (oci_cfg->blob_digest) {
> -						erofs_err("invalid =
--oci: layer and blob cannot be set together");
> -						return -EINVAL;
> -					}
> -					idx =3D strtol(p, NULL, 10);
> -					if (idx < 0)
> -						return -EINVAL;
> -					oci_cfg->layer_index =3D =
(int)idx;
> -				} else {
> -					p =3D strstr(opt, "username=3D");
> -					if (p) {
> -						p +=3D =
strlen("username=3D");
> -						free(oci_cfg->username);
> -						oci_cfg->username =3D =
strdup(p);
> -						if (!oci_cfg->username)
> -							return -ENOMEM;
> -					} else {
> -						p =3D strstr(opt, =
"password=3D");
> -						if (p) {
> -							p +=3D =
strlen("password=3D");
> -							=
free(oci_cfg->password);
> -							=
oci_cfg->password =3D strdup(p);
> -							if =
(!oci_cfg->password)
> -								return =
-ENOMEM;
> -						} else {
> -							erofs_err("mkfs: =
invalid --oci value %s", opt);
> -							return -EINVAL;
> -						}
> -					}
> -				}
> +			} else if (asprintf(&oci_cfg->blob_digest, =
"sha256:%s", p) < 0) {
> +				return -ENOMEM;
> 			}
> +		} else if ((p =3D strstr(opt, "layer=3D"))) {
> +			p +=3D strlen("layer=3D");
> +			if (oci_cfg->blob_digest) {
> +				erofs_err("invalid --oci: layer and blob =
cannot be set together");
> +				return -EINVAL;
> +			}
> +			idx =3D strtol(p, NULL, 10);
> +			if (idx < 0)
> +				return -EINVAL;
> +			oci_cfg->layer_index =3D (int)idx;
> +		} else if ((p =3D strstr(opt, "username=3D"))) {
> +			p +=3D strlen("username=3D");
> +			free(oci_cfg->username);
> +			oci_cfg->username =3D strdup(p);
> +			if (!oci_cfg->username)
> +				return -ENOMEM;
> +		} else if ((p =3D strstr(opt, "password=3D"))) {
> +			p +=3D strlen("password=3D");
> +			free(oci_cfg->password);
> +			oci_cfg->password =3D strdup(p);
> +			if (!oci_cfg->password)
> +				return -ENOMEM;
> +		} else if ((p =3D strstr(opt, "insecure"))) {
> +			oci_cfg->insecure =3D true;
> +		} else {
> +			erofs_err("mkfs: invalid --oci value %s", opt);
> +			return -EINVAL;
> 		}
>=20
> 		opt =3D q ? q + 1 : NULL;
> --=20
> 2.43.0
>=20


