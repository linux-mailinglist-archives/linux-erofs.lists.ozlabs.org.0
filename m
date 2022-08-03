Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B85892DB
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Aug 2022 21:43:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lyj2Y53x3z305v
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 05:43:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CQ0b8CDY;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CQ0b8CDY;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lyj2T3drLz2xGq
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Aug 2022 05:43:13 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 62BD2614A1;
	Wed,  3 Aug 2022 19:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199EC433D6;
	Wed,  3 Aug 2022 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659555789;
	bh=9RIGDD7mf/WVvgADZ5joUFihTqrpBw5Zy370TtH1a0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQ0b8CDYTeeE8rbiCadEaAjtGoQnL4unzMHorSccGlcMzek5rTLiNoeTmo+I7obr4
	 kUkyZgWYzIQZcdqeQtT8SJ2+JZeQSJZwvtOiVjVxgjzHQqqQ05pjsBBhEuKUazEkRm
	 L43nWUpSe9TgczNsuYnIvkcssW2AYl/OXWXoAm2r16hY+XIb6GYGLS4TuAq5ZKvw1m
	 vl5f+y0XVs5tgV8yLG3a0/0Z71yhap6kXARXIxVui3cRNH/q9h+qBh8kBo4a+UtOsd
	 NyWa89hNXZ6RpI35+cDKovDFuqGnmaJCBMPTaEKKo9F3GzQNovdHc5vtO69HGNmJpE
	 eZYB3Y2+VuUSA==
Date: Thu, 4 Aug 2022 03:43:04 +0800
From: Gao Xiang <xiang@kernel.org>
To: Sheng Yong <shengyong@oppo.com>
Subject: Re: [RFC PATCH 1/3] erofs-utils: fuse: set d_type for readdir
Message-ID: <YurPyAkkaHDD4Lih@debian>
Mail-Followup-To: Sheng Yong <shengyong@oppo.com>, xiang@kernel.org,
	bluce.lee@aliyun.com, linux-erofs@lists.ozlabs.org, chao@kernel.org
References: <20220803142223.3962974-1-shengyong@oppo.com>
 <20220803142223.3962974-2-shengyong@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220803142223.3962974-2-shengyong@oppo.com>
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

On Wed, Aug 03, 2022 at 10:22:21PM +0800, Sheng Yong wrote:
> Set inode mode for libfuse readdir filler so that readdir count get
> correct d_type.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

> ---
>  fuse/main.c           |  5 ++++-
>  include/erofs/inode.h |  1 +
>  lib/inode.c           | 19 +++++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/fuse/main.c b/fuse/main.c
> index 95f939e..345bcb5 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -13,6 +13,7 @@
>  #include "erofs/print.h"
>  #include "erofs/io.h"
>  #include "erofs/dir.h"
> +#include "erofs/inode.h"
> 
>  struct erofsfuse_dir_context {
>         struct erofs_dir_context ctx;
> @@ -24,11 +25,13 @@ struct erofsfuse_dir_context {
>  static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
>  {
>         struct erofsfuse_dir_context *fusectx = (void *)ctx;
> +       struct stat st = {0};
>         char dname[EROFS_NAME_LEN + 1];
> 
>         strncpy(dname, ctx->dname, ctx->de_namelen);
>         dname[ctx->de_namelen] = '\0';
> -       fusectx->filler(fusectx->buf, dname, NULL, 0);
> +       st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype) << 12;
> +       fusectx->filler(fusectx->buf, dname, &st, 0);
>         return 0;
>  }
> 
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index 79b39b0..79b8d89 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -16,6 +16,7 @@ extern "C"
>  #include "erofs/internal.h"
> 
>  unsigned char erofs_mode_to_ftype(umode_t mode);
> +unsigned char erofs_ftype_to_dtype(unsigned int filetype);
>  void erofs_inode_manager_init(void);
>  unsigned int erofs_iput(struct erofs_inode *inode);
>  erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
> diff --git a/lib/inode.c b/lib/inode.c
> index f192510..ce75014 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -43,6 +43,25 @@ unsigned char erofs_mode_to_ftype(umode_t mode)
>         return erofs_ftype_by_mode[(mode & S_IFMT) >> S_SHIFT];
>  }
> 
> +static const unsigned char erofs_dtype_by_ftype[EROFS_FT_MAX] = {
> +       [EROFS_FT_UNKNOWN]      = DT_UNKNOWN,
> +       [EROFS_FT_REG_FILE]     = DT_REG,
> +       [EROFS_FT_DIR]          = DT_DIR,
> +       [EROFS_FT_CHRDEV]       = DT_CHR,
> +       [EROFS_FT_BLKDEV]       = DT_BLK,
> +       [EROFS_FT_FIFO]         = DT_FIFO,
> +       [EROFS_FT_SOCK]         = DT_SOCK,
> +       [EROFS_FT_SYMLINK]      = DT_LNK
> +};
> +
> +unsigned char erofs_ftype_to_dtype(unsigned int filetype)
> +{
> +       if (filetype >= EROFS_FT_MAX)
> +               return DT_UNKNOWN;
> +
> +       return erofs_dtype_by_ftype[filetype];
> +}
> +
>  #define NR_INODE_HASHTABLE     16384
> 
>  struct list_head inode_hashtable[NR_INODE_HASHTABLE];
> --
> 2.25.1
> 
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人使用（包含个人及群组）。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，请立即以电子邮件通知发件人并删除本邮件及其附件。
> 
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!
