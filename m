Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52044B9ACC
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 09:22:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jznr92Rx1z3cBq
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 19:22:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.6;
 helo=out199-6.us.a.mail.aliyun.com; envelope-from=bo.liu@linux.alibaba.com;
 receiver=<UNKNOWN>)
X-Greylist: delayed 307 seconds by postgrey-1.36 at boromir;
 Thu, 17 Feb 2022 19:22:29 AEDT
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com
 [47.90.199.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jznr54R2Kz30NP
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Feb 2022 19:22:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=bo.liu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V4gvygv_1645085823; 
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0V4gvygv_1645085823) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Feb 2022 16:17:09 +0800
Date: Thu, 17 Feb 2022 16:17:03 +0800
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 03/22] cachefiles: extract generic function for daemon
 methods
Message-ID: <20220217081703.GA10016@rsjd01523.et2sqa>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209060108.43051-4-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Reply-To: bo.liu@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Feb 09, 2022 at 02:00:49PM +0800, Jeffle Xu wrote:
> ... so that the following new devnode can reuse most of the code when
> implementing its own methods.
>

Looks good.

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
liubo

> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/cachefiles/daemon.c | 70 +++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 7ac04ee2c0a0..6b8d7c5bbe5d 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -78,6 +78,34 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
>  	{ "",		NULL				}
>  };
>  
> +static struct cachefiles_cache *cachefiles_daemon_open_cache(void)
> +{
> +	struct cachefiles_cache *cache;
> +
> +	/* allocate a cache record */
> +	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
> +	if (cache) {
> +		mutex_init(&cache->daemon_mutex);
> +		init_waitqueue_head(&cache->daemon_pollwq);
> +		INIT_LIST_HEAD(&cache->volumes);
> +		INIT_LIST_HEAD(&cache->object_list);
> +		spin_lock_init(&cache->object_list_lock);
> +
> +		/* set default caching limits
> +		 * - limit at 1% free space and/or free files
> +		 * - cull below 5% free space and/or free files
> +		 * - cease culling above 7% free space and/or free files
> +		 */
> +		cache->frun_percent = 7;
> +		cache->fcull_percent = 5;
> +		cache->fstop_percent = 1;
> +		cache->brun_percent = 7;
> +		cache->bcull_percent = 5;
> +		cache->bstop_percent = 1;
> +	}
> +
> +	return cache;
> +}
>  
>  /*
>   * Prepare a cache for caching.
> @@ -96,31 +124,13 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
>  	if (xchg(&cachefiles_open, 1) == 1)
>  		return -EBUSY;
>  
> -	/* allocate a cache record */
> -	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
> +
> +	cache = cachefiles_daemon_open_cache();
>  	if (!cache) {
>  		cachefiles_open = 0;
>  		return -ENOMEM;
>  	}
>  
> -	mutex_init(&cache->daemon_mutex);
> -	init_waitqueue_head(&cache->daemon_pollwq);
> -	INIT_LIST_HEAD(&cache->volumes);
> -	INIT_LIST_HEAD(&cache->object_list);
> -	spin_lock_init(&cache->object_list_lock);
> -
> -	/* set default caching limits
> -	 * - limit at 1% free space and/or free files
> -	 * - cull below 5% free space and/or free files
> -	 * - cease culling above 7% free space and/or free files
> -	 */
> -	cache->frun_percent = 7;
> -	cache->fcull_percent = 5;
> -	cache->fstop_percent = 1;
> -	cache->brun_percent = 7;
> -	cache->bcull_percent = 5;
> -	cache->bstop_percent = 1;
> -
>  	file->private_data = cache;
>  	cache->cachefilesd = file;
>  	return 0;
> @@ -209,10 +219,11 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
>  /*
>   * Take a command from cachefilesd, parse it and act on it.
>   */
> -static ssize_t cachefiles_daemon_write(struct file *file,
> -				       const char __user *_data,
> -				       size_t datalen,
> -				       loff_t *pos)
> +static ssize_t cachefiles_daemon_do_write(struct file *file,
> +					  const char __user *_data,
> +					  size_t datalen,
> +					  loff_t *pos,
> +			const struct cachefiles_daemon_cmd *cmds)
>  {
>  	const struct cachefiles_daemon_cmd *cmd;
>  	struct cachefiles_cache *cache = file->private_data;
> @@ -261,7 +272,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
>  	}
>  
>  	/* run the appropriate command handler */
> -	for (cmd = cachefiles_daemon_cmds; cmd->name[0]; cmd++)
> +	for (cmd = cmds; cmd->name[0]; cmd++)
>  		if (strcmp(cmd->name, data) == 0)
>  			goto found_command;
>  
> @@ -284,6 +295,15 @@ static ssize_t cachefiles_daemon_write(struct file *file,
>  	goto error;
>  }
>  
> +static ssize_t cachefiles_daemon_write(struct file *file,
> +				       const char __user *_data,
> +				       size_t datalen,
> +				       loff_t *pos)
> +{
> +	return cachefiles_daemon_do_write(file, _data, datalen, pos,
> +					  cachefiles_daemon_cmds);
> +}
> +
>  /*
>   * Poll for culling state
>   * - use EPOLLOUT to indicate culling state
> -- 
> 2.27.0
