Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 890D647CAE3
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 02:45:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JJbjn3LnMz2ynm
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Dec 2021 12:45:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JJbjh0Bygz2xMF
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Dec 2021 12:44:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V.Na5eG_1640137473; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V.Na5eG_1640137473) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 22 Dec 2021 09:44:34 +0800
Date: Wed, 22 Dec 2021 09:44:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v1 1/2] Add some comments about const-ness around iterate
 API
Message-ID: <YcKDAILGEoYFE7K0@B-P7TQMD6M-0146.local>
References: <20211221142829.4123631-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211221142829.4123631-1-zhangkelvin@google.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Tue, Dec 21, 2021 at 06:28:28AM -0800, Kelvin Zhang wrote:
> Change-Id: I297a56ba14a37ef5eced95330a5b09109378ca44
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>

Would you mind add "erofs-utils: lib: " to the subject prefix,
also drop the "Change-Id:" field so I could apply it.

Adding some commit message is better, even it's trivial and
simple.

Thanks,
Gao Xiang

> ---
>  include/erofs/dir.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/erofs/dir.h b/include/erofs/dir.h
> index 77656ca..59bd40d 100644
> --- a/include/erofs/dir.h
> +++ b/include/erofs/dir.h
> @@ -39,6 +39,14 @@ typedef int (*erofs_readdir_cb)(struct erofs_dir_context *);
>   * the callback context. |de_namelen| is the exact dirent name length.
>   */
>  struct erofs_dir_context {
> +	/* During execution of |erofs_iterate_dir|, the function needs
> +	 * to read the values inside |erofs_inode* dir|. So it is important
> +	 * that the callback function does not modify stuct pointed by
> +	 * |dir|. It is OK to repoint |dir| to other objects.
> +	 * Unfortunately, it's not possible to enforce this restriction
> +	 * with const keyword, as |erofs_iterate_dir| needs to modify
> +	 * struct pointed by |dir|.
> +	 */
>  	struct erofs_inode *dir;
>  	erofs_readdir_cb cb;
>  	erofs_nid_t pnid;		/* optional */
> -- 
> 2.34.1.307.g9b7440fafd-goog
