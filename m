Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D845FC17F
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Oct 2022 09:53:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MnPzK6b4Lz3bjr
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Oct 2022 18:53:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.17; helo=out199-17.us.a.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com [47.90.199.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MnPzB2WvYz2xCj
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Oct 2022 18:53:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VS-qA-q_1665561193;
Received: from 30.221.128.220(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VS-qA-q_1665561193)
          by smtp.aliyun-inc.com;
          Wed, 12 Oct 2022 15:53:14 +0800
Message-ID: <28d64f00-e408-9fc2-9506-63c1d8b08b9c@linux.alibaba.com>
Date: Wed, 12 Oct 2022 15:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 3/5] cachefiles: resend an open request if the read
 request's object is closed
Content-Language: en-US
To: Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com, xiang@kernel.org
References: <20221011131552.23833-1-zhujia.zj@bytedance.com>
 <20221011131552.23833-4-zhujia.zj@bytedance.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221011131552.23833-4-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 10/11/22 9:15 PM, Jia Zhu wrote:
> @@ -254,12 +282,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	 * request distribution fair.
>  	 */
>  	xa_lock(&cache->reqs);
> -	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
> -	if (!req && cache->req_id_next > 0) {
> -		xas_set(&xas, 0);
> -		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
> +retry:
> +	xas_for_each_marked(&xas, req, xa_max, CACHEFILES_REQ_NEW) {
> +		if (cachefiles_ondemand_skip_req(req))
> +			continue;
> +		break;
>  	}
>  	if (!req) {
> +		if (cache->req_id_next > 0 && xa_max == ULONG_MAX) {
> +			xas_set(&xas, 0);
> +			xa_max = cache->req_id_next - 1;
> +			goto retry;
> +		}

I would suggest abstracting the "xas_for_each_marked(...,
CACHEFILES_REQ_NEW)" part into a helper function to avoid the "goto retry".


> @@ -392,8 +434,16 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>  	wake_up_all(&cache->daemon_pollwq);
>  	wait_for_completion(&req->done);
>  	ret = req->error;
> +	kfree(req);
> +	return ret;
>  out:
>  	kfree(req);
> +	/* Reset the object to close state in error handling path.
> +	 * If error occurs after creating the anonymous fd,
> +	 * cachefiles_ondemand_fd_release() will set object to close.
> +	 */
> +	if (opcode == CACHEFILES_OP_OPEN)
> +		cachefiles_ondemand_set_object_close(req->object);

This may cause use-after-free since @req has been freed.



-- 
Thanks,
Jingbo
