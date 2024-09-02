Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF35967F97
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 08:41:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wxzgf11VPz2yNs
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 16:41:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725259308;
	cv=none; b=G+7YZCIqh8f/kLuFnEaJm5g2fpJxRw12YcQaBMTZqcMBj5zMu3Guuha8MvhJI8ze08ZIok+JEwZ/w+/q37Md36IBUdc3jkmTR4LZyt9G+4ewqx4/cx31vkDa5CJL1jHWhmFTuHqeyTaVV7sIfqMEp7UGXxhz7ANIlEv15TAnDA8Lbi6BWekhryJN5RkbgF6UBe/41p2FknOFYNvTkbkcGE8T8yFL0KBsHePpazW8MjRwDxE61byDsPCP0ePTBPeZfiYJIfjZjcRqSwL7/JGYYHsjVXiglOiACJaIowVmfEVCa+uJPZur25shXrwZWiEcM44QPv/gwrgG6pHlK7gLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725259308; c=relaxed/relaxed;
	bh=nK8wjTtFh48LFbAfKIJeRWrXxvEA6vtnFBNOq69tL1I=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=S/DYdHivFHoDGMqnC/svHXctTfSZ97JlGbkUpumVJ8flDsODfuJleub8Ha6WF0J+FpndibHjxzM+qEDC7N8buWD+FCjw2UoL/OaVxRBlo1uVzw5NussM5XAX/ToKGrhTbY6lTSgO2meR9h3GeIL/EntOD+dXv0TnyzhhI0p4WFGpG0Fxd84ES84GxE+77Fhgw+IbiL4lURdLxol1rMSJdNHgbRKF1iBB8t+UZklHjIexeCTUasm7hdolQgcPlHu2BAHcoXZNkh7HdX890c+8VD/7b41R+n5eP+f3Pg4xfZAi0LX9LEMAAnAplBt75xooK+BpEME+spiy/EqVuNSVmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IOb+iJ1a; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IOb+iJ1a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxzgZ1CNqz2xHx
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 16:41:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725259299; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nK8wjTtFh48LFbAfKIJeRWrXxvEA6vtnFBNOq69tL1I=;
	b=IOb+iJ1aMbcxbBwxStQ6fUJIDPn8oLgzsWrQvWFPTmdMy2Xaq9naGYa2o4T7CyceMFzuQ/alXpbHzjNokJgCTJ8VIozjCwCXecspDWZb5wh1i9+el+ASXyql3B6VEUlpS2idJl6fJmhw2y410ipxwl6bIxu6z767N6WK7cJC1rU=
Received: from 30.244.151.91(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WE4Ie7-_1725259297)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 14:41:38 +0800
Message-ID: <15f357bc-2ec3-4f3a-b37e-6e13a92cd334@linux.alibaba.com>
Date: Mon, 2 Sep 2024 14:41:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs-utils: add fssum function for fsck
To: Jiawei Wang <kyr1ewang@qq.com>, linux-erofs@lists.ozlabs.org
References: <tencent_6102AC554A6662684C1830E6276FF924C309@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_6102AC554A6662684C1830E6276FF924C309@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jiawei,

On 2024/9/1 10:57, Jiawei Wang via Linux-erofs wrote:
> This patch introduces a fssum option to the erofs-utils fsck tool,
> enabling checksum calculation for erofs image files.
> 
> Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>

There is a rule that each patch should be compilable
but this patch breaks it.

I think you should add fssum
functionality(erofs_fssum_calculate) first before using it.

> ---
>   fsck/Makefile.am |  3 ++-
>   fsck/main.c      | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> index 5bdee4d..b7f0289 100644
> --- a/fsck/Makefile.am
> +++ b/fsck/Makefile.am
> @@ -4,7 +4,8 @@
>   AUTOMAKE_OPTIONS = foreign
>   bin_PROGRAMS     = fsck.erofs
>   AM_CPPFLAGS = ${libuuid_CFLAGS}
> -fsck_erofs_SOURCES = main.c
> +noinst_HEADERS = fssum.h
> +fsck_erofs_SOURCES = main.c fssum.c
>   fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>   fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
>   	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
> diff --git a/fsck/main.c b/fsck/main.c
> index 28f1e7e..abc0a06 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -13,6 +13,7 @@
>   #include "erofs/compress.h"
>   #include "erofs/decompress.h"
>   #include "erofs/dir.h"
> +#include "fssum.h"
>   #include "../lib/compressor.h"
>   
>   static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
> @@ -31,6 +32,7 @@ struct erofsfsck_cfg {
>   	bool overwrite;
>   	bool preserve_owner;
>   	bool preserve_perms;
> +	bool checksum;

	bool fssum;   may be better

>   };
>   static struct erofsfsck_cfg fsckcfg;
>   
> @@ -48,6 +50,7 @@ static struct option long_options[] = {
>   	{"no-preserve-owner", no_argument, 0, 10},
>   	{"no-preserve-perms", no_argument, 0, 11},
>   	{"offset", required_argument, 0, 12},
> +	{"fssum", no_argument, 0, 13},
>   	{0, 0, 0, 0},
>   };
>   
> @@ -98,6 +101,7 @@ static void usage(int argc, char **argv)
>   		" --extract[=X]          check if all files are well encoded, optionally\n"
>   		"                        extract to X\n"
>   		" --offset=#             skip # bytes at the beginning of IMAGE\n"
> +		" --fssum                calculate the checksum of iamge\n"
>   		"\n"
>   		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
>   		"\n"
> @@ -225,6 +229,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>   				return -EINVAL;
>   			}
>   			break;
> +		case 13:
> +			fsckcfg.checksum = true;
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -932,6 +939,23 @@ out:
>   	return ret;
>   }
>   
> +static int erofsfsck_sum_image(struct erofs_sb_info *sbi)
> +{
> +	int ret = 0;
> +	struct erofs_dir_context ctx = {
> +		.flags = 0,
> +		.pnid = 0,
> +		.dir = NULL,
> +		.de_nid = sbi->root_nid,
> +		.dname = "",
> +		.de_namelen = 0,
> +	};
> +	
> +	ret = erofs_fssum_calculate(&ctx);
> +	
> +	return ret;

Why not `return erofs_fssum_calculate(&ctx);`

Thanks,
Gao Xiang
