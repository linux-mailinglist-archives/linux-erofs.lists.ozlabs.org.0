Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AD68364B6
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jan 2024 14:48:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TJWlS3mFRz3bsr
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jan 2024 00:48:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TJWlP1Tg9z3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jan 2024 00:48:31 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W.9eXi4_1705931303;
Received: from 30.221.145.129(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.9eXi4_1705931303)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 21:48:24 +0800
Message-ID: <7790423f-665e-44cc-b4ae-d3f3d2996af5@linux.alibaba.com>
Date: Mon, 22 Jan 2024 21:48:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] cachefiles, erofs: Fix NULL deref in when
 cachefiles is not doing ondemand-mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
References: <20240122123845.3822570-1-dhowells@redhat.com>
 <20240122123845.3822570-7-dhowells@redhat.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240122123845.3822570-7-dhowells@redhat.com>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, Yue Hu <huyue2@coolpad.com>, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 1/22/24 8:38 PM, David Howells wrote:
> cachefiles_ondemand_init_object() as called from cachefiles_open_file() and
> cachefiles_create_tmpfile() does not check if object->ondemand is set
> before dereferencing it, leading to an oops something like:
> 
> 	RIP: 0010:cachefiles_ondemand_init_object+0x9/0x41
> 	...
> 	Call Trace:
> 	 <TASK>
> 	 cachefiles_open_file+0xc9/0x187
> 	 cachefiles_lookup_cookie+0x122/0x2be
> 	 fscache_cookie_state_machine+0xbe/0x32b
> 	 fscache_cookie_worker+0x1f/0x2d
> 	 process_one_work+0x136/0x208
> 	 process_scheduled_works+0x3a/0x41
> 	 worker_thread+0x1a2/0x1f6
> 	 kthread+0xca/0xd2
> 	 ret_from_fork+0x21/0x33
> 
> Fix this by making the calls to cachefiles_ondemand_init_object()
> conditional.
> 
> Fixes: 3c5ecfe16e76 ("cachefiles: extract ondemand info field from cachefiles_object")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: Yue Hu <huyue2@coolpad.com>
> cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> cc: linux-erofs@lists.ozlabs.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/cachefiles/namei.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 7ade836beb58..180594d24c44 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -473,9 +473,11 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
>  	if (!cachefiles_mark_inode_in_use(object, file_inode(file)))
>  		WARN_ON(1);
>  
> -	ret = cachefiles_ondemand_init_object(object);
> -	if (ret < 0)
> -		goto err_unuse;
> +	if (object->ondemand) {
> +		ret = cachefiles_ondemand_init_object(object);
> +		if (ret < 0)
> +			goto err_unuse;
> +	}

I'm not sure if object->ondemand shall be checked by the caller or
inside cachefiles_ondemand_init_object(), as
cachefiles_ondemand_clean_object() is also called without checking
object->ondemand. cachefiles_ondemand_clean_object() won't trigger the
NULL oops as the called cachefiles_ondemand_send_req() will actually
checks that.

Anyway this patch looks good to me.  Thanks.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

>  
>  	ni_size = object->cookie->object_size;
>  	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
> @@ -579,9 +581,11 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>  	}
>  	_debug("file -> %pd positive", dentry);
>  
> -	ret = cachefiles_ondemand_init_object(object);
> -	if (ret < 0)
> -		goto error_fput;
> +	if (object->ondemand) {
> +		ret = cachefiles_ondemand_init_object(object);
> +		if (ret < 0)
> +			goto error_fput;
> +	}
>  
>  	ret = cachefiles_check_auxdata(object, file);
>  	if (ret < 0)

-- 
Thanks,
Jingbo
