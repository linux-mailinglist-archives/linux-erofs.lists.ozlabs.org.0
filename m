Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 113BB1024DD
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2019 13:51:36 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HQgT0d8zzDqft
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Nov 2019 23:51:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HQgB6NlmzDqTl
 for <linux-erofs@lists.ozlabs.org>; Tue, 19 Nov 2019 23:51:16 +1100 (AEDT)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 2363D822664699911B1B;
 Tue, 19 Nov 2019 20:51:07 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 20:51:06 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 19 Nov 2019 20:51:06 +0800
Date: Tue, 19 Nov 2019 20:53:31 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH] erofs: add error handling for erofs_fill_super()
Message-ID: <20191119125328.GA86789@architecture4>
References: <20191119113744.11635-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191119113744.11635-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: miaoxie@huawei.com, xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chengguang,

On Tue, Nov 19, 2019 at 07:37:44PM +0800, Chengguang Xu wrote:
> There are some potential resource leaks in error case
> of erofs_fill_super(), so add proper error handling
> for it.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/erofs/super.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0e369494f2f2..06e721bd1c8c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -369,7 +369,7 @@ static int erofs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_fs_info = sbi;
>  	err = erofs_read_superblock(sb);
>  	if (err)
> -		return err;
> +		goto free;

Could you give some hints what is the potential leak exactly?
Actually, it was modified on purpose recently, see the following threads:
https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk
and
https://lore.kernel.org/r/20190721040547.GF17978@ZenIV.linux.org.uk

Thanks,
Gao Xiang

