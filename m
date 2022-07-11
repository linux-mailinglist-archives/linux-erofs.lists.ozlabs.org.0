Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8624056D392
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 05:53:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lh92h2qMSz3bsr
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Jul 2022 13:53:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lh92c0H4vz2xgX
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Jul 2022 13:52:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VIuVmSR_1657511566;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VIuVmSR_1657511566)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 11:52:48 +0800
Date: Mon, 11 Jul 2022 11:52:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Li He <lihe@uniontech.com>
Subject: Re: [PATCH] erofs-utils: fuse: support offset when read image
Message-ID: <YsuejqlGUUp3cC4S@B-P7TQMD6M-0146.local>
References: <20220711024717.5554-1-lihe@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711024717.5554-1-lihe@uniontech.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi He,

On Mon, Jul 11, 2022 at 10:47:17AM +0800, Li He wrote:
> Add --offset to erofsfuse to skip bytes at the start of the image file.
> 
> Signed-off-by: Li He <lihe@uniontech.com>

Thanks for the patch! The patch roughly looks good to me,
some nit as below..

> ---
>  fuse/main.c            | 6 ++++++
>  include/erofs/config.h | 3 +++
>  lib/io.c               | 2 ++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/fuse/main.c b/fuse/main.c
> index f4c2476..a2a6449 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -151,6 +151,7 @@ static struct fuse_operations erofs_ops = {
>  static struct options {
>  	const char *disk;
>  	const char *mountpoint;
> +	u64 offset;

We can use cfg.c_offset directly instead it seems?

>  	unsigned int debug_lvl;
>  	bool show_help;
>  	bool odebug;
> @@ -158,6 +159,7 @@ static struct options {
>  
>  #define OPTION(t, p) { t, offsetof(struct options, p), 1 }
>  static const struct fuse_opt option_spec[] = {
> +	OPTION("--offset=%lu", offset),
>  	OPTION("--dbglevel=%u", debug_lvl),
>  	OPTION("--help", show_help),
>  	FUSE_OPT_KEY("--device=", 1),
> @@ -170,6 +172,7 @@ static void usage(void)
>  
>  	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
>  	      "Options:\n"
> +	      "    --offset=#             # bytes to skip when read IMAGE\n"

need to update manpage as well...

Thanks,
Gao Xiang

>  	      "    --dbglevel=#           set output message level to # (maximum 9)\n"
>  	      "    --device=#             specify an extra device to be used together\n"
>  #if FUSE_MAJOR_VERSION < 3
> @@ -190,6 +193,7 @@ static void usage(void)
>  static void erofsfuse_dumpcfg(void)
>  {
>  	erofs_dump("disk: %s\n", fusecfg.disk);
> +	erofs_dump("offset: %lu\n", fusecfg.offset);
>  	erofs_dump("mountpoint: %s\n", fusecfg.mountpoint);
>  	erofs_dump("dbglevel: %u\n", cfg.c_dbg_lvl);
>  }
> @@ -279,6 +283,8 @@ int main(int argc, char *argv[])
>  	if (fusecfg.odebug && cfg.c_dbg_lvl < EROFS_DBG)
>  		cfg.c_dbg_lvl = EROFS_DBG;
>  
> +	cfg.c_offset = fusecfg.offset;
> +
>  	erofsfuse_dumpcfg();
>  	ret = dev_open_ro(fusecfg.disk);
>  	if (ret) {
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 0d0916c..8b6f7db 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -73,6 +73,9 @@ struct erofs_configure {
>  	char *fs_config_file;
>  	char *block_list_file;
>  #endif
> +
> +	/* offset when read mutli partiton image */
> +	u64 c_offset;
>  };
>  
>  extern struct erofs_configure cfg;
> diff --git a/lib/io.c b/lib/io.c
> index 9c663c5..524cfb4 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -261,6 +261,8 @@ int dev_read(int device_id, void *buf, u64 offset, size_t len)
>  	if (cfg.c_dry_run)
>  		return 0;
>  
> +	offset += cfg.c_offset;
> +
>  	if (!buf) {
>  		erofs_err("buf is NULL");
>  		return -EINVAL;
> -- 
> 2.20.1
> 
> 
