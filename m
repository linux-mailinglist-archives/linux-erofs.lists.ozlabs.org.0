Return-Path: <linux-erofs+bounces-909-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910FFB351F1
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Aug 2025 04:55:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9sjZ5pdCz3d39;
	Tue, 26 Aug 2025 12:55:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756176946;
	cv=none; b=G1oOL+dz/k3Q5MLru454q70uYqgrjKinr9ylH49LiMghTR9SN6dCxHtMXm29BUlThhXW52pUE2vwOlqJy77ymSe7940LrbSGZ6T6kFIA97fg9NHiU90RJD+GXRuMFP2WaauLJIaEseZd3OJvXAoPf+WuMW0sJKmRkQp6U9VSupfeHn9HbivlbFhTUaL5d90dDWBZd3mm1o7cmaj+6v++GaiuwJcT5bbnCRGVSGe84giVRudSiorg4Ky8zSL1+0eg0BcTh7rZc0XHNlLRXIax/rinPhntg7VW5XsBkmdKveYlX+pajtTHFHwmA/7IgegJkqfmhSrjIzv0LnHNxgibdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756176946; c=relaxed/relaxed;
	bh=vUynzJbNVEKapRGO4eTa2s0fTZgahlzoh/r/ZGd/8mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrtHjNyVqYOz1CB3RieJzomWUjDfvTPbi+pOlUjTUrX2S0zOYPyYD/LtXahSkxCqFR4D4WGT/eZIUatGoRlskTKdjaQI/I3pJqnS+gzfjz7WXWwwERK9mkMvKk20Oed6HwvomNQgp8HfF+P0PqiPgkCh/k7VNMqv4WOuzEPy4BqKiZdM34dyNZB/PY3jEBp73kscF/UM23kdPtAjcd6Eaft9xvh+89ixcMKSyYgWaeiAzpHjtWegV1J1aX4iT5ZHZ9aTGCbuwhv6jPUL4aoYGt2sNxYeTeQYRrBLssbUb2C/UnW/RFguxM1sgQawtXFqEEiAU6bBMy6rIqwTkOqvlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=etP5Xi6A; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=etP5Xi6A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9sjX2qF6z3cxn
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Aug 2025 12:55:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756176939; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vUynzJbNVEKapRGO4eTa2s0fTZgahlzoh/r/ZGd/8mU=;
	b=etP5Xi6AFaL3kP+UC399WNwlimizbQwZvKllP8kAzGGVPLR5FtCWkgjWYer3JkA9U05kuIrurQtxiuyG74KX0p/+nfgpFUhkF8ii0FYgikyL+6JwovTPB+U1P72qmRPcJLPTlhB4EjEn7o2Tz8xBwaFjivTNIl7dFMk7CDCGWWU=
Received: from 30.221.130.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wmc6Rws_1756176937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Aug 2025 10:55:38 +0800
Message-ID: <f82733e9-1a68-4b80-8c28-8bf0d8449299@linux.alibaba.com>
Date: Tue, 26 Aug 2025 10:55:37 +0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6-rebased] erofs-utils: add OCI registry support
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>,
 Changzhi Xie <sa.z@qq.com>
References: <20250821073258.89073-1-hudson@cyzhu.com>
 <20250825093301.9227-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250825093301.9227-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

On 2025/8/25 17:33, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> This patch adds support for building EROFS filesystems from
> OCI-compliant container registries, enabling users to create EROFS
> images directly from container images stored in registries like
> Docker Hub, Quay.io, etc.
> 
> The implementation includes:
> - OCI remote backend with registry authentication support
> - Manifest parsing for Docker v2 and OCI v1 formats
> - Layer extraction and tar processing integration
> - Multi-platform image selection capability
> - Both anonymous and authenticated registry access
> - Comprehensive build system integration
> 
> Configure: ./configure --enable-oci
> New mkfs.erofs option: --oci-options=[option] target source-image
> 
> Supported options:
> - platform=os/arch (default: linux/amd64)
> - layer=N (extract specific layer, default: all layers)
> - username/password (basic authentication)
> 
> e.g.:
> - mkfs.erofs \
>    --oci-options=platform=linux/amd64, \
>    username=1234,password=1234 \
>    image.erofs ubuntu
> 
> Signed-off-by: Changzhi Xie <sa.z@qq.com>
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

Can you apply the following diff to your v6-rebased first?

diff --git a/configure.ac b/configure.ac
index 85d055f..7db4489 100644
--- a/configure.ac
+++ b/configure.ac
@@ -651,7 +651,9 @@ AS_IF([test "x$with_json_c" != "xno"], [
      LIBS="${saved_LIBS}"
      CPPFLAGS="${saved_CPPFLAGS}"
    ], [
-    AC_MSG_ERROR([Cannot find proper json-c])
+    AS_IF([test "x$with_json_c" = "xyes"], [
+      AC_MSG_ERROR([Cannot find proper json-c])
+    ])
    ])
  ])

diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
index c4a4c78..0cde24e 100644
--- a/lib/liberofs_oci.h
+++ b/lib/liberofs_oci.h
@@ -76,12 +76,10 @@ int erofs_oci_params_set_string(char **field, const char *value);
   * ocierofs_build_trees - Build file trees from OCI container image layers
   * @root:     root inode to build the file tree under
   * @oci:      OCI client structure with configured parameters
- * @fillzero: if true, only create inodes without downloading actual data
   *
   * Return: 0 on success, negative errno on failure
   */
-int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci,
-			 bool fillzero);
+int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci);

  #ifdef __cplusplus
  }
diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
index 7f167e1..1a217d5 100644
--- a/lib/remotes/oci.c
+++ b/lib/remotes/oci.c
@@ -102,7 +102,6 @@ static int ocierofs_curl_setup_common_options(struct CURL *curl)
  	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 120L);
  	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);
  	curl_easy_setopt(curl, CURLOPT_USERAGENT, "ocierofs/" PACKAGE_VERSION);
-
  	return 0;
  }

@@ -821,8 +820,7 @@ out:
  	return ret;
  }

-int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci,
-			 bool fillzero)
+int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci)
  {
  	char *auth_header = NULL;
  	char *manifest_digest = NULL;
@@ -881,54 +879,34 @@ int ocierofs_build_trees(struct erofs_importer *importer, struct erofs_oci *oci,
  	}

  	if (oci->params.layer_index >= 0) {
-		char *trimmed;
-
  		if (oci->params.layer_index >= layer_count) {
  			erofs_err("layer index %d exceeds available layers (%d)",
  				  oci->params.layer_index, layer_count);
  			ret = -EINVAL;
  			goto out_layers;
  		}
-
+		layer_count = 1;
  		i = oci->params.layer_index;
-		trimmed = erofs_trim_for_progressinfo(layers_info[i],
+	} else {
+		i = 0;
+	}
+
+	while (i < layer_count) {
+		char *trimmed = erofs_trim_for_progressinfo(layers_info[i],
  				sizeof("Extracting layer  ...") - 1);
-		erofs_update_progressinfo("Extracting layer %d: %s ...", i,
-					  trimmed);
+
+		erofs_update_progressinfo("Extracting layer %s ...", trimmed);
  		free(trimmed);

-		if (!fillzero) {
-			ret = ocierofs_extract_layer(oci, importer, layers_info[i],
-						    auth_header, i);
-			if (ret) {
-				erofs_err("failed to extract layer %d: %s", i,
-					  erofs_strerror(ret));
-				goto out_layers;
-			}
-		}
-	} else {
-		for (i = 0; i < layer_count; i++) {
-			char *trimmed = erofs_trim_for_progressinfo(layers_info[i],
-					sizeof("Extracting layer  ...") - 1);
-			erofs_update_progressinfo("Extracting layer %s ...",
-					  trimmed);
-			free(trimmed);
-
-			if (fillzero)
-				continue;
-
-			ret = ocierofs_extract_layer(oci, importer, layers_info[i],
-						    auth_header, i);
-			if (ret) {
-				erofs_err("failed to extract layer %d: %s", i,
-					  erofs_strerror(ret));
-				goto out_layers;
-			}
+		ret = ocierofs_extract_layer(oci, importer, layers_info[i],
+					    auth_header, i);
+		if (ret) {
+			erofs_err("failed to extract layer %d: %s", i,
+				  erofs_strerror(ret));
+			break;
  		}
  	}

-	ret = 0;
-
  out_layers:
  	for (i = 0; i < layer_count; i++)
  		free(layers_info[i]);
@@ -943,7 +921,6 @@ out_auth:
  	    !auth_header) {
  		ocierofs_curl_clear_auth(oci->curl);
  	}
-
  out:
  	return ret;
  }
@@ -955,14 +932,9 @@ int ocierofs_init(struct erofs_oci *oci)

  	memset(oci, 0, sizeof(*oci));

-	if (curl_global_init(CURL_GLOBAL_DEFAULT) != CURLE_OK)
-		return -EIO;
-
  	oci->curl = curl_easy_init();
-	if (!oci->curl) {
-		curl_global_cleanup();
+	if (!oci->curl)
  		return -EIO;
-	}

  	if (ocierofs_curl_setup_common_options(oci->curl)) {
  		ocierofs_cleanup(oci);
@@ -977,9 +949,7 @@ int ocierofs_init(struct erofs_oci *oci)
  		ocierofs_cleanup(oci);
  		return -ENOMEM;
  	}
-
  	oci->params.layer_index = -1; /* -1 means extract all layers */
-
  	return 0;
  }

@@ -992,8 +962,6 @@ void ocierofs_cleanup(struct erofs_oci *oci)
  		curl_easy_cleanup(oci->curl);
  		oci->curl = NULL;
  	}
-	curl_global_cleanup();
-
  	free(oci->params.registry);
  	free(oci->params.repository);
  	free(oci->params.tag);
diff --git a/mkfs/main.c b/mkfs/main.c
index 897b4ba..573adc3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -2000,11 +2000,11 @@ int main(int argc, char **argv)
  				goto exit;

  			if (incremental_mode ||
-			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP)
+			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_RVSP ||
+			    dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL)
  				err = -EOPNOTSUPP;
  			else
-				err = ocierofs_build_trees(&importer, &ocicfg,
-					dataimport_mode == EROFS_MKFS_DATA_IMPORT_ZEROFILL);
+				err = ocierofs_build_trees(&importer, &ocicfg);
  			if (err)
  				goto exit;
  #endif
--
2.43.5


Also I have some other comments when trying:

> ---

...

> diff --git a/mkfs/main.c b/mkfs/main.c
> index e0ba55d..403cd6a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -32,6 +32,7 @@
>   #include "../lib/liberofs_uuid.h"
>   #include "../lib/liberofs_metabox.h"
>   #include "../lib/liberofs_s3.h"
> +#include "../lib/liberofs_oci.h"
>   #include "../lib/compressor.h"
>   
>   static struct option long_options[] = {
> @@ -95,6 +96,9 @@ static struct option long_options[] = {
>   	{"vmdk-desc", required_argument, NULL, 532},
>   #ifdef S3EROFS_ENABLED
>   	{"s3", required_argument, NULL, 533},
> +#endif
> +#ifdef OCIEROFS_ENABLED
> +	{"oci-options", required_argument, NULL, 534},

Can we just use `--oci` instead? and optional_argument.

>   #endif
>   	{0, 0, 0, 0},
>   };
> @@ -206,6 +210,14 @@ static void usage(int argc, char **argv)
>   		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
>   		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
>   		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
> +#endif
> +#ifdef OCIEROFS_ENABLED
> +		" --oci-options=X       specify OCI options\n"


		" --oci[=platform=X]    X=platform (default: linux/amd64)\n"
		"   [,layer=Y]          Y=layer index to extract (0-based; omit to extract all layers)\n"
		"   [,username=Z]       Z="
		....


> +		"   X=platform=Y,layer=Z,username=U,password=P\n"


> +
> +static int parse_oci_password_option(const char *opt, char *options_copy)
> +{
> +	const char *p;
> +
> +	p = strstr(opt, "password=");
> +	if (p) {
> +		if (erofs_oci_params_set_string(&ocicfg.params.password,
> +						p + strlen("password="))) {
> +			erofs_err("failed to set password");
> +			free(options_copy);
> +			return -ENOMEM;
> +		}
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int mkfs_parse_oci_options(const char *options_str)
> +{
> +	char *opt, *q, *options_copy;
> +	int ret;
> +
> +	if (!options_str)
> +		return 0;
> +
> +	options_copy = strdup(options_str);
> +	if (!options_copy)
> +		return -ENOMEM;

Could we just avoid options_copy here? see:
mkfs_parse_s3_cfg() as an example.

> +
> +	opt = options_copy;
> +	while (opt) {
> +		q = strchr(opt, ',');
> +		if (q)
> +			*q = '\0';
> +
> +		ret = parse_oci_platform_option(opt, options_copy);
> +		if (ret == 0) {
> +			opt = q ? q + 1 : NULL;
> +			continue;
> +		}

What if ret == -ENOMEM here? it will just step down
to the rest, how about just follow mkfs_parse_s3_cfg() style?

Also I have a small question:

for example, I can pull image with:
$ nerdctl pull docker.xuanyuan.me/library/ubuntu:22.04

but with mkfs.erofs:

$mkfs/mkfs.erofs --oci-options=platform=linux/amd64 image.erofs docker.xuanyuan.me/library/ubuntu:22.04 -d9
mkfs.erofs 1.8.10-g15844856-dirty
<I> erofs_io: erofs_dev_open() Line[357] successfully to open image.erofs
         c_version:           [1.8.10-g15844856-dirty]
         c_dbg_lvl:           [       9]
         c_dry_run:           [       0]
<D> erofs: ocierofs_get_auth_token_with_url() Line[313] Requesting auth token from: https://docker.xuanyuan.me/token/auth.docker.io?service=docker.xuanyuan.me&scope=repository:library/ubuntu:pull
<E> erofs: ocierofs_build_trees() Line[866] failed to get manifest digest: [Error 5] Input/output error
<E> erofs: main() Line[2089]    Could not format the device : [Error 5] Input/output error

It just fails, it seems it still has some issue with anonymous
access?

Thanks,
Gao Xiang

