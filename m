Return-Path: <linux-erofs+bounces-1073-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC704B941D8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 05:36:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW5HM6xyDz3cYP;
	Tue, 23 Sep 2025 13:36:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.86
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758598575;
	cv=none; b=h8LNLNZiP9bL7XmbVExW9DmTeBGvFZT3pWR5V8aGM3cJ45FPWleilL8rPhVjwYKd8/+vqRrjDsq8Ygi0g7o7CUiTxFOoqlg61nDA1iOZ/rk/Uowg35ytdL00f6NY0nvd7JzWlc7LduaCqBje2q/4UNRONKN3Fw1KA7I8CrKPLE38Q2jjkqEvur6juRHVAiGwKbc43xpZqNnY6UXyZvr83JaChFzk/id8hgLZnQMF9Mh7/bSPlPaTnf59RZVJcj1rUr5WAC845gjB2q1W0FLE+EelVhrFbvu1/V42sIsY28jx+JAzqTsWfqILYG+NistA8cNGJ51q3a+gd8/dDomASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758598575; c=relaxed/relaxed;
	bh=BHcaaSjIv3DmnRfpgdvyDbaUJ/ctEjfvvw8lm//AdoY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y3YQvpY7zHuOjm9EvrAzmT7o8gCotfIjHRPIW7FXYLxeYUk8wMqgVcQppPk6ZFlhT8Ymaoe4AGPYu/cZZ55kshOQYyVFEO8X6ytIK3hdTuuAXoJ686XNW3TKBYHbkHeo9s0egBqGb02IyelK8jPI+shSCyDmtNPpRnHJircDL26kf6kEMJnx26HpVXm4d2z67mRc0JTXOHI26Lse3OVSYZpQ+Cb6BXaHNJ06L0HBwO7f/zaAdBcWm+Lp/cyQ5iouBMXba7r0GY+mmvEpMLHfpiX1mN46MTgZl4YsMAV26EVO/ESlP94qT4aXPL5RqNEQ4ALz+cNrc+FL/LyH7XTtPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.86; helo=out28-86.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.86; helo=out28-86.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-86.mail.aliyun.com (out28-86.mail.aliyun.com [115.124.28.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW5HL2Jhwz2yr9
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 13:36:12 +1000 (AEST)
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.elEze0Z_1758598565 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 11:36:06 +0800
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
Subject: Re: [PATCH v4] erofs-utils: oci: add support for indexing by layer
 digest
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <4aaa8d40-f49e-40d8-a972-3ee2bdd8de31@linux.alibaba.com>
Date: Tue, 23 Sep 2025 11:35:55 +0800
Cc: linux-erofs@lists.ozlabs.org,
 xiang@kernel.org,
 Chengyu Zhu <hudsonzhu@tencent.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8B444F0-9943-4AC8-B49C-30B80C6A389E@cyzhu.com>
References: <20250916153415.93839-1-hudson@cyzhu.com>
 <20250923025501.59542-1-hudson@cyzhu.com>
 <4aaa8d40-f49e-40d8-a972-3ee2bdd8de31@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Sure. I=E2=80=99ll make these changes.

Thanks,
Chengyu

> 2025=E5=B9=B49=E6=9C=8823=E6=97=A5 11:19=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 2025/9/23 10:55, ChengyuZhu6 wrote:
>> From: Chengyu Zhu <hudsonzhu@tencent.com>
>> Add support for indexing by layer_digest string for more precise
>> and reliable OCI layer identification. This change affects both =
mkfs.erofs
>> and mount.erofs tools.
>> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
>> ---
>>  lib/liberofs_oci.h |   6 +-
>>  lib/remotes/oci.c  |  87 +++++++++++++++++++-------
>>  mkfs/main.c        |  78 ++++++++++++++---------
>>  mount/main.c       | 153 =
++++++++++++++++++++++++++++++++-------------
>>  4 files changed, 228 insertions(+), 96 deletions(-)
>> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
>> index aa41141..621eb2b 100644
>> --- a/lib/liberofs_oci.h
>> +++ b/lib/liberofs_oci.h
>> @@ -21,7 +21,8 @@ struct erofs_importer;
>>   * @platform: target platform in "os/arch" format (e.g., =
"linux/amd64")
>>   * @username: username for authentication (optional)
>>   * @password: password for authentication (optional)
>> - * @layer_index: specific layer to extract (-1 for all layers)
>> + * @layer_digest: specific layer digest to extract (NULL for all =
layers)
>=20
> blob_digest?
>=20
>> + * @layer_index: specific layer index to extract (negative for all =
layers)
>>   *
>>   * Configuration structure for OCI image parameters including =
registry
>>   * location, image identification, platform specification, and =
authentication
>> @@ -32,6 +33,7 @@ struct ocierofs_config {
>>  	char *platform;
>>  	char *username;
>>  	char *password;
>> +	char *layer_digest;
>=20
> blob_digest?
>=20
>>  	int layer_index;
>>  };
>>  @@ -51,7 +53,7 @@ struct ocierofs_ctx {
>>  	char *tag;
>>  	char *manifest_digest;
>>  	struct ocierofs_layer_info **layers;
>> -	int layer_index;
>> +	char *layer_digest;
>=20
> blob_digest?
>=20
>>  	int layer_count;
>>  };
>>  diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
>> index 26aec27..b6118da 100644
>> --- a/lib/remotes/oci.c
>> +++ b/lib/remotes/oci.c
>> @@ -898,6 +898,20 @@ static int ocierofs_prepare_auth(struct =
ocierofs_ctx *ctx,
>>  	return 0;
>>  }
>>  +static int ocierofs_find_layer_by_digest(struct ocierofs_ctx *ctx, =
const char *digest)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < ctx->layer_count; i++) {
>> +		DBG_BUGON(!ctx->layers[i]);
>> +		DBG_BUGON(!ctx->layers[i]->digest);
>> +
>> +		if (!strcmp(ctx->layers[i]->digest, digest))
>> +			return i;
>> +	}
>> +	return -1;
>> +}
>> +
>>  static int ocierofs_prepare_layers(struct ocierofs_ctx *ctx,
>>  				   const struct ocierofs_config *config)
>>  {
>> @@ -925,16 +939,34 @@ static int ocierofs_prepare_layers(struct =
ocierofs_ctx *ctx,
>>  		goto out_manifest;
>>  	}
>>  -	if (ctx->layer_index >=3D ctx->layer_count) {
>> -		erofs_err("layer index %d exceeds available layers =
(%d)",
>> -			  ctx->layer_index, ctx->layer_count);
>> -		ret =3D -EINVAL;
>> -		goto out_layers;
>> +	if (!ctx->layer_digest && config->layer_index >=3D 0) {
>> +		if (config->layer_index >=3D ctx->layer_count) {
>> +			erofs_err("layer index %d out of range (0..%d)",
>> +				  config->layer_index, ctx->layer_count =
- 1);
>> +			ret =3D -EINVAL;
>> +			goto out_layers;
>> +		}
>> +		DBG_BUGON(!ctx->layers[config->layer_index]);
>> +		DBG_BUGON(!ctx->layers[config->layer_index]->digest);
>> +		ctx->layer_digest =3D =
strdup(ctx->layers[config->layer_index]->digest);
>> +		if (!ctx->layer_digest) {
>> +			ret =3D -ENOMEM;
>> +			goto out_layers;
>> +		}
>> +	}
>> +
>> +	if (ctx->layer_digest) {
>> +		if (ocierofs_find_layer_by_digest(ctx, =
ctx->layer_digest) < 0) {
>> +			erofs_err("layer digest %s not found in image =
layers",
>> +				  ctx->layer_digest);
>> +			ret =3D -ENOENT;
>> +			goto out_layers;
>> +		}
>>  	}
>>  	return 0;
>>    out_layers:
>> -	free(ctx->layers);
>> +	ocierofs_free_layers_info(ctx->layers, ctx->layer_count);
>>  	ctx->layers =3D NULL;
>>  out_manifest:
>>  	free(ctx->manifest_digest);
>> @@ -1054,10 +1086,10 @@ static int ocierofs_init(struct ocierofs_ctx =
*ctx, const struct ocierofs_config
>>  	if (ocierofs_curl_setup_common_options(ctx->curl))
>>  		return -EIO;
>>  -	if (config->layer_index >=3D 0)
>> -		ctx->layer_index =3D config->layer_index;
>> +	if (config->layer_digest)
>> +		ctx->layer_digest =3D strdup(config->layer_digest);
>>  	else
>> -		ctx->layer_index =3D -1;
>> +		ctx->layer_digest =3D NULL;
>>  	ctx->registry =3D strdup("registry-1.docker.io");
>>  	ctx->tag =3D strdup("latest");
>>  	if (config->platform)
>> @@ -1190,6 +1222,7 @@ static void ocierofs_ctx_cleanup(struct =
ocierofs_ctx *ctx)
>>  	free(ctx->tag);
>>  	free(ctx->platform);
>>  	free(ctx->manifest_digest);
>> +	free(ctx->layer_digest);
>>  }
>>    int ocierofs_build_trees(struct erofs_importer *importer,
>> @@ -1204,8 +1237,13 @@ int ocierofs_build_trees(struct erofs_importer =
*importer,
>>  		return ret;
>>  	}
>>  -	if (ctx.layer_index >=3D 0) {
>> -		i =3D ctx.layer_index;
>> +	if (ctx.layer_digest) {
>> +		i =3D ocierofs_find_layer_by_digest(&ctx, =
ctx.layer_digest);
>> +		if (i < 0) {
>> +			erofs_err("layer digest %s not found", =
ctx.layer_digest);
>> +			ret =3D -ENOENT;
>> +			goto out;
>> +		}
>>  		end =3D i + 1;
>>  	} else {
>>  		i =3D 0;
>> @@ -1215,25 +1253,26 @@ int ocierofs_build_trees(struct =
erofs_importer *importer,
>>  	while (i < end) {
>>  		char *trimmed =3D =
erofs_trim_for_progressinfo(ctx.layers[i]->digest,
>>  				sizeof("Extracting layer  ...") - 1);
>> -		erofs_update_progressinfo("Extracting layer %d: %s ...", =
i,
>> -				  trimmed);
>> +		erofs_update_progressinfo("Extracting layer %s ...", =
trimmed);
>>  		free(trimmed);
>>  		fd =3D ocierofs_extract_layer(&ctx, =
ctx.layers[i]->digest,
>>  					    ctx.auth_header);
>>  		if (fd < 0) {
>> -			erofs_err("failed to extract layer %d: %s", i,
>> -				  erofs_strerror(fd));
>> +			erofs_err("failed to extract layer %s: %s",
>> +				  ctx.layers[i]->digest, =
erofs_strerror(fd));
>> +			ret =3D fd;
>>  			break;
>>  		}
>>  		ret =3D ocierofs_process_tar_stream(importer, fd);
>>  		close(fd);
>>  		if (ret) {
>> -			erofs_err("failed to process tar stream for =
layer %d: %s", i,
>> -				  erofs_strerror(ret));
>> +			erofs_err("failed to process tar stream for =
layer %s: %s",
>> +				  ctx.layers[i]->digest, =
erofs_strerror(ret));
>>  			break;
>>  		}
>>  		i++;
>>  	}
>> +out:
>>  	ocierofs_ctx_cleanup(&ctx);
>>  	return ret;
>>  }
>> @@ -1246,12 +1285,18 @@ static int =
ocierofs_download_blob_range(struct ocierofs_ctx *ctx, off_t offset,
>>  	const char *api_registry;
>>  	char rangehdr[64];
>>  	long http_code =3D 0;
>> -	int ret;
>> -	int index =3D ctx->layer_index;
>> -	u64 blob_size =3D ctx->layers[index]->size;
>> +	int ret, index;
>> +	const char *digest;
>> +	u64 blob_size;
>>  	size_t available;
>>  	size_t copy_size;
>>  +	index =3D ocierofs_find_layer_by_digest(ctx, ctx->layer_digest);
>> +	if (index < 0)
>> +		return -ENOENT;
>> +	digest =3D ctx->layer_digest;
>> +	blob_size =3D ctx->layers[index]->size;
>> +
>>  	if (offset < 0)
>>  		return -EINVAL;
>>  @@ -1265,7 +1310,7 @@ static int ocierofs_download_blob_range(struct =
ocierofs_ctx *ctx, off_t offset,
>>    	api_registry =3D ocierofs_get_api_registry(ctx->registry);
>>  	if (asprintf(&req.url, "https://%s/v2/%s/blobs/%s",
>> -	     api_registry, ctx->repository, ctx->layers[index]->digest) =
=3D=3D -1)
>> +	     api_registry, ctx->repository, digest) =3D=3D -1)
>>  		return -ENOMEM;
>>    	if (length)
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index 50e2bdb..6eb4203 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -215,9 +215,10 @@ static void usage(int argc, char **argv)
>>  #endif
>>  #ifdef OCIEROFS_ENABLED
>>  		" --oci[=3Dplatform=3DX]    X=3Dplatform (default: =
linux/amd64)\n"
>> -		"   [,layer=3DY]          Y=3Dlayer index to extract =
(0-based; omit to extract all layers)\n"
>> -		"   [,username=3DZ]       Z=3Dusername for =
authentication (optional)\n"
>> -		"   [,password=3DW]       W=3Dpassword for =
authentication (optional)\n"
>> +		"   [,layer_index=3DY]    Y=3Dlayer index to extract =
(0-based; omit to extract all layers)\n"
>> +		"   [,layer_digest=3DZ]   Z=3Dlayer digest to extract =
(omit to extract all layers)\n"
>=20
> Can we use
> 		"   [,layer=3D#]          #=3Dlayer index to extract =
(0-based; omit to extract all layers)\n"
> 		"   [,blob=3DY]           Y=3Dlayer digest to extract =
(omit to extract all layers)\n"
>=20
> instead?
>=20
>> +		"   [,username=3DW]       W=3Dusername for =
authentication (optional)\n"
>> +		"   [,password=3DV]       V=3Dpassword for =
authentication (optional)\n"
>>  #endif
>>  		" --tar=3DX               generate a full or index-only =
image from a tarball(-ish) source\n"
>>  		"                       (X =3D f|i|headerball; f=3Dfull =
mode, i=3Dindex mode,\n"
>> @@ -707,13 +708,14 @@ static int mkfs_parse_s3_cfg(char *cfg_str)
>>   * @options_str: comma-separated options string
>>   *
>>   * Parse OCI options string containing comma-separated key=3Dvalue =
pairs.
>> - * Supported options include platform, layer, username, and =
password.
>> + * Supported options include platform, layer_digest, layer_index, =
username, and password.
>>   *
>>   * Return: 0 on success, negative errno on failure
>>   */
>>  static int mkfs_parse_oci_options(struct ocierofs_config *oci_cfg, =
char *options_str)
>>  {
>>  	char *opt, *q, *p;
>> +	long idx;
>>    	if (!options_str)
>>  		return 0;
>> @@ -732,40 +734,57 @@ static int mkfs_parse_oci_options(struct =
ocierofs_config *oci_cfg, char *options
>>  			if (!oci_cfg->platform)
>>  				return -ENOMEM;
>>  		} else {
>> -			p =3D strstr(opt, "layer=3D");
>> +			p =3D strstr(opt, "layer_digest=3D");
>=20
>=20
> layer=3D
>=20
>>  			if (p) {
>> -				p +=3D strlen("layer=3D");
>> -				{
>> -					char *endptr;
>> -					unsigned long v =3D strtoul(p, =
&endptr, 10);
>> -
>> -					if (endptr =3D=3D p || *endptr =
!=3D '\0') {
>> -						erofs_err("invalid layer =
index %s",
>> -						  p);
>> -						return -EINVAL;
>> -					}
>> -					oci_cfg->layer_index =3D (int)v;
>> +				p +=3D strlen("layer_digest=3D");
>=20
>=20
> blob=3D
>=20
>> +				free(oci_cfg->layer_digest);
>> +
>> +				if (oci_cfg->layer_index >=3D 0) {
>> +					erofs_err("invalid --oci: =
layer_digest and layer_index cannot be set together");
>> +					return -EINVAL;
>> +				}
>> +
>> +				if (strncmp(p, "sha256:", 7) !=3D 0) {
>> +					if =
(asprintf(&oci_cfg->layer_digest, "sha256:%s", p) < 0)
>> +						return -ENOMEM;
>> +				} else {
>> +					oci_cfg->layer_digest =3D =
strdup(p);
>> +					if (!oci_cfg->layer_digest)
>> +						return -ENOMEM;
>>  				}
>>  			} else {
>> -				p =3D strstr(opt, "username=3D");
>> +				p =3D strstr(opt, "layer_index=3D");
>>  				if (p) {
>> -					p +=3D strlen("username=3D");
>> -					free(oci_cfg->username);
>> -					oci_cfg->username =3D strdup(p);
>> -					if (!oci_cfg->username)
>> -						return -ENOMEM;
>> +					p +=3D strlen("layer_index=3D");
>> +					if (oci_cfg->layer_digest) {
>> +						erofs_err("invalid =
--oci: layer_index and layer_digest cannot be set together");
>> +						return -EINVAL;
>> +					}
>> +					idx =3D strtol(p, NULL, 10);
>> +					if (idx < 0)
>> +						return -EINVAL;
>> +					oci_cfg->layer_index =3D =
(int)idx;
>>  				} else {
>> +					p =3D strstr(opt, "username=3D");
>> +					if (p) {
>> +						p +=3D =
strlen("username=3D");
>> +						free(oci_cfg->username);
>> +						oci_cfg->username =3D =
strdup(p);
>> +						if (!oci_cfg->username)
>> +							return -ENOMEM;
>> +					}
>> +
>>  					p =3D strstr(opt, "password=3D");
>>  					if (p) {
>>  						p +=3D =
strlen("password=3D");
>> -					free(oci_cfg->password);
>> -					oci_cfg->password =3D strdup(p);
>> -					if (!oci_cfg->password)
>> -						return -ENOMEM;
>> -					} else {
>> -						erofs_err("mkfs: invalid =
--oci value %s", opt);
>> -						return -EINVAL;
>> +						free(oci_cfg->password);
>> +						oci_cfg->password =3D =
strdup(p);
>> +						if (!oci_cfg->password)
>> +							return -ENOMEM;
>>  					}
>> +
>> +					erofs_err("mkfs: invalid --oci =
value %s", opt);
>> +					return -EINVAL;
>>  				}
>>  			}
>>  		}
>> @@ -1850,6 +1869,7 @@ int main(int argc, char **argv)
>>  #endif
>>  #ifdef OCIEROFS_ENABLED
>>  		} else if (source_mode =3D=3D EROFS_MKFS_SOURCE_OCI) {
>> +			ocicfg.layer_digest =3D NULL;
>>  			ocicfg.layer_index =3D -1;
>>    			err =3D mkfs_parse_oci_options(&ocicfg, =
mkfs_oci_options);
>> diff --git a/mount/main.c b/mount/main.c
>> index f368746..323d1de 100644
>> --- a/mount/main.c
>> +++ b/mount/main.c
>> @@ -81,51 +81,76 @@ static int erofsmount_parse_oci_option(const char =
*option)
>>  {
>>  	struct ocierofs_config *oci_cfg =3D &nbdsrc.ocicfg;
>>  	char *p;
>> +	long idx;
>>  -	p =3D strstr(option, "oci.layer=3D");
>> +	if (oci_cfg->layer_index =3D=3D 0 && !oci_cfg->layer_digest &&
>> +	    !oci_cfg->platform && !oci_cfg->username && =
!oci_cfg->password)
>> +		oci_cfg->layer_index =3D -1;
>> +
>> +	p =3D strstr(option, "oci.layer_digest=3D");
>>  	if (p !=3D NULL) {
>> -		p +=3D strlen("oci.layer=3D");
>> -		{
>> -			char *endptr;
>> -			unsigned long v =3D strtoul(p, &endptr, 10);
>> +		p +=3D strlen("oci.layer_digest=3D");
>=20
> oci.blob=3D
>=20
>> +		free(oci_cfg->layer_digest);
>>  -			if (endptr =3D=3D p || *endptr !=3D '\0')
>> -				return -EINVAL;
>> -			oci_cfg->layer_index =3D (int)v;
>> +		if (oci_cfg->layer_index >=3D 0) {
>> +			erofs_err("invalid options: oci.layer_digest and =
oci.layer_index cannot be set together");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (strncmp(p, "sha256:", 7) !=3D 0) {
>> +			if (asprintf(&oci_cfg->layer_digest, =
"sha256:%s", p) < 0)
>> +				return -ENOMEM;
>> +		} else {
>> +			oci_cfg->layer_digest =3D strdup(p);
>> +			if (!oci_cfg->layer_digest)
>> +				return -ENOMEM;
>>  		}
>>  	} else {
>> -		p =3D strstr(option, "oci.platform=3D");
>> +		p =3D strstr(option, "oci.layer_index=3D");
>=20
> oci.layer =3D
>=20
>=20
> Thanks,
> Gao Xiang


