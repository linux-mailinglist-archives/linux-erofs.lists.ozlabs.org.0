Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80C8ACC58
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 13:52:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J8D9npNz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNNsk5RDfz3cgB
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Apr 2024 21:52:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=J8D9npNz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNNsb6D3zz30Pn
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Apr 2024 21:52:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713786750; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sU0mTOrtGv3n30RiUAYhMQ3aqcRYrKnvJek+VBQiJqE=;
	b=J8D9npNzIP6GoO/YgE51PHjxQtAm4DW3HYjfI2IV7kDo16gwB7UjME8nDDI4Y0LvIv95bd2VRcP8sGZX0e8aNZd3akB4FXXN5HWjt85y9TDQ5hObDnlg7c22722ijcJuLccoPAV5/dnpaFmWAP0w2e9hRpjDEeSM6t+BF2zOF2c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W52wujw_1713786747;
Received: from 30.221.150.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W52wujw_1713786747)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 19:52:28 +0800
Message-ID: <f8f77b76-e2a0-4e8c-900e-eed569ca7136@linux.alibaba.com>
Date: Mon, 22 Apr 2024 19:52:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 2/2] erofs: reliably distinguish block based and
 fscache mode
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-3-libaokun1@huawei.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240419123611.947084-3-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 4/19/24 8:36 PM, Baokun Li wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> it will be mistaken for fscache mode, and then attempt to free an anon_dev
> that has never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>  <TASK>
>  erofs_kill_sb+0x81/0x90
>  deactivate_locked_super+0x35/0x80
>  get_tree_bdev+0x136/0x1e0
>  vfs_get_tree+0x2c/0xf0
>  do_new_mount+0x190/0x2f0
>  [...]
> ============================================
> 
> Now when erofs_kill_sb() is called, erofs_sb_info must have been
> initialised, so use sbi->fsid to distinguish between the two modes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/erofs/super.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 21faa49bc970..30b49b2eee53 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -789,17 +789,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
>  
>  static void erofs_kill_sb(struct super_block *sb)
>  {
> -	struct erofs_sb_info *sbi;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>  
> -	if (erofs_is_fscache_mode(sb))
> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		kill_anon_super(sb);
>  	else
>  		kill_block_super(sb);
>  
> -	sbi = EROFS_SB(sb);
> -	if (!sbi)
> -		return;
> -
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
>  	erofs_fscache_unregister_fs(sb);

-- 
Thanks,
Jingbo
