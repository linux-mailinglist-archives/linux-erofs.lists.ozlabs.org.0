Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C445449C5
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 13:13:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJhKb37pmz3bnX
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 21:13:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJhKT6MdDz3bjX
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jun 2022 21:13:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFt5NSt_1654773185;
Received: from 30.225.24.97(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VFt5NSt_1654773185)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 19:13:06 +0800
Message-ID: <2332f3b4-6524-dad8-8c11-01a44b872e40@linux.alibaba.com>
Date: Thu, 9 Jun 2022 19:13:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] cachefiles: narrow the scope of flushed requests when
 releasing fd
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com
References: <1a03d5de-e0cf-b23d-b12a-f46795125968@bytedance.com>
 <b62a09fc-a42c-72b5-eb42-37b52b3d529f@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <b62a09fc-a42c-72b5-eb42-37b52b3d529f@bytedance.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: hsiangkao@linux.alibaba.com, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


Hi, Jia Zhu,

Thanks for fixing this.


On 6/9/22 4:54 PM, Jia Zhu wrote:
> 
> When an anonymous fd is released, only flush the requests
> associated with it, rather than all of requests in xarray.
> 
> Fixes: 9032b6e8589f ("cachefiles: implement on-demand read")
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/cachefiles/ondemand.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index a41ae6efc545..1fee702d5529 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -21,7 +21,8 @@ static int cachefiles_ondemand_fd_release(struct inode
> *inode,
>       * anon_fd.
>       */
>      xas_for_each(&xas, req, ULONG_MAX) {
> -        if (req->msg.opcode == CACHEFILES_OP_READ) {
> +        if (req->msg.object_id == object_id &&
> +            req->msg.opcode == CACHEFILES_OP_READ) {
>              req->error = -EIO;
>              complete(&req->done);
>              xas_store(&xas, NULL);

LGTM.

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jeffle
