Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1D5F847A
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Oct 2022 11:00:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MkzfY0tQ6z3blY
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Oct 2022 20:00:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MkzfP0Drkz2yQK
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Oct 2022 20:00:27 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VRcD6Ms_1665219618;
Received: from 30.221.130.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VRcD6Ms_1665219618)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 17:00:19 +0800
Message-ID: <514c06f7-017d-bca5-6a87-0dae54c0d83d@linux.alibaba.com>
Date: Sat, 8 Oct 2022 17:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 5/5] cachefiles: add restore command to recover
 inflight ondemand read requests
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com, xiang@kernel.org
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-6-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818135204.49878-6-zhujia.zj@bytedance.com>
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
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 8/18/22 9:52 PM, Jia Zhu wrote:
> Previously, in ondemand read scenario, if the anonymous fd was closed by
> user daemon, inflight and subsequent read requests would return EIO.
> As long as the device connection is not released, user daemon can hold
> and restore inflight requests by setting the request flag to
> CACHEFILES_REQ_NEW.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/cachefiles/daemon.c   |  1 +
>  fs/cachefiles/internal.h |  3 +++
>  fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index c74bd1f4ecf5..014369266cb2 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
>  	{ "tag",	cachefiles_daemon_tag		},
>  #ifdef CONFIG_CACHEFILES_ONDEMAND
>  	{ "copen",	cachefiles_ondemand_copen	},
> +	{ "restore",	cachefiles_ondemand_restore	},
>  #endif
>  	{ "",		NULL				}
>  };
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index b4af67f1cbd6..d504c61a5f03 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
>  				     char *args);
>  
> +extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
> +					char *args);
> +
>  extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
>  extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
>  
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 79ffb19380cd..5b1c447da976 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -178,6 +178,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	return ret;
>  }
>  
> +int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
> +{
> +	struct cachefiles_req *req;
> +
> +	XA_STATE(xas, &cache->reqs, 0);
> +
> +	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Search the requests which being processed before
> +	 * the user daemon crashed.
> +	 * Set the CACHEFILES_REQ_NEW flag and user daemon will reprocess it.
> +	 */

The comment can be improved as:

	Reset the requests to CACHEFILES_REQ_NEW state, so that the
        requests have been processed halfway before the crash of the
        user daemon could be reprocessed after the recovery.


> +	xas_lock(&xas);
> +	xas_for_each(&xas, req, ULONG_MAX)
> +		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> +	xas_unlock(&xas);
> +
> +	wake_up_all(&cache->daemon_pollwq);
> +	return 0;
> +}
> +
>  static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  {
>  	struct cachefiles_object *object;

-- 
Thanks,
Jingbo
