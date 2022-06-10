Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815825460C0
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jun 2022 11:03:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LKFP92ZqVz3byW
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Jun 2022 19:03:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LKFP303vZz304m
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Jun 2022 19:03:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFyY9Pu_1654851787;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VFyY9Pu_1654851787)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 17:03:08 +0800
Date: Fri, 10 Jun 2022 17:03:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jia Zhu <zhujia.zj@bytedance.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] cachefiles: narrow the scope of flushed requests when
 releasing fd
Message-ID: <YqMIyn7TgV1mVkiR@B-P7TQMD6M-0146.local>
References: <1a03d5de-e0cf-b23d-b12a-f46795125968@bytedance.com>
 <b62a09fc-a42c-72b5-eb42-37b52b3d529f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b62a09fc-a42c-72b5-eb42-37b52b3d529f@bytedance.com>
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
Cc: linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Jun 09, 2022 at 04:54:10PM +0800, Jia Zhu wrote:
> 
> When an anonymous fd is released, only flush the requests
> associated with it, rather than all of requests in xarray.
> 
> Fixes: 9032b6e8589f ("cachefiles: implement on-demand read")
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>

Looks good to me, thanks for catching this!

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Hi David,

Could you apply this patch to your tree? I think it'd be much better
to have cachefiles patches via your tree as long as no code coupling..

Thanks a lot!

Thanks,
Gao Xiang


> ---
>  fs/cachefiles/ondemand.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index a41ae6efc545..1fee702d5529 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -21,7 +21,8 @@ static int cachefiles_ondemand_fd_release(struct inode
> *inode,
>  	 * anon_fd.
>  	 */
>  	xas_for_each(&xas, req, ULONG_MAX) {
> -		if (req->msg.opcode == CACHEFILES_OP_READ) {
> +		if (req->msg.object_id == object_id &&
> +		    req->msg.opcode == CACHEFILES_OP_READ) {
>  			req->error = -EIO;
>  			complete(&req->done);
>  			xas_store(&xas, NULL);
> -- 
> 2.20.1
> 
