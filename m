Return-Path: <linux-erofs+bounces-1127-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D02F4BA6AC4
	for <lists+linux-erofs@lfdr.de>; Sun, 28 Sep 2025 10:16:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZHGQ3rXzz3cYr;
	Sun, 28 Sep 2025 18:16:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759047390;
	cv=none; b=EyngPlaGgnGm5khBEoV57OXtYxq3Rpq+2TU4aL2vh6zwuTESuASHenigeb9+iI93c8GJMtcKBzUHMIaphhBfyO/bALe2wToPcM0H+h4D1jn3YyPw5pX/7tW5b8tZi4hfUe0snipPUYwDkkaEEsPfPJgy8N9zQU2jyk6CnBoaBp6VlvsqucGTkHH4Kngm8v6fBnMW8Wx6lOUkRR8OzAkOQHov0t4JjkAPH2lexMeZ/HA8RGj4w+Z2Yke50kTU1vbHDSTu4GRi3WG/R6gHF3utR5YXHRdO/paEr4L66IwXHTHLqiWGE9j81K/vDkgG3jLkoZsOVzcBRF6j/TggCgsnWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759047390; c=relaxed/relaxed;
	bh=cvKuF3tHvI6pKCdgXLOvdZUuA4Fh82cPAB5aMaWqOlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onWeKRxRkp8PAg8So1drDEIo365a0TVV5wiCnHw8FIcLBdKcQnXAyR1SK69dqJHVjC+1oeK3qHmooi7RrdLxK2EbT8fXYecA5zj0Rqrusa6m+ofo+etdxMJZcyLZrpfIsyTMoG35R/zHNAizkCN0HxG967Ag8F3wlU53N6bXUTZOIzBmYeqW7ci91q3Ayfh6wIsRU2CjT53WF59AFDGRRGfBtaGf7tEzv8bTodHrp9OqVvojc3YmEWXNkFHvO/sd35yT+Xvta4kRR9qbQ/sIEFgD4Ns2AggZTxYX3R9hW0b63TzdC0ClWrFshn+VPVCuGDX6cxuTHQX5MsuW6zWaUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qcxcFPgR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qcxcFPgR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZHGN2Wl7z302l
	for <linux-erofs@lists.ozlabs.org>; Sun, 28 Sep 2025 18:16:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759047383; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cvKuF3tHvI6pKCdgXLOvdZUuA4Fh82cPAB5aMaWqOlo=;
	b=qcxcFPgR2iWrCAteAk8TkQnnqdBHTEwETDSDdIO5SNtKwRlDn055AwWasa4aGaqzwRtmp8fSdfKJt1v8X0pfLrdsYktcCJYkHeS01Ftm68xS8SuM6QToVdLr1+iPEyu/ek8uR4UL0SoYGGdms1NZ7F5WSbLltbqkrokpQ+jW/F8=
Received: from 30.221.128.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WoyOXqv_1759047380 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 28 Sep 2025 16:16:21 +0800
Message-ID: <4f050eed-d501-49b6-b0dd-d2613cd87944@linux.alibaba.com>
Date: Sun, 28 Sep 2025 16:16:20 +0800
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
Subject: Re: [PATCH v2] erofs-utils: add source support for tarindex and gzran
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250928033957.23867-1-hudson@cyzhu.com>
 <20250928080217.43021-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250928080217.43021-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/9/28 16:02, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Add support for combining tarindex files with remote OCI blobs
> through a new source mechanism. This enables local metadata
> storage while keeping blob data in remote registries.
> 
> e.g.:
> mount.erofs -t erofs.nbd -o \
> 'oci.blob=13b7e9...,oci.platform=linux/amd64,\
> oci.tarindex=ubuntu.erofs,oci.zinfo=ubuntu.zinfo' \
> ubuntu:20.04 /mnt
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/liberofs_oci.h |   2 +
>   lib/remotes/oci.c  |  20 ---
>   mount/main.c       | 397 ++++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 392 insertions(+), 27 deletions(-)
> 
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 71c8879..5298f18 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -35,6 +35,8 @@ struct ocierofs_config {
>   	char *password;
>   	char *blob_digest;
>   	int layer_index;
> +	char *tarindex_path;
> +	char *zinfo_path;
>   };
>   
>   struct ocierofs_layer_info {
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index b2f1f59..b25e0b2 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -1461,19 +1461,6 @@ static void ocierofs_io_close(struct erofs_vfile *vfile)
>   	*(struct ocierofs_iostream **)vfile->payload = NULL;
>   }
>   
> -static int ocierofs_is_erofs_native_image(struct ocierofs_ctx *ctx)
> -{
> -	if (ctx->layer_count > 0 && ctx->layers[0] &&
> -	    ctx->layers[0]->media_type) {
> -		const char *media_type = ctx->layers[0]->media_type;
> -		size_t len = strlen(media_type);
> -
> -		if (len >= 6 && strcmp(media_type + len - 6, ".erofs") == 0)
> -			return 0;
> -	}
> -	return -ENOENT;
> -}
> -
>   static struct erofs_vfops ocierofs_io_vfops = {
>   	.pread = ocierofs_io_pread,
>   	.read = ocierofs_io_read,
> @@ -1497,13 +1484,6 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
>   		return err;
>   	}
>   
> -	err = ocierofs_is_erofs_native_image(ctx);
> -	if (err) {
> -		ocierofs_ctx_cleanup(ctx);
> -		free(ctx);
> -		return err;
> -	}
> -
>   	oci_iostream = calloc(1, sizeof(*oci_iostream));
>   	if (!oci_iostream) {
>   		ocierofs_ctx_cleanup(ctx);
> diff --git a/mount/main.c b/mount/main.c
> index eb0dd01..619bf13 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -16,6 +16,8 @@
>   #include "erofs/io.h"
>   #include "../lib/liberofs_nbd.h"
>   #include "../lib/liberofs_oci.h"
> +#include "../lib/liberofs_gzran.h"
> +
>   #ifdef HAVE_LINUX_LOOP_H
>   #include <linux/loop.h>
>   #else
> @@ -35,6 +37,9 @@ struct loop_info {
>   #include <sys/sysmacros.h>
>   #endif
>   
> +/* Device boundary probe */
> +#define EROFS_IS_DEVICE_PROBE(off) ((off) >= (INT64_MAX >> 9))

I meant just add a macro

#define EROFSMOUNT_NBD_DISK_SIZE	(INT64_MAX >> 9)

> +
>   enum erofs_backend_drv {
>   	EROFSAUTO,
>   	EROFSLOCAL,
> @@ -141,7 +146,25 @@ static int erofsmount_parse_oci_option(const char *option)
>   						if (!oci_cfg->password)
>   							return -ENOMEM;
>   					} else {
> -						return -EINVAL;
> +						p = strstr(option, "oci.tarindex=");
> +						if (p != NULL) {
> +							p += strlen("oci.tarindex=");
> +							free(oci_cfg->tarindex_path);
> +							oci_cfg->tarindex_path = strdup(p);
> +							if (!oci_cfg->tarindex_path)
> +								return -ENOMEM;
> +						} else {
> +							p = strstr(option, "oci.zinfo=");
> +							if (p != NULL) {
> +								p += strlen("oci.zinfo=");
> +								free(oci_cfg->zinfo_path);
> +								oci_cfg->zinfo_path = strdup(p);
> +								if (!oci_cfg->zinfo_path)
> +									return -ENOMEM;
> +							} else {
> +								return -EINVAL;
> +							}
> +						}
>   					}
>   				}
>   			}
> @@ -332,11 +355,284 @@ static int erofsmount_fuse(const char *source, const char *mountpoint,
>   	return 0;
>   }
>   
> +struct erofsmount_tarindex_source {
> +	struct erofs_vfile *tarindex_vf;
> +	struct erofs_vfile *zinfo_vf;
> +	u64 tarindex_size;
> +};
> +
>   struct erofsmount_nbd_ctx {
>   	struct erofs_vfile vd;		/* virtual device */
>   	struct erofs_vfile sk;		/* socket file */
>   };
>   
> +static ssize_t erofs_tarindex_pread(struct erofs_vfile *vf, void *buf,
> +				  size_t count, u64 offset)
> +{
> +	struct erofsmount_tarindex_source *hs;
> +	ssize_t local_read, remote_read;
> +	u64 local_part, remote_part, remote_offset;

index_part and tardata_part may be clearer.

> +
> +	hs = *(struct erofsmount_tarindex_source **)vf->payload;
> +	if (!hs)
> +		return -EINVAL;
> +
> +	/* Handle device boundary probe requests */
> +	if (EROFS_IS_DEVICE_PROBE(offset))
> +		return 0;
> +
> +	if (offset >= hs->tarindex_size) {
> +		remote_offset = offset - hs->tarindex_size;
> +
> +		return hs->zinfo_vf->ops->pread(hs->zinfo_vf, buf, count, remote_offset);
> +	}
> +
> +	if (offset + count <= hs->tarindex_size)
> +		return erofs_io_pread(hs->tarindex_vf, buf, count, offset);
> +
> +	local_part = hs->tarindex_size - offset;
> +	remote_part = count - local_part;
> +
> +	local_read = erofs_io_pread(hs->tarindex_vf, buf, local_part, offset);
> +	if (local_read < 0)
> +		return local_read;
> +
> +	remote_read = hs->zinfo_vf->ops->pread(hs->zinfo_vf,
> +					      (char *)buf + local_read,
> +					      remote_part, 0);
> +	if (remote_read < 0)
> +		return remote_read;
> +	return local_read + remote_read;
> +}
> +
> +static void erofs_tarindex_close(struct erofs_vfile *vf)
> +{
> +	struct erofsmount_tarindex_source *hs;
> +
> +	if (!vf)
> +		return;
> +
> +	hs = *(struct erofsmount_tarindex_source **)vf->payload;
> +	if (!hs)
> +		return;
> +
> +	if (hs->tarindex_size > 0) {
> +		erofs_io_close(hs->tarindex_vf);
> +		free(hs->tarindex_vf);
> +	}
> +
> +	if (hs->zinfo_vf)
> +		erofs_io_close(hs->zinfo_vf);
> +
> +	free(hs);
> +}
> +
> +static int load_file_to_buf(const char *path, void **out, unsigned int *out_len)
> +{
> +	FILE *fp = NULL;
> +	void *buf = NULL;
> +	int ret = 0;
> +	long sz;
> +	size_t num;
> +
> +	fp = fopen(path, "rb");
> +	if (!fp)
> +		return -errno;
> +
> +	if (fseek(fp, 0, SEEK_END) != 0) {
> +		ret = -errno;
> +		goto out;
> +	}
> +	sz = ftell(fp);
> +	if (sz < 0) {
> +		ret = -errno;
> +		goto out;
> +	}
> +	if (fseek(fp, 0, SEEK_SET) != 0) {
> +		ret = -errno;
> +		goto out;
> +	}
> +	if (sz == 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	buf = malloc((size_t)sz);
> +	if (!buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	num = fread(buf, 1, (size_t)sz, fp);
> +	if (num != (size_t)sz) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	*out = buf;
> +	*out_len = (unsigned int)sz;
> +	buf = NULL;
> +
> +out:
> +	if (fp)
> +		fclose(fp);
> +	if (ret < 0 && buf)
> +		free(buf);
> +	return ret;
> +}
> +
> +static int erofsmount_init_gzran(struct erofs_vfile **zinfo_vf,
> +				  const struct ocierofs_config *oci_cfg,
> +				  const char *zinfo_path)
> +{
> +	int err = 0;
> +	void *zinfo_data = NULL;
> +	unsigned int zinfo_len = 0;
> +	struct erofs_vfile *oci_vf = NULL;
> +
> +	oci_vf = malloc(sizeof(*oci_vf));
> +	if (!oci_vf) {
> +		err = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	err = ocierofs_io_open(oci_vf, oci_cfg);
> +	if (err) {
> +		free(oci_vf);
> +		goto cleanup;
> +	}
> +
> +	/* If no zinfo_path, return oci_vf directly for tar format */
> +	if (!zinfo_path) {
> +		*zinfo_vf = oci_vf;
> +		return 0;
> +	}
> +
> +	err = load_file_to_buf(zinfo_path, &zinfo_data, &zinfo_len);
> +	if (err) {
> +		erofs_io_close(oci_vf);
> +		free(oci_vf);
> +		return err;
> +	}
> +
> +	*zinfo_vf = erofs_gzran_zinfo_open(oci_vf, zinfo_data, zinfo_len);
> +	if (IS_ERR(*zinfo_vf)) {
> +		err = PTR_ERR(*zinfo_vf);
> +		*zinfo_vf = NULL;
> +		erofs_io_close(oci_vf);
> +		free(oci_vf);
> +		goto cleanup;
> +	}
> +
> +	free(zinfo_data);
> +	return 0;
> +
> +cleanup:
> +	if (zinfo_data)
> +		free(zinfo_data);
> +	return err;
> +}
> +
> +static ssize_t erofs_tarindex_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
> +				      off_t *pos, size_t count)
> +{
> +	static char buf[32768];
> +	ssize_t total_written = 0, ret = 0, written;
> +	size_t to_read;
> +	u64 read_offset;
> +
> +	while (count > 0) {
> +		to_read = min_t(size_t, count, sizeof(buf));
> +		read_offset = pos ? *pos : 0;
> +
> +		ret = erofs_tarindex_pread(vin, buf, to_read, read_offset);
> +		if (ret <= 0) {
> +			if (ret < 0 && total_written == 0)
> +				return ret;
> +			break;
> +		}
> +
> +		written = __erofs_io_write(vout->fd, buf, ret);
> +		if (written < 0) {
> +			ret = -errno;
> +			break;
> +		}
> +		if (written != ret)
> +			ret = written;
> +
> +		total_written += ret;
> +		count -= ret;
> +		if (pos)
> +			*pos += ret;
> +	}
> +	return count;
> +}
> +
> +static struct erofs_vfops tarindex_vfile_ops = {
> +	.pread = erofs_tarindex_pread,
> +	.sendfile = erofs_tarindex_sendfile,
> +	.close = erofs_tarindex_close,
> +};
> +
> +/*
> + * Create tarindex source for gzran+oci hybrid mode with three scenarios:
> + * 1. tarindex + zinfo: Remote data is tar.gzip format
> + * 2. tarindex only: Remote data is tar format
> + */
> +static int erofs_create_tarindex_source(struct erofs_vfile *out_vf,
> +				      const struct ocierofs_config *oci_cfg,
> +				      const char *tarindex_path,
> +				      const char *zinfo_path)
> +{
> +	struct erofsmount_tarindex_source *hs;
> +	int err;
> +	struct stat st;
> +
> +	hs = calloc(1, sizeof(*hs));
> +	if (!hs)
> +		return -ENOMEM;
> +
> +	if (tarindex_path) {
> +		hs->tarindex_vf = malloc(sizeof(*hs->tarindex_vf));
> +		if (!hs->tarindex_vf) {
> +			err = -ENOMEM;
> +			goto cleanup;
> +		}
> +
> +		hs->tarindex_vf->fd = open(tarindex_path, O_RDONLY);

Let's avoid `hs->tarindex_vf->fd`.

I suggest using a local variable vf directly.


Otherwise it looks good to me.

Thanks,
Gao Xiang

