Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB12413F2F
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 04:00:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDhMt3vfvz2yHH
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 12:00:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=139.com
 (client-ip=120.232.169.112; helo=n169-112.mail.139.com;
 envelope-from=cgxu519@139.com; receiver=<UNKNOWN>)
X-Greylist: delayed 197 seconds by postgrey-1.36 at boromir;
 Wed, 22 Sep 2021 12:00:39 AEST
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDhMq2pRpz2xtP
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Sep 2021 12:00:39 +1000 (AEST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.255.10] (unknown[113.108.77.67])
 by rmsmtp-lg-appmail-25-12028 (RichMail) with SMTP id 2efc614a8d6bb63-64fb6;
 Wed, 22 Sep 2021 09:56:59 +0800 (CST)
X-RM-TRANSID: 2efc614a8d6bb63-64fb6
Message-ID: <3633c6e5-028c-fc77-3b8e-da9903f97ac5@139.com>
Date: Wed, 22 Sep 2021 09:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] ovl: fix null pointer when filesystem doesn't support
 direct IO
To: Huang Jianan <huangjianan@oppo.com>, linux-unionfs@vger.kernel.org,
 miklos@szeredi.hu, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
 chao@kernel.org
References: <20210918121346.12084-1-huangjianan@oppo.com>
From: Chengguang Xu <cgxu519@139.com>
In-Reply-To: <20210918121346.12084-1-huangjianan@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/9/18 20:13, Huang Jianan 写道:
> From: Huang Jianan <huangjianan@oppo.com>
>
> At present, overlayfs provides overlayfs inode to users. Overlayfs
> inode provides ovl_aops with noop_direct_IO to avoid open failure
> with O_DIRECT. But some compressed filesystems, such as erofs and
> squashfs, don't support direct_IO.
>
> Users who use f_mapping->a_ops->direct_IO to check O_DIRECT support,
> will read file through this way. This will cause overlayfs to access
> a non-existent direct_IO function and cause panic due to null pointer:
>
> Kernel panic - not syncing: CFI failure (target: 0x0)
> CPU: 6 PID: 247 Comm: loop0
> Call Trace:
>   panic+0x188/0x45c
>   __cfi_slowpath+0x0/0x254
>   __cfi_slowpath+0x200/0x254
>   generic_file_read_iter+0x14c/0x150
>   vfs_iocb_iter_read+0xac/0x164
>   ovl_read_iter+0x13c/0x2fc
>   lo_rw_aio+0x2bc/0x458
>   loop_queue_work+0x4a4/0xbc0
>   kthread_worker_fn+0xf8/0x1d0
>   loop_kthread_worker_fn+0x24/0x38
>   kthread+0x29c/0x310
>   ret_from_fork+0x10/0x30
>
> The filesystem may only support direct_IO for some file types. For
> example, erofs supports direct_IO for uncompressed files. So fall
> back to buffered io only when the file doesn't support direct_IO to
> fix this problem.


IMO, return error to user seems better option than fall back to

buffered io directly.


Thanks,

Chengguang


>
> Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from overlayfs over xfs")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>   fs/overlayfs/file.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index d081faa55e83..998c60770b81 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -296,6 +296,10 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>   	if (ret)
>   		return ret;
>   
> +	if ((iocb->ki_flags & IOCB_DIRECT) && (!real.file->f_mapping->a_ops ||
> +		!real.file->f_mapping->a_ops->direct_IO))
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +
>   	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>   	if (is_sync_kiocb(iocb)) {
>   		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,

