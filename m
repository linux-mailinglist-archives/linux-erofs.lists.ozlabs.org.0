Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 98467414117
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 07:10:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDmZb4pbJz2yPl
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Sep 2021 15:10:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=139.com
 (client-ip=120.232.169.112; helo=n169-112.mail.139.com;
 envelope-from=cgxu519@139.com; receiver=<UNKNOWN>)
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDmZT4mH7z2yPl
 for <linux-erofs@lists.ozlabs.org>; Wed, 22 Sep 2021 15:10:04 +1000 (AEST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM: 
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.255.10] (unknown[113.108.77.67])
 by rmsmtp-lg-appmail-25-12028 (RichMail) with SMTP id 2efc614aba962a2-69a39;
 Wed, 22 Sep 2021 13:09:44 +0800 (CST)
X-RM-TRANSID: 2efc614aba962a2-69a39
Message-ID: <4ccc5c89-eb13-5e91-9283-c94f755a9c17@139.com>
Date: Wed, 22 Sep 2021 13:09:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] ovl: fix null pointer when filesystem doesn't support
 direct IO
To: Huang Jianan <huangjianan@oppo.com>, linux-unionfs@vger.kernel.org,
 miklos@szeredi.hu, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
 chao@kernel.org
References: <20210918121346.12084-1-huangjianan@oppo.com>
 <20210922034700.15666-1-huangjianan@oppo.com>
From: Chengguang Xu <cgxu519@139.com>
In-Reply-To: <20210922034700.15666-1-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, cgxu519@mykernel.net,
 yh@oppo.com, guanyuwei@oppo.com, linux-fsdevel@vger.kernel.org,
 guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/9/22 11:47, Huang Jianan 写道:
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
> example, erofs supports direct_IO for uncompressed files. So reset
> f_mapping->a_ops to NULL when the file doesn't support direct_IO to
> fix this problem.
>
> Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from overlayfs over xfs")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
> Change since v1:
>   - Return error to user rather than fall back to buffered io. (Chengguang Xu)
>
>   fs/overlayfs/file.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index d081faa55e83..38118d3b46f8 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct file *file)
>   	if (IS_ERR(realfile))
>   		return PTR_ERR(realfile);
>   
> +	if ((f->f_flags & O_DIRECT) && (!realfile->f_mapping->a_ops ||
> +		!realfile->f_mapping->a_ops->direct_IO))
> +		file->f_mapping->a_ops = NULL;


There are many other functions in a_ops and also address_space struct 
will be shared

between files which belong to same inode. Although overlayfs currently 
only defines

->direct_IO in a_ops, it will be extended in the future. (like 
containerized sycnfs [1])


It seems the simplest solution is directly return error to upper layer.


Thanks,

Chengguang


[1] https://www.spinics.net/lists/linux-unionfs/msg08569.html



> +
>   	file->private_data = realfile;
>   
>   	return 0;

