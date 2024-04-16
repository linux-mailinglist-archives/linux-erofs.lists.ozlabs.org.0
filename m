Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 996DF8A6DA4
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Apr 2024 16:14:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJmJd33m9z3dXB
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Apr 2024 00:14:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VJmJW0pPtz3cWR
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Apr 2024 00:14:48 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 7DC1F1008C2C0;
	Tue, 16 Apr 2024 22:14:44 +0800 (CST)
Received: from [192.168.25.134] (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 2466437C91F;
	Tue, 16 Apr 2024 22:14:42 +0800 (CST)
Message-ID: <e724ee03-7da8-4135-8c8d-2f41dfd46e4e@sjtu.edu.cn>
Date: Tue, 16 Apr 2024 22:14:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] erofs-utils: mkfs: enable inter-file multi-threaded
 compression
To: Gao Xiang <xiang@kernel.org>
References: <20240416080419.32491-1-xiang@kernel.org>
 <20240416080419.32491-8-xiang@kernel.org>
Content-Language: en-US
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240416080419.32491-8-xiang@kernel.org>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 4/16/24 4:04 PM, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>
> Dispatch deferred ops in another per-sb worker thread.  Note that
> deferred ops are strictly FIFOed.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   include/erofs/internal.h |   6 ++
>   lib/inode.c              | 121 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 124 insertions(+), 3 deletions(-)
>
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index f31e548..ecbbdf6 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -71,6 +71,7 @@ struct erofs_xattr_prefix_item {
>   
>   #define EROFS_PACKED_NID_UNALLOCATED	-1
>   
> +struct erofs_mkfs_dfops;
>   struct erofs_sb_info {
>   	struct erofs_device_info *devs;
>   	char *devname;
> @@ -124,6 +125,11 @@ struct erofs_sb_info {
>   	struct list_head list;
>   
>   	u64 saved_by_deduplication;
> +
> +#ifdef EROFS_MT_ENABLED
> +	pthread_t dfops_worker;
> +	struct erofs_mkfs_dfops *mkfs_dfops;
> +#endif
>   };
>   
>   /* make sure that any user of the erofs headers has atleast 64bit off_t type */
> diff --git a/lib/inode.c b/lib/inode.c
> index 681460c..3c952b2 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1165,6 +1165,7 @@ enum erofs_mkfs_jobtype {	/* ordered job types */
>   	EROFS_MKFS_JOB_NDIR,
>   	EROFS_MKFS_JOB_DIR,
>   	EROFS_MKFS_JOB_DIR_BH,
> +	EROFS_MKFS_JOB_MAX
>   };
>   
>   struct erofs_mkfs_jobitem {
> @@ -1203,6 +1204,74 @@ static int erofs_mkfs_jobfn(struct erofs_mkfs_jobitem *item)
>   	return -EINVAL;
>   }
>   
> +#ifdef EROFS_MT_ENABLED
> +
> +struct erofs_mkfs_dfops {
> +	pthread_t worker;
> +	pthread_mutex_t lock;
> +	pthread_cond_t full, empty;
> +	struct erofs_mkfs_jobitem *queue;
> +	size_t size, elem_size;
> +	size_t head, tail;
> +};
> +
> +#define EROFS_MT_QUEUE_SIZE 256
> +
> +void *erofs_mkfs_pop_jobitem(struct erofs_mkfs_dfops *q)
> +{
> +	struct erofs_mkfs_jobitem *item;
> +
> +	pthread_mutex_lock(&q->lock);
> +	while (q->head == q->tail)
> +		pthread_cond_wait(&q->empty, &q->lock);
> +
> +	item = q->queue + q->head;
> +	q->head = (q->head + 1) % q->size;
> +
> +	pthread_cond_signal(&q->full);
> +	pthread_mutex_unlock(&q->lock);
> +	return item;
> +}
> +
> +void *z_erofs_mt_dfops_worker(void *arg)
> +{
> +	struct erofs_sb_info *sbi = arg;
> +	int ret = 0;
> +
> +	while (1) {
> +		struct erofs_mkfs_jobitem *item;
> +
> +		item = erofs_mkfs_pop_jobitem(sbi->mkfs_dfops);
> +		if (item->type >= EROFS_MKFS_JOB_MAX)
> +			break;
> +		ret = erofs_mkfs_jobfn(item);
> +		if (ret)
> +			break;
> +	}
> +	pthread_exit((void *)(uintptr_t)ret);
> +}
> +
> +int erofs_mkfs_go(struct erofs_sb_info *sbi,
> +		  enum erofs_mkfs_jobtype type, void *elem, int size)
> +{
> +	struct erofs_mkfs_jobitem *item;
> +	struct erofs_mkfs_dfops *q = sbi->mkfs_dfops;
> +
> +	pthread_mutex_lock(&q->lock);
> +
> +	while ((q->tail + 1) % q->size == q->head)
> +		pthread_cond_wait(&q->full, &q->lock);
> +
> +	item = q->queue + q->tail;
> +	item->type = type;
> +	memcpy(&item->u, elem, size);
> +	q->tail = (q->tail + 1) % q->size;
> +
> +	pthread_cond_signal(&q->empty);
> +	pthread_mutex_unlock(&q->lock);
> +	return 0;
> +}
> +#else
>   int erofs_mkfs_go(struct erofs_sb_info *sbi,
>   		  enum erofs_mkfs_jobtype type, void *elem, int size)
>   {
> @@ -1212,6 +1281,7 @@ int erofs_mkfs_go(struct erofs_sb_info *sbi,
>   	memcpy(&item.u, elem, size);
>   	return erofs_mkfs_jobfn(&item);
>   }
> +#endif
>   
>   static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
>   {
> @@ -1344,7 +1414,11 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
>   	return ret;
>   }
>   
> -struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> +#ifndef EROFS_MT_ENABLED
> +#define __erofs_mkfs_build_tree_from_path erofs_mkfs_build_tree_from_path
> +#endif
> +
> +struct erofs_inode *__erofs_mkfs_build_tree_from_path(const char *path)
>   {
>   	struct erofs_inode *root, *dumpdir;
>   	int err;
> @@ -1361,7 +1435,6 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
>   	err = erofs_mkfs_handle_inode(root);
>   	if (err)
>   		return ERR_PTR(err);
> -	erofs_fixup_meta_blkaddr(root);
>   
>   	do {
>   		int err;
> @@ -1400,10 +1473,52 @@ struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
>   		if (err)
>   			return ERR_PTR(err);
>   	} while (dumpdir);
> -
>   	return root;
>   }
>   
> +#ifdef EROFS_MT_ENABLED
> +struct erofs_inode *erofs_mkfs_build_tree_from_path(const char *path)
> +{
> +	struct erofs_mkfs_dfops *q;
> +	struct erofs_inode *root;
> +	int err;
> +
> +	q = malloc(sizeof(*q));
> +	if (!q)
> +		return ERR_PTR(-ENOMEM);
> +
> +	q->queue = malloc(q->size * sizeof(*q->queue));

q->size is not initialized here. Should move `q->size = 
EROFS_MT_QUEUE_SIZE;` before it.


Thanks,

Yifan Zhao

> +	if (!q->queue) {
> +		free(q);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	pthread_mutex_init(&q->lock, NULL);
> +	pthread_cond_init(&q->empty, NULL);
> +	pthread_cond_init(&q->full, NULL);
> +
> +	q->size = EROFS_MT_QUEUE_SIZE;
> +	q->head = 0;
> +	q->tail = 0;
> +	sbi.mkfs_dfops = q;
> +	err = pthread_create(&sbi.dfops_worker, NULL,
> +			     z_erofs_mt_dfops_worker, &sbi);
> +	if (err)
> +		goto fail;
> +	root = __erofs_mkfs_build_tree_from_path(path);
> +
> +	erofs_mkfs_go(&sbi, ~0, NULL, 0);
> +	err = pthread_join(sbi.dfops_worker, NULL);
> +
> +fail:
> +	pthread_cond_destroy(&q->empty);
> +	pthread_cond_destroy(&q->full);
> +	pthread_mutex_destroy(&q->lock);
> +	free(q->queue);
> +	free(q);
> +	return err ? ERR_PTR(err) : root;
> +}
> +#endif
> +
>   struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
>   {
>   	struct stat st;
