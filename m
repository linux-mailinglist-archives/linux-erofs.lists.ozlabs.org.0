Return-Path: <linux-erofs+bounces-3127-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIuELEwpy2n8EQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3127-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 03:54:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5E1363355
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 03:54:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flB4M5q5qz2ybQ;
	Tue, 31 Mar 2026 12:54:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774922051;
	cv=none; b=Cp3AD7D1MllUEzc1r27c5FSep1SSv5goUBRbo3TFpzfGqYD52ZnHVRvhJX73sQDX4y7zIB1FrTF8N+IFN3MbJQjHyUv3CWEyBY3MUIJws2ZdIzDhSAz9K0EqVz+wVpYn+hd3d95TyT+f1oQElRx5IoGTREtvB5IAGUVmta8PIDg7dSHm0+/VUhP3hXSR6YjvGOFMulA0dVZKrwgAyEg+x2/QjNGAejOZpq3QpOtu4OTdrANOJbql6cuu0+YTk4Vod1AYXIU6EujODKcKepLoxO071D1v8n8USjvFKNzNLOBO3JhTrTixQ48XB6iHoYUU1UFZPGcA7jkxsknc1rRD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774922051; c=relaxed/relaxed;
	bh=tgvNAGimiI6tldRAivhAsVH4S6HHvqfZc2n7ZhaAGO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJR2IiloPygk0itQ48ba56ZvetT9JXSpykkMgnscXAjXLH+dEg9aD2Ewu+NX0I/cjWMDAXIjpi8zkzhwozij4axCYxMBinfcW8oJD72hHRs+UgESofuuFNETgSOfI7yUTlqGZLqz3DOu2cKGU1hUlO93ePNjey4npj4v/+tUVCic3QtndRJuqQ5MooFniSkmhUaaqpjoh0mWjQdMIWTXzDkHLRJvDfWhiTRwSl7CFs/IZXEuSzhjHj67mBHWOMOJ0POvrzOT5P1gLIQsP3Pi05FLtwV7S44YNqDjf5FmOhZ83nxST8E9Br7kMeM2ft63pjwBqbHO7uLxivgEaFkWMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NwdhAAAu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NwdhAAAu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flB4J6FkJz2xSb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 12:54:07 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774922042; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tgvNAGimiI6tldRAivhAsVH4S6HHvqfZc2n7ZhaAGO8=;
	b=NwdhAAAuOJyQr5IaZ1dGlUukfN59DCJvba+6H+aB09sXvSN4P0ir5PdYNSLQNgaREi9ezknwDBD8Fdt/zB3/5ZSSDviAvv4AL6fsKYIuxfccWTzFejftlF5/8MFrxFqSSWbWOhIM6Z47gDQzF+pTkev/aQQruWclc00kGyH+fcw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X02d5Nk_1774922040;
Received: from 30.221.131.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X02d5Nk_1774922040 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 09:54:00 +0800
Message-ID: <fe0be135-0ab8-4359-a800-e42ffa071ed9@linux.alibaba.com>
Date: Tue, 31 Mar 2026 09:53:59 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: mount: add fanotify pre-content OCI
 backend
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, zhukeqian1@huawei.com, hudsonzhu@tencent.com
References: <20260330124402.899394-1-zhaoyifan28@huawei.com>
 <20260330124402.899394-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260330124402.899394-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3127-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:hudsonzhu@tencent.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,configure.ac:url,linux.alibaba.com:dkim,linux.alibaba.com:mid,state.pid:url]
X-Rspamd-Queue-Id: 8C5E1363355
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Yifan,

On 2026/3/30 20:44, Yifan Zhao wrote:
> From: Yifan Zhao <yifan.yfzhao@foxmail.com>

The author seems incorrect here.

> 
> Add a fanotify-backed mount mode for OCI sources that uses
> FAN_PRE_ACCESS permission events to populate a local sparse file
> on demand before the kernel consumes the requested data.
> 
> The new erofs.fanotify subtype resolves a single OCI blob,
> creates a sparse cache file, and runs a fanotify event loop
> that fetches missing ranges before allowing access to proceed.
> 
> A pid file recording the canonical mountpoint and sparse-file
> source is written for unmount to track the corresponding worker.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   configure.ac            |  28 ++
>   lib/Makefile.am         |   7 +
>   lib/backends/fanotify.c | 110 +++++++
>   lib/liberofs_fanotify.h |  49 +++
>   lib/liberofs_oci.h      |   3 +
>   lib/remotes/oci.c       |  10 +-
>   mount/main.c            | 671 +++++++++++++++++++++++++++++++++++++++-
>   7 files changed, 872 insertions(+), 6 deletions(-)
>   create mode 100644 lib/backends/fanotify.c
>   create mode 100644 lib/liberofs_fanotify.h
> 
> diff --git a/configure.ac b/configure.ac
> index 8a8e9b3..45b8190 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -194,6 +194,10 @@ AC_ARG_ENABLE(oci,
>                      [enable OCI registry based input support @<:@default=no@:>@]),
>       [enable_oci="$enableval"],[enable_oci="no"])
>   
> +AC_ARG_ENABLE(fanotify,
> +   [AS_HELP_STRING([--enable-fanotify], [enable fanotify pre-content backend @<:@default=no@:>@])],
> +   [enable_fanotify="$enableval"], [enable_fanotify="no"])
> +
>   AC_ARG_ENABLE(fuse,
>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
>      [enable_fuse="$enableval"], [enable_fuse="no"])
> @@ -651,6 +655,24 @@ AS_IF([test "x$enable_oci" = "xyes"], [
>     ])
>   ], [have_oci="no"])
>   
> +have_fanotify="no"
> +AS_IF([test "x$enable_fanotify" = "xyes"], [
> +  AS_IF([test "x$build_linux" != "xyes"], [
> +    AC_MSG_ERROR([fanotify backend requires Linux])
> +  ])
> +  AS_IF([test "x$have_oci" != "xyes"], [
> +    AC_MSG_ERROR([fanotify backend requires --enable-oci])
> +  ])
> +  AC_CHECK_HEADERS([sys/fanotify.h], [
> +    have_fanotify="yes"
> +    AC_CHECK_TYPES([struct fanotify_event_info_range], [], [], [[
> +#include <sys/fanotify.h>
> +    ]])
> +  ], [
> +    AC_MSG_ERROR([fanotify backend disabled: missing sys/fanotify.h])
> +  ])
> +])
> +
>   # Configure openssl
>   have_openssl="no"
>   AS_IF([test "x$with_openssl" != "xno"], [
> @@ -766,6 +788,7 @@ AM_CONDITIONAL([ENABLE_LIBXML2], [test "x${have_libxml2}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_S3], [test "x${have_s3}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_STATIC_FUSE], [test "x${enable_static_fuse}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_OCI], [test "x${have_oci}" = "xyes"])
> +AM_CONDITIONAL([ENABLE_FANOTIFY], [test "x${have_fanotify}" = "xyes"])
>   
>   if test "x$have_uuid" = "xyes"; then
>     AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
> @@ -842,6 +865,11 @@ if test "x$have_oci" = "xyes"; then
>     AC_DEFINE([OCIEROFS_ENABLED], 1, [Define to 1 if OCI registry is enabled])
>   fi
>   
> +if test "x$have_fanotify" = "xyes"; then
> +  AC_DEFINE([EROFS_FANOTIFY_ENABLED], 1,
> +	    [Define to 1 if fanotify backend is enabled])
> +fi
> +
>   # Dump maximum block size
>   AS_IF([test "x$erofs_cv_max_block_size" = "x"],
>         [$erofs_cv_max_block_size = 4096], [])
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 77f6fd8..5f8812f 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -36,6 +36,10 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>         $(top_srcdir)/lib/liberofs_s3.h
>   
>   noinst_HEADERS += compressor.h
> +if ENABLE_FANOTIFY
> +noinst_HEADERS += $(top_srcdir)/lib/liberofs_fanotify.h
> +endif
> +
>   liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>   		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
>   		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
> @@ -88,6 +92,9 @@ if OS_LINUX
>   liberofs_la_CFLAGS += ${libnl3_CFLAGS}
>   liberofs_la_LDFLAGS += ${libnl3_LIBS}
>   liberofs_la_SOURCES += backends/nbd.c
> +if ENABLE_FANOTIFY
> +liberofs_la_SOURCES += backends/fanotify.c
> +endif
>   endif
>   liberofs_la_SOURCES += remotes/oci.c remotes/docker_config.c
>   liberofs_la_CFLAGS += ${json_c_CFLAGS}
> diff --git a/lib/backends/fanotify.c b/lib/backends/fanotify.c
> new file mode 100644
> index 0000000..66a97a1
> --- /dev/null
> +++ b/lib/backends/fanotify.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include "erofs/print.h"
> +#include "liberofs_fanotify.h"
> +
> +int erofs_fanotify_init_precontent(void)
> +{
> +	int fan_fd;
> +
> +	fan_fd = fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_CLOEXEC | FAN_NONBLOCK,
> +			       O_RDONLY | O_LARGEFILE);
> +	if (fan_fd < 0) {
> +		erofs_err("fanotify_init failed: %s", strerror(errno));
> +		return -errno;
> +	}
> +
> +	return fan_fd;
> +}
> +
> +int erofs_fanotify_mark_file(int fan_fd, const char *path)
> +{
> +	int err;
> +
> +	err = fanotify_mark(fan_fd, FAN_MARK_ADD, FAN_PRE_ACCESS, AT_FDCWD, path);
> +	if (err < 0) {
> +		erofs_err("fanotify_mark failed for %s: %s", path, strerror(errno));
> +		return -errno;
> +	}
> +
> +	erofs_dbg("Marked %s for FAN_PRE_ACCESS monitoring", path);
> +	return 0;
> +}
> +
> +int erofs_fanotify_parse_range_event(const struct fanotify_event_metadata *meta,
> +				     struct erofs_fanotify_range *range)
> +{
> +	const struct fanotify_event_info_header *info_hdr;
> +	const struct fanotify_event_info_range *range_info;
> +	const char *ptr, *end;
> +
> +	if (meta->metadata_len > meta->event_len) {
> +		erofs_err("Invalid fanotify metadata length");
> +		return -EIO;
> +	}
> +
> +	if (meta->vers != FANOTIFY_METADATA_VERSION) {
> +		erofs_err("Unsupported fanotify metadata version %d", meta->vers);
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize range to full file (will be overridden if range info present) */
> +	range->offset = 0;
> +	range->count = 0;
> +
> +	/* Parse additional info records for range information */
> +	ptr = (const char *)meta + meta->metadata_len;
> +	end = (const char *)meta + meta->event_len;
> +
> +	while (ptr < end) {
> +		size_t info_len;
> +
> +		if (end - ptr < sizeof(*info_hdr)) {
> +			erofs_err("Incomplete fanotify event info header");
> +			return -EIO;
> +		}
> +		info_hdr = (const struct fanotify_event_info_header *)ptr;
> +		info_len = info_hdr->len;
> +		if (info_len < sizeof(*info_hdr) || ptr + info_len > end) {
> +			erofs_err("Invalid fanotify event info length");
> +			return -EIO;
> +		}
> +
> +		if (info_hdr->info_type == FAN_EVENT_INFO_TYPE_RANGE) {
> +			if (info_len < sizeof(*range_info)) {
> +				erofs_err("Incomplete fanotify range info");
> +				return -EIO;
> +			}
> +			range_info = (const struct fanotify_event_info_range *)ptr;
> +			range->offset = range_info->offset;
> +			range->count = range_info->count;
> +			break;
> +		}
> +
> +		ptr += info_hdr->len;
> +	}
> +
> +	return 0;
> +}
> +
> +int erofs_fanotify_respond(int fan_fd, int event_fd, bool allow)
> +{
> +	struct fanotify_response response = {
> +		.fd = event_fd,
> +		.response = allow ? FAN_ALLOW : FAN_DENY,
> +	};
> +	ssize_t ret;
> +
> +	ret = write(fan_fd, &response, sizeof(response));
> +	if (ret != sizeof(response)) {
> +		erofs_err("Failed to respond to fanotify event: %s",
> +			  ret < 0 ? strerror(errno) : "short write");
> +		return ret < 0 ? -errno : -EIO;
> +	}
> +
> +	return 0;
> +}
> diff --git a/lib/liberofs_fanotify.h b/lib/liberofs_fanotify.h
> new file mode 100644
> index 0000000..a22b7ee
> --- /dev/null
> +++ b/lib/liberofs_fanotify.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +#ifndef __EROFS_LIB_LIBEROFS_FANOTIFY_H
> +#define __EROFS_LIB_LIBEROFS_FANOTIFY_H
> +
> +#include "erofs/defs.h"
> +#include <sys/fanotify.h>
> +
> +/* FAN_PRE_ACCESS may not be defined in older headers */
> +#ifndef FAN_PRE_ACCESS
> +#define FAN_PRE_ACCESS 0x00100000
> +#endif

How about called EROFS_FAN_PRE_ACCESS instead, like

#ifndef FAN_PRE_ACCESS
#define EROFS_FAN_PRE_ACCESS	0x00100000
#else
#define EROFS_FAN_PRE_ACCESS	FAN_PRE_ACCESS
#endif

> +
> +#ifndef FAN_CLASS_PRE_CONTENT
> +#define FAN_CLASS_PRE_CONTENT 0x00000008
> +#endif

Same here.

> +
> +#ifndef FAN_EVENT_INFO_TYPE_RANGE
> +#define FAN_EVENT_INFO_TYPE_RANGE 6
> +#endif

Same here.

> +
> +/* Define struct fanotify_event_info_range if not in system headers */
> +#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_RANGE
> +struct fanotify_event_info_range {
> +	struct fanotify_event_info_header hdr;
> +	__u32 pad;
> +	__u64 offset;
> +	__u64 count;
> +};
> +#endif

Same here.

#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_RANGE
typedef struct erofs_fanotify_event_info_range {
	struct fanotify_event_info_header hdr;
	...
} erofs_fanotify_event_info_range_t;
#else
typedef struct fanotify_event_info_range erofs_fanotify_event_info_range_t;
#endif

and use `erofs_fanotify_event_info_range_t` instead.

> +
> +struct erofs_fanotify_range {
> +	u64 offset;
> +	u64 count;
> +};
> +
> +/* Initialize fanotify with FAN_CLASS_PRE_CONTENT */
> +int erofs_fanotify_init_precontent(void);
> +
> +/* Mark file for FAN_PRE_ACCESS monitoring */
> +int erofs_fanotify_mark_file(int fan_fd, const char *path);
> +
> +/* Parse a single fanotify event and extract range information */
> +int erofs_fanotify_parse_range_event(const struct fanotify_event_metadata *meta,
> +				     struct erofs_fanotify_range *range);
> +
> +/* Respond to fanotify permission event */
> +int erofs_fanotify_respond(int fan_fd, int event_fd, bool allow);
> +
> +#endif
> diff --git a/lib/liberofs_oci.h b/lib/liberofs_oci.h
> index 2243c82..3b3d66d 100644
> --- a/lib/liberofs_oci.h
> +++ b/lib/liberofs_oci.h
> @@ -76,6 +76,9 @@ struct ocierofs_iostream {
>    */
>   int ocierofs_build_trees(struct erofs_importer *importer,
>   			 const struct ocierofs_config *cfg);
> +int ocierofs_ctx_init(struct ocierofs_ctx *ctx,
> +		      const struct ocierofs_config *cfg);
> +void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx);
>   int ocierofs_io_open(struct erofs_vfile *vf, const struct ocierofs_config *cfg);
>   
>   char *ocierofs_encode_userpass(const char *username, const char *password);
> diff --git a/lib/remotes/oci.c b/lib/remotes/oci.c
> index 47e8b27..f96be13 100644
> --- a/lib/remotes/oci.c
> +++ b/lib/remotes/oci.c
> @@ -1144,7 +1144,7 @@ const char *ocierofs_get_platform_spec(void)
>   }
>   
>   /**
> - * ocierofs_init - Initialize OCI context
> + * ocierofs_ctx_init - Initialize OCI context
>    * @ctx: OCI context structure to initialize
>    * @config: OCI configuration
>    *
> @@ -1154,7 +1154,7 @@ const char *ocierofs_get_platform_spec(void)
>    *
>    * Return: 0 on success, negative errno on failure
>    */
> -static int ocierofs_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
> +int ocierofs_ctx_init(struct ocierofs_ctx *ctx, const struct ocierofs_config *config)
>   {
>   	int ret;
>   
> @@ -1288,7 +1288,7 @@ out:
>    * Clean up CURL handle, free all allocated string parameters, and
>    * reset the OCI context structure to a clean state.
>    */
> -static void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
> +void ocierofs_ctx_cleanup(struct ocierofs_ctx *ctx)
>   {
>   	if (!ctx)
>   		return;
> @@ -1316,7 +1316,7 @@ int ocierofs_build_trees(struct erofs_importer *importer,
>   	int ret, i, end, fd;
>   	u64 tar_offset = 0;
>   
> -	ret = ocierofs_init(&ctx, config);
> +	ret = ocierofs_ctx_init(&ctx, config);
>   	if (ret) {
>   		ocierofs_ctx_cleanup(&ctx);
>   		return ret;
> @@ -1529,7 +1529,7 @@ int ocierofs_io_open(struct erofs_vfile *vfile, const struct ocierofs_config *cf
>   	if (!ctx)
>   		return -ENOMEM;
>   
> -	err = ocierofs_init(ctx, cfg);
> +	err = ocierofs_ctx_init(ctx, cfg);
>   	if (err)
>   		goto out;
>   
> diff --git a/mount/main.c b/mount/main.c
> index 350738d..e961937 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   #define _GNU_SOURCE
> +#include <dirent.h>
>   #include <fcntl.h>
>   #include <getopt.h>
>   #include <stdio.h>
> @@ -11,6 +12,7 @@
>   #include <sys/wait.h>
>   #include <pthread.h>
>   #include <unistd.h>
> +#include <poll.h>
>   #include "erofs/config.h"
>   #include "erofs/print.h"
>   #include "erofs/err.h"
> @@ -18,6 +20,9 @@
>   #include "../lib/liberofs_nbd.h"
>   #include "../lib/liberofs_oci.h"
>   #include "../lib/liberofs_gzran.h"
> +#ifdef EROFS_FANOTIFY_ENABLED
> +#include "../lib/liberofs_fanotify.h"
> +#endif
>   
>   #ifdef HAVE_LINUX_LOOP_H
>   #include <linux/loop.h>
> @@ -40,12 +45,22 @@ struct loop_info {
>   
>   /* Device boundary probe */
>   #define EROFSMOUNT_NBD_DISK_SIZE	(INT64_MAX >> 9)
> +#define EROFSMOUNT_CACHE_DIR	"/var/cache/erofs"

`/var/cache/erofsmount` ?

> +#define EROFSMOUNT_RUNTIME_DIR	"/run/erofs"

`/run/erofsmount` ?

> +#define EROFSMOUNT_FANOTIFY_STATE_DIR	EROFSMOUNT_RUNTIME_DIR "/fanotify"
> +
> +#ifdef EROFS_FANOTIFY_ENABLED
> +#define EROFSMOUNT_FANOTIFY_HELP	", fanotify"
> +#else
> +#define EROFSMOUNT_FANOTIFY_HELP	""
> +#endif
>   
>   enum erofs_backend_drv {
>   	EROFSAUTO,
>   	EROFSLOCAL,
>   	EROFSFUSE,
>   	EROFSNBD,
> +	EROFSFANOTIFY,
>   };
>   
>   enum erofsmount_mode {
> @@ -95,7 +110,7 @@ static void usage(int argc, char **argv)
>   		" -d <0-9>              set output verbosity; 0=quiet, 9=verbose (default=%i)\n"
>   		" -o options            comma-separated list of mount options\n"
>   		" -t type[.subtype]     filesystem type (and optional subtype)\n"
> -		"                       subtypes: fuse, local, nbd\n"
> +		"                       subtypes: fuse, local, nbd" EROFSMOUNT_FANOTIFY_HELP "\n"
>   		" -u                    unmount the filesystem\n"
>   		"    --disconnect       abort an existing NBD device forcibly\n"
>   		"    --reattach         reattach to an existing NBD device\n"
> @@ -324,6 +339,13 @@ static int erofsmount_parse_options(int argc, char **argv)
>   					mountcfg.backend = EROFSLOCAL;
>   				} else if (!strcmp(dot + 1, "nbd")) {
>   					mountcfg.backend = EROFSNBD;
> +				} else if (!strcmp(dot + 1, "fanotify")) {
> +#ifdef EROFS_FANOTIFY_ENABLED
> +					mountcfg.backend = EROFSFANOTIFY;
> +#else
> +					erofs_err("fanotify backend is not enabled at build time");
> +					return -EINVAL;
> +#endif
>   				} else {
>   					erofs_err("invalid filesystem subtype `%s`", dot + 1);
>   					return -EINVAL;
> @@ -1342,6 +1364,629 @@ out_err:
>   	return -errno;
>   }
>   
> +#ifdef EROFS_FANOTIFY_ENABLED
> +struct erofsmount_fanotify_state {
> +	pid_t pid;
> +	char *mountpoint;
> +	char *source;
> +};
> +
> +static void erofsmount_free_fanotify_state(struct erofsmount_fanotify_state *state)
> +{
> +	free(state->mountpoint);
> +	free(state->source);
> +	state->mountpoint = NULL;
> +	state->source = NULL;
> +}
> +
> +static int erofsmount_write_fanotify_state(const char *state_path, pid_t pid,
> +					   const char *mountpoint,
> +					   const char *source)
> +{
> +	struct erofsmount_fanotify_state state;
> +	char *tmp_path = NULL;
> +	FILE *f = NULL;
> +	int fd = -1, err;
> +
> +	if (mkdir(EROFSMOUNT_RUNTIME_DIR, 0700) < 0 && errno != EEXIST)
> +		return -errno;
> +	if (mkdir(EROFSMOUNT_FANOTIFY_STATE_DIR, 0700) < 0 &&
> +	    errno != EEXIST)
> +		return -errno;
> +
> +	state.pid = pid;
> +	state.mountpoint = (char *)mountpoint;
> +	state.source = (char *)source;
> +
> +	if (asprintf(&tmp_path, "%s.tmpXXXXXX", state_path) < 0)
> +		return -ENOMEM;
> +
> +	fd = mkstemp(tmp_path);
> +	if (fd < 0) {
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	f = fdopen(fd, "w");
> +	if (!f) {
> +		err = -errno;
> +		goto out;
> +	}
> +	fd = -1;
> +
> +	if (fprintf(f, "%d\n%s\n%s\n", state.pid, state.mountpoint,
> +		    state.source) < 0 || fflush(f) == EOF) {
> +		err = errno ? -errno : -EIO;
> +		goto out;
> +	}
> +
> +	if (fsync(fileno(f)) < 0) {
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	if (fclose(f) < 0) {
> +		err = -errno;
> +		f = NULL;
> +		goto out;
> +	}
> +	f = NULL;
> +
> +	if (rename(tmp_path, state_path) < 0) {
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	err = 0;
> +out:
> +	if (f)
> +		fclose(f);
> +	else if (fd >= 0)
> +		close(fd);
> +	if (err && tmp_path)
> +		unlink(tmp_path);
> +	free(tmp_path);
> +	return err;
> +}
> +
> +static int erofsmount_read_fanotify_state(const char *state_path,
> +					  struct erofsmount_fanotify_state *state)
> +{
> +	FILE *f;
> +	size_t n = 0;
> +	int err = 0;
> +
> +	memset(state, 0, sizeof(*state));
> +
> +	f = fopen(state_path, "r");
> +	if (!f)
> +		return -errno;
> +
> +	if (fscanf(f, "%d", &state->pid) != 1)
> +		err = -EINVAL;
> +	else if (fgetc(f) != '\n')
> +		err = -EINVAL;
> +	else if (getline(&state->mountpoint, &n, f) < 0)
> +		err = feof(f) ? -EINVAL : -errno;
> +	else if (getline(&state->source, &n, f) < 0)
> +		err = feof(f) ? -EINVAL : -errno;
> +	fclose(f);
> +	if (err) {
> +		erofsmount_free_fanotify_state(state);
> +		return err;
> +	}
> +
> +	state->mountpoint[strcspn(state->mountpoint, "\n")] = '\0';
> +	state->source[strcspn(state->source, "\n")] = '\0';
> +	return err;
> +}
> +
> +static int erofsmount_cleanup_fanotify_worker(const char *mountpoint,
> +					      const char *source)
> +{
> +	DIR *dir;
> +	struct dirent *de;
> +	int err = 0;
> +
> +	dir = opendir(EROFSMOUNT_FANOTIFY_STATE_DIR);
> +	if (!dir) {
> +		if (errno == ENOENT)
> +			return 0;
> +		return -errno;
> +	}
> +
> +	while ((de = readdir(dir)) != NULL) {
> +		struct erofsmount_fanotify_state state;
> +		char *state_path;
> +
> +		if (strcmp(de->d_name, ".") == 0 || strcmp(de->d_name, "..") == 0)
> +			continue;
> +		if (!strstr(de->d_name, ".state"))
> +			continue;
> +		if (asprintf(&state_path, "%s/%s", EROFSMOUNT_FANOTIFY_STATE_DIR,
> +			     de->d_name) < 0) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +
> +		err = erofsmount_read_fanotify_state(state_path, &state);
> +		if (err == -ENOENT) {
> +			free(state_path);
> +			err = 0;
> +			continue;
> +		}
> +		if (err) {
> +			free(state_path);
> +			goto out;
> +		}
> +		if (strcmp(state.mountpoint, mountpoint) ||
> +		    strcmp(state.source, source)) {
> +			erofsmount_free_fanotify_state(&state);
> +			free(state_path);
> +			continue;
> +		}
> +		if (kill(state.pid, SIGTERM) < 0 && errno != ESRCH)
> +			err = -errno;
> +		else if (unlink(state_path) < 0 && errno != ENOENT)
> +			err = -errno;
> +		erofsmount_free_fanotify_state(&state);
> +		free(state_path);
> +		goto out;
> +	}
> +out:
> +	closedir(dir);
> +	if (!err)
> +		return 0;
> +	return err;
> +}
> +
> +struct erofsmount_fanotify_ctx {
> +	struct erofs_vfile vd;		/* OCI virtual device */
> +	int sparse_fd;			/* sparse file descriptor */
> +	int fan_fd;			/* fanotify fd */
> +	char *sparse_path;		/* path to sparse file */
> +	u64 image_size;			/* blob size */
> +};
> +
> +static int erofsmount_create_sparse_file(struct erofsmount_fanotify_ctx *ctx,
> +					 u64 size, const char *blob_digest)
> +{
> +	char filepath[PATH_MAX];
> +	const char *hex_digest;
> +	int fd, err;
> +
> +	/* Extract hex part from "sha256:xxxx..." */
> +	if (!blob_digest || strncmp(blob_digest, "sha256:", 7) != 0)
> +		return -EINVAL;
> +	hex_digest = blob_digest + 7;
> +
> +	/* Construct file path using blob SHA256 */
> +	snprintf(filepath, sizeof(filepath), EROFSMOUNT_CACHE_DIR "/%s",
> +		 hex_digest);
> +
> +	/* Try to open existing file or create new one */
> +	fd = open(filepath, O_RDWR | O_CREAT, 0600);
> +	if (fd < 0 && errno == ENOENT) {
> +		err = mkdir(EROFSMOUNT_CACHE_DIR, 0700);
> +		if (err)
> +			return -errno;
> +		fd = open(filepath, O_RDWR | O_CREAT, 0600);
> +	}
> +	if (fd < 0)
> +		return -errno;
> +
> +	ctx->sparse_path = strdup(filepath);
> +	if (!ctx->sparse_path) {
> +		err = -ENOMEM;
> +		goto err_path;
> +	}
> +
> +	/* Set file size (creates sparse file) */
> +	if (ftruncate(fd, size) < 0) {
> +		err = -errno;
> +		goto err_ftruncate;
> +	}
> +
> +	ctx->sparse_fd = fd;
> +	ctx->image_size = size;
> +
> +	erofs_dbg("Created local sparse file %s (size: %llu bytes)",
> +		  ctx->sparse_path, (unsigned long long)size);
> +	return 0;
> +
> +err_ftruncate:
> +	free(ctx->sparse_path);
> +	ctx->sparse_path = NULL;
> +err_path:
> +	close(fd);
> +	unlink(filepath);
> +	return err;
> +}
> +
> +static bool erofsmount_range_in_sparse(int fd, u64 offset, size_t length)
> +{
> +	off_t data_start, hole_start;
> +
> +	/* Check if data exists at offset */
> +	data_start = lseek(fd, offset, SEEK_DATA);
> +	if (data_start < 0) {
> +		if (errno == ENXIO)
> +			return false;  /* No data in file at or after offset */
> +		return false;  /* Error, assume not present */
> +	}
> +
> +	/* If data doesn't start at our offset, range is not fully present */
> +	if ((u64)data_start != offset)
> +		return false;
> +
> +	/* Check if there's a hole before the end of our range */
> +	hole_start = lseek(fd, offset, SEEK_HOLE);
> +	if (hole_start < 0)
> +		return false;
> +
> +	/* If hole starts before our range ends, data is not fully present */
> +	if ((u64)hole_start < offset + length)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int erofsmount_resolve_fanotify_blob(const struct ocierofs_config *oci_cfg,
> +					    char **digest, u64 *image_size)
> +{
> +	struct ocierofs_ctx oci_ctx = {};
> +	int err, i = -1;
> +
> +	err = ocierofs_ctx_init(&oci_ctx, oci_cfg);
> +	if (err)
> +		return err;
> +
> +	if (oci_ctx.blob_digest) {
> +		for (i = 0; i < oci_ctx.layer_count; ++i) {
> +			if (!strcmp(oci_ctx.layers[i]->digest, oci_ctx.blob_digest))
> +				break;
> +		}
> +		if (i >= oci_ctx.layer_count) {
> +			err = -ENOENT;
> +			goto out;
> +		}
> +	} else if (oci_ctx.layer_count == 1) {
> +		i = 0;
> +	} else {
> +		erofs_err("fanotify backend requires exactly one OCI blob; use oci.blob= or oci.layer=");
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	*digest = strdup(oci_ctx.layers[i]->digest);
> +	if (!*digest) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	*image_size = oci_ctx.layers[i]->size;
> +	err = 0;
> +
> +out:
> +	ocierofs_ctx_cleanup(&oci_ctx);
> +	return err;
> +}
> +
> +static int erofs_fanotify_handle_event(struct erofsmount_fanotify_ctx *ctx,
> +				       struct fanotify_event_metadata *meta,
> +				       void **fetch_buf, size_t *fetch_buf_size)
> +{
> +	struct erofs_fanotify_range range;
> +	bool allow_access = true;
> +	u64 offset;
> +	size_t length;
> +	ssize_t read_len, written;
> +	int err, resp_err;
> +
> +	err = erofs_fanotify_parse_range_event(meta, &range);
> +	if (err < 0) {
> +		erofs_err("Failed to parse fanotify event: %s",
> +			  erofs_strerror(err));
> +		allow_access = false;
> +		goto response;
> +	}
> +
> +	if (!(meta->mask & FAN_PRE_ACCESS))
> +		goto response;
> +
> +	offset = range.offset;
> +	length = range.count;
> +
> +	if (length == 0)
> +		length = min_t(u64, 1024 * 1024, ctx->image_size - offset);
> +
> +	if (offset >= ctx->image_size)
> +		goto response;
> +
> +	/* Clamp length to not exceed file size */
> +	if (offset + length > ctx->image_size)
> +		length = ctx->image_size - offset;
> +
> +	/* Check if data already exists locally in sparse file */
> +	if (erofsmount_range_in_sparse(ctx->sparse_fd, offset, length)) {
> +		erofs_dbg("Range [%llu, %llu) already local, skipping fetch",
> +			  (unsigned long long)offset,
> +			  (unsigned long long)(offset + length));
> +		goto response;
> +	}
> +
> +	if (*fetch_buf_size < length) {
> +		void *newbuf = realloc(*fetch_buf, length);
> +
> +		if (!newbuf) {
> +			erofs_err("Failed to allocate %zu bytes", length);
> +			err = -ENOMEM;
> +			allow_access = false;
> +			goto response;
> +		}
> +		*fetch_buf = newbuf;
> +		*fetch_buf_size = length;
> +	}
> +
> +	erofs_dbg("Fetching range [%llu, %llu)",
> +		  (unsigned long long)offset,
> +		  (unsigned long long)(offset + length));
> +
> +	read_len = erofs_io_pread(&ctx->vd, *fetch_buf, length, offset);
> +	if (read_len < 0) {
> +		erofs_err("Failed to fetch range [%llu, %llu): %s",
> +			  (unsigned long long)offset,
> +			  (unsigned long long)(offset + length),
> +			  erofs_strerror(read_len));
> +		err = read_len;
> +		allow_access = false;
> +		goto response;
> +	}
> +
> +	written = pwrite(ctx->sparse_fd, *fetch_buf, read_len, offset);
> +	if (written != read_len) {
> +		erofs_err("Failed to write to sparse file at offset %llu: %s",
> +			  (unsigned long long)offset,
> +			  written < 0 ? strerror(errno) : "short write");
> +		err = written < 0 ? -errno : -EIO;
> +		allow_access = false;
> +		goto response;
> +	}
> +
> +	fsync(ctx->sparse_fd);
> +	err = 0;
> +
> +response:
> +	resp_err = erofs_fanotify_respond(ctx->fan_fd, meta->fd, allow_access);
> +	if (meta->fd >= 0)
> +		close(meta->fd);
> +	return resp_err ? resp_err : err;
> +}
> +
> +static int erofsmount_fanotify_loop(struct erofsmount_fanotify_ctx *ctx)
> +{
> +	char event_buf[4096] __attribute__((aligned(8)));
> +	void *fetch_buf = NULL;
> +	size_t fetch_buf_size = 0;
> +	struct pollfd pfd;
> +	int err = 0;
> +
> +	pfd.fd = ctx->fan_fd;
> +	pfd.events = POLLIN;
> +
> +	while (1) {
> +		struct fanotify_event_metadata *meta;
> +		ssize_t len, remaining;
> +
> +		len = read(ctx->fan_fd, event_buf, sizeof(event_buf));

Can we wrap it up into `lib/backends/fanotify.c` as well?

I think mount.erofs shouldn't care the loop,
struct fanotify_event_metadata and
FAN_EVENT_NEXT for example.

Otherwise it looks good to me.

Thanks,
Gao Xiang

