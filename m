Return-Path: <linux-erofs+bounces-798-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818ABB1E129
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 06:10:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byrD30wgzz30WY;
	Fri,  8 Aug 2025 14:10:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754626227;
	cv=none; b=O3brzA1HylM8XvOK/sUl+BcAyxztbge11WTZ172RFC01I9iS/PaCBHwnRSBiCjo+0o0pN0vbQYLMtGAB18y5axj9u5tNa0gHPOgy4i8g9kUZRd8hp3o3hYCCsbuaILV7xOKw8an7Wu4bbhDdExRGggkqc8tqFgpgrl1d1WgOaFxNDCiYnPrVlAaaipzFjJNsMdhuJKqocIbOYphwZsPu5GX5i2zPv1mQ6avnBo+J+GMcHzQwzFontqSuVnw0zM+OOb0OdAEioMbWezVPh0uYYW/MDj/03YHkN8RlEK1XrwEh7hRLMNiVu1q/EvTfj/Co2ZGJq3oJrK/mldseNzLfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754626227; c=relaxed/relaxed;
	bh=ip1BuXqqOztiRa0yw0eEtZb/48wO2cFsOwW3BjWfQqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CGw9t4VCS2vqgn+/6XRDz4xBhfSQQ96/aU4xCVz73abi06DFc0U9ZZfLW4p0ESK1z9Z1pLAxspHJsd8q/dDbPrHRMS9cYAv4Avo68IdscYlL9u/T3RLb8To9nNe/cSjwjdAVxfMM+6QhnM5xLxUF1tdy6H2Ur6T446vzf4FbYk8qUwxiEPydff9N5X+SAeGX4vFOYPX5JR+26muxEsPRB88GgSa7xjGgiYa9TsoSk07d5dvItd2M/xw1gJfUmX805X10H3k0Ml4XtsmGNBSo8I2gvKQxYgSXErRutQmTNHBpJqB6U9EPFYHkJcDNzVSGmm4tGkEmKKHlSqOgU9xSnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byrD209p3z2xcC
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 14:10:25 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4byqjS52h9z13Mnf;
	Fri,  8 Aug 2025 11:47:24 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D9EF180080;
	Fri,  8 Aug 2025 11:50:42 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 11:50:41 +0800
Message-ID: <3f0e8f62-5546-474b-93eb-e3bbd9f17d3c@huawei.com>
Date: Fri, 8 Aug 2025 11:50:41 +0800
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
Subject: Re: [PATCH v7 3/4] erofs-utils: mkfs: introduce --s3=... option
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: Yifan Zhao <zhaoyifan28@huawei.com>
References: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
 <20250808031508.346771-3-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250808031508.346771-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Xiang,

On 2025/8/8 11:15, Gao Xiang wrote:
> From: Yifan Zhao <zhaoyifan28@huawei.com>
> 
> It introduces configuration options for the upcoming experimental S3
> support, including configuration parsing and `passwd_file` reading
> logic.
> 
> Users can specify the following options:
>   - S3 service endpoint (required);
>   - S3 credentials file in the format $ak:%sk (optional);
>   - S3 API calling style (optional);
>   - S3 API signature version (optional, only V2 is currently supported).
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   lib/liberofs_s3.h |  40 ++++++++
>   mkfs/main.c       | 226 +++++++++++++++++++++++++++++++++++++++-------
>   2 files changed, 234 insertions(+), 32 deletions(-)
>   create mode 100644 lib/liberofs_s3.h
> 
> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
> new file mode 100644
> index 0000000..4d3555e
> --- /dev/null
> +++ b/lib/liberofs_s3.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/*
> + * Copyright (C) 2025 HUAWEI, Inc.
> + *             http://www.huawei.com/
> + * Created by Yifan Zhao <zhaoyifan28@huawei.com>
> + */
> +#ifndef __EROFS_S3_H
> +#define __EROFS_S3_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +enum s3erofs_url_style {
> +	S3EROFS_URL_STYLE_PATH,          // Path style: https://s3.amazonaws.com/bucket/object
> +	S3EROFS_URL_STYLE_VIRTUAL_HOST,  // Virtual host style: https://bucket.s3.amazonaws.com/object
> +};
> +
> +enum s3erofs_signature_version {
> +	S3EROFS_SIGNATURE_VERSION_2,
> +	S3EROFS_SIGNATURE_VERSION_4,
> +};
> +
> +#define S3_ACCESS_KEY_LEN 256
> +#define S3_SECRET_KEY_LEN 256
> +
> +struct erofs_s3 {
> +	const char *endpoint;
> +	char access_key[S3_ACCESS_KEY_LEN + 1];
> +	char secret_key[S3_SECRET_KEY_LEN + 1];
> +
> +	enum s3erofs_url_style url_style;
> +	enum s3erofs_signature_version sig;
> +};
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ab27b77..a7d3f31 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -31,6 +31,7 @@
>   #include "../lib/liberofs_private.h"
>   #include "../lib/liberofs_uuid.h"
>   #include "../lib/liberofs_metabox.h"
> +#include "../lib/liberofs_s3.h"
>   #include "../lib/compressor.h"
>   
>   static struct option long_options[] = {
> @@ -92,6 +93,9 @@ static struct option long_options[] = {
>   #endif
>   	{"fsalignblks", required_argument, NULL, 531},
>   	{"vmdk-desc", required_argument, NULL, 532},
> +#ifdef S3EROFS_ENABLED
> +	{"s3", required_argument, NULL, 533},
> +#endif
>   	{0, 0, 0, 0},
>   };
>   
> @@ -174,8 +178,8 @@ static void usage(int argc, char **argv)
>   		" --chunksize=#         generate chunk-based files with #-byte chunks\n"
>   		" --clean=X             run full clean build (default) or:\n"
>   		" --incremental=X       run incremental build\n"
> -		"                       (X = data|rvsp; data=full data, rvsp=space is allocated\n"
> -		"                                       and filled with zeroes)\n"
> +		"                       X = data|rvsp|0 (data: full data, rvsp: space fallocated\n"
> +		"                                        0: inodes zeroed)\n"
>   		" --compress-hints=X    specify a file to configure per-file compression strategy\n"
>   		" --dsunit=#            align all data block addresses to multiples of #\n"
>   		" --exclude-path=X      avoid including file X (X = exact literal path)\n"
> @@ -197,6 +201,12 @@ static void usage(int argc, char **argv)
>   		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
>   		" --aufs                replace aufs special files with overlayfs metadata\n"
>   		" --sort=<path,none>    data sorting order for tarballs as input (default: path)\n"
> +#ifdef S3EROFS_ENABLED
> +		" --s3=X                generate an image from S3-compatible object store\n"
> +		"   [,passwd_file=Y]    X=endpoint, Y=s3fs-compatible password file\n"
> +		"   [,urlstyle=Z]       S3 API calling style (Z = vhost|path) (default: vhost)\n"
> +		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
> +#endif
>   		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
>   		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
>   		"                                            headerball=file data is omited in the source stream)\n"
> @@ -247,16 +257,23 @@ static struct erofs_tarfile erofstar = {
>   static bool incremental_mode;
>   static u8 metabox_algorithmid;
>   
> +#ifdef S3EROFS_ENABLED
> +static struct erofs_s3 s3cfg;
> +#endif
> +
>   enum {
>   	EROFS_MKFS_DATA_IMPORT_DEFAULT,
>   	EROFS_MKFS_DATA_IMPORT_FULLDATA,
>   	EROFS_MKFS_DATA_IMPORT_RVSP,
> -	EROFS_MKFS_DATA_IMPORT_SPARSE,
> +	EROFS_MKFS_DATA_IMPORT_ZEROFILL,
>   } dataimport_mode;
>   
>   static enum {
>   	EROFS_MKFS_SOURCE_LOCALDIR,
>   	EROFS_MKFS_SOURCE_TAR,
> +#ifdef S3EROFS_ENABLED
> +	EROFS_MKFS_SOURCE_S3,
> +#endif
>   	EROFS_MKFS_SOURCE_REBUILD,
>   } source_mode;
>   
> @@ -522,6 +539,137 @@ static void mkfs_parse_tar_cfg(char *cfg)
>   		erofstar.index_mode = true;
>   }
>   
> +#ifdef S3EROFS_ENABLED
> +static int mkfs_parse_s3_cfg_passwd(const char *filepath, char *ak, char *sk)
> +{
> +	struct stat st;
> +	int fd, n, ret;
> +	char buf[S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3];
> +	char *colon;
> +
> +	fd = open(filepath, O_RDONLY);
> +	if (fd < 0) {
> +		erofs_err("failed to open passwd_file %s", filepath);
> +		return -errno;
> +	}
> +
> +	ret = fstat(fd, &st);
> +	if (ret) {
> +		ret = -errno;
> +		goto err;
> +	}
> +
> +	if (!S_ISREG(st.st_mode)) {
> +		erofs_err("%s is not a regular file", filepath);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if ((st.st_mode & 077) != 0)
> +		erofs_warn("passwd_file %s should not be accessible by group or others",
> +			   filepath);
> +
> +	if (st.st_size > S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3) {
> +		erofs_err("passwd_file %s is too large (size: %llu)", filepath,
> +			  st.st_size | 0ULL);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	n = read(fd, buf, st.st_size);
> +	if (n < 0) {
> +		ret = -errno;
> +		goto err;
> +	}
> +	buf[n] = '\0';
> +
> +	while (n > 0 && (buf[n - 1] == '\n' || buf[n - 1] == '\r'))
> +		buf[--n] = '\0';
> +
> +	colon = strchr(buf, ':');
> +	if (!colon) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	*colon = '\0';
> +
> +	strcpy(ak, buf);
> +	strcpy(sk, colon + 1);

How about adding memset on buf? And we also need to add cleanup actions 
for s3cfg to free the endpoint and memset the access_key/secret_key memory.

Therefore, after mkfs.erofs is finished, the ak/sk information will not 
be recorded in the memory.

Thanks,
Hongbo

> +
> +err:
> +	close(fd);
> +	return ret;
> +}
> +
> +static int mkfs_parse_s3_cfg(char *cfg_str)
> +{
> +	char *p, *q, *opt;
> +	int ret = 0;
> +
> +	if (source_mode != EROFS_MKFS_SOURCE_LOCALDIR)
> +		return -EINVAL;
> +	source_mode = EROFS_MKFS_SOURCE_S3;
> +
> +	if (!cfg_str) {
> +		erofs_err("s3: missing parameter");
> +		return -EINVAL;
> +	}
> +
> +	s3cfg.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST;
> +	s3cfg.sig = S3EROFS_SIGNATURE_VERSION_2;
> +
> +	p = strchr(cfg_str, ',');
> +	if (p) {
> +		s3cfg.endpoint = strndup(cfg_str, p - cfg_str);
> +	} else {
> +		s3cfg.endpoint = strdup(cfg_str);
> +		return 0;
> +	}
> +
> +	opt = p + 1;
> +	while (opt) {
> +		q = strchr(opt, ',');
> +		if (q)
> +			*q = '\0';
> +
> +		if ((p = strstr(opt, "passwd_file="))) {
> +			p += sizeof("passwd_file=") - 1;
> +			ret = mkfs_parse_s3_cfg_passwd(p, s3cfg.access_key,
> +						       s3cfg.secret_key);
> +			if (ret)
> +				return ret;
> +		} else if ((p = strstr(opt, "urlstyle="))) {
> +			p += sizeof("urlstyle=") - 1;
> +			if (strncmp(p, "vhost", 5) == 0) {
> +				s3cfg.url_style = S3EROFS_URL_STYLE_VIRTUAL_HOST;
> +			} else if (strncmp(p, "path", 4) == 0) {
> +				s3cfg.url_style = S3EROFS_URL_STYLE_PATH;
> +			} else {
> +				erofs_err("invalid S3 addressing style %s", p);
> +				return -EINVAL;
> +			}
> +		} else if ((p = strstr(opt, "sig="))) {
> +			p += strlen("sig=");
> +			if (strncmp(p, "4", 1) == 0) {
> +				erofs_warn("AWS Signature Version 4 is not supported yet, using Version 2");
> +			} else if (strncmp(p, "2", 1) == 0) {
> +				s3cfg.sig = S3EROFS_SIGNATURE_VERSION_2;
> +			} else {
> +				erofs_err("Invalid AWS Signature Version %s", p);
> +				return -EINVAL;
> +			}
> +		} else {
> +			erofs_err("invalid --s3 option %s", opt);
> +			return -EINVAL;
> +		}
> +
> +		opt = q ? q + 1 : NULL;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>   static int mkfs_parse_one_compress_alg(char *alg,
>   				       struct erofs_compr_opts *copts)
>   {
> @@ -670,6 +818,13 @@ static int mkfs_parse_sources(int argc, char *argv[], int optind)
>   			erofstar.ios.dumpfd = fd;
>   		}
>   		break;
> +#ifdef S3EROFS_ENABLED
> +	case EROFS_MKFS_SOURCE_S3:
> +		cfg.c_src_path = strdup(argv[optind++]);
> +		if (!cfg.c_src_path)
> +			return -ENOMEM;
> +		break;
> +#endif
>   	default:
>   		erofs_err("unexpected source_mode: %d", source_mode);
>   		return -EINVAL;
> @@ -997,6 +1152,8 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   				dataimport_mode = EROFS_MKFS_DATA_IMPORT_FULLDATA;
>   			} else if (!strcmp(optarg, "rvsp")) {
>   				dataimport_mode = EROFS_MKFS_DATA_IMPORT_RVSP;
> +			} else if (!strcmp(optarg, "0")) {
> +				dataimport_mode = EROFS_MKFS_DATA_IMPORT_ZEROFILL;
>   			} else {
>   				errno = 0;
>   				dataimport_mode = strtol(optarg, &endptr, 0);
> @@ -1058,6 +1215,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   				return -EINVAL;
>   			}
>   			break;
> +#ifdef S3EROFS_ENABLED
> +		case 533:
> +			err = mkfs_parse_s3_cfg(optarg);
> +			if (err)
> +				return err;
> +			break;
> +#endif
>   		case 'V':
>   			version();
>   			exit(0);
> @@ -1538,35 +1702,7 @@ int main(int argc, char **argv)
>   
>   	erofs_inode_manager_init();
>   
> -	if (source_mode == EROFS_MKFS_SOURCE_TAR) {
> -		root = erofs_rebuild_make_root(&g_sbi);
> -		if (IS_ERR(root)) {
> -			err = PTR_ERR(root);
> -			goto exit;
> -		}
> -
> -		while (!(err = tarerofs_parse_tar(root, &erofstar)));
> -
> -		if (err < 0)
> -			goto exit;
> -
> -		err = erofs_rebuild_dump_tree(root, incremental_mode);
> -		if (err < 0)
> -			goto exit;
> -	} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
> -		root = erofs_rebuild_make_root(&g_sbi);
> -		if (IS_ERR(root)) {
> -			err = PTR_ERR(root);
> -			goto exit;
> -		}
> -
> -		err = erofs_mkfs_rebuild_load_trees(root);
> -		if (err)
> -			goto exit;
> -		err = erofs_rebuild_dump_tree(root, incremental_mode);
> -		if (err)
> -			goto exit;
> -	} else {
> +	if (source_mode == EROFS_MKFS_SOURCE_LOCALDIR) {
>   		err = erofs_build_shared_xattrs_from_path(&g_sbi, cfg.c_src_path);
>   		if (err) {
>   			erofs_err("failed to build shared xattrs: %s",
> @@ -1583,6 +1719,32 @@ int main(int argc, char **argv)
>   			root = NULL;
>   			goto exit;
>   		}
> +	} else {
> +		root = erofs_rebuild_make_root(&g_sbi);
> +		if (IS_ERR(root)) {
> +			err = PTR_ERR(root);
> +			goto exit;
> +		}
> +
> +		if (source_mode == EROFS_MKFS_SOURCE_TAR) {
> +			while (!(err = tarerofs_parse_tar(root, &erofstar)))
> +				;
> +			if (err < 0)
> +				goto exit;
> +		} else if (source_mode == EROFS_MKFS_SOURCE_REBUILD) {
> +			err = erofs_mkfs_rebuild_load_trees(root);
> +			if (err)
> +				goto exit;
> +#ifdef S3EROFS_ENABLED
> +		} else if (source_mode == EROFS_MKFS_SOURCE_S3) {
> +			err = -EOPNOTSUPP;
> +			goto exit;
> +#endif
> +		}
> +
> +		err = erofs_rebuild_dump_tree(root, incremental_mode);
> +		if (err)
> +			goto exit;
>   	}
>   
>   	if (tar_index_512b) {

