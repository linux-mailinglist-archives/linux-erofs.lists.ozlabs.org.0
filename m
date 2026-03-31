Return-Path: <linux-erofs+bounces-3131-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFnSA582y2l1EwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3131-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:51:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39364363918
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:51:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flCL03Vc8z2ybQ;
	Tue, 31 Mar 2026 13:51:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774925464;
	cv=none; b=YeBmc+F2KpX093VSG+zsb+cY0cJX5jQDmielvW9ha9ZjJG36xcYfYfsoudlveBCj3J2sk0GdZ1NN7e+OcY+LAx9D3LZcCSaHj5fGycp5nJ/j8/Yb/UaVXNEUNreuANSD6bgp4+5DEEXvJHXuWnEKCRdtdQq+86ayQHTi2FTi60bK4NaRTyu5KT/9k752IMKEB1N0AmI1W9LhVrPF0PdVZ6AXCLJ+/kP2obAzWHVW0YGvDG/bAJqK7NWvFJP8iHMtJ3A2SIHO3LreMFqIOL6dv0ajFSuRr+4r4A8x9/TqNR9qhCHKVv3CsQ23ajVjVSeF60Y5Bfe3FmC7srTb9lsaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774925464; c=relaxed/relaxed;
	bh=wbmlGbw2cPAdSgrDqYtCFkFQm2JRMrcuo7j3eYrArFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYHY7fnZCzxld83y8/DDliYBmDYS5xTRMIGSvZLoiYjR4lcHvZ7o/5u/ekxiQOVi0EUdu4MTA4j4BeYlN0O1wM0UbQ0fvOmbQkW7gVMHgYnW9IIibNArqaUTznkZPhYPqZlwWY/44MOs6zkUJk3Ox0n2jJF/z4TuNvRo55GdgHD9jV+v7erK2Bi0rNAk8vAn4mCkn8lr5HVIs41CbD2LkvKojReP/IXr3E0TKd9q7KfMrtVOza6rxilrbQnXqqFLffGwCmM1LKN8AXFe1mwt8VPZrWE5w/zocEJq8VbKnTznezYsfzKSfLVU4DQLgud1ISeZBE1tw6jVvucAbWXCIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j/GHOzkV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j/GHOzkV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flCKy0yQhz2xSb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 13:51:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774925456; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wbmlGbw2cPAdSgrDqYtCFkFQm2JRMrcuo7j3eYrArFs=;
	b=j/GHOzkV4q/W6QWIkY+HNavwGh1Fc4QLNu0eHS8QJwMkmw4eWGWzuTHoVt9oTY47EWocXxshophYxBWnQHEUsHD+d3XGsNRVKKuq7qehmCXNV9cziIjzQhLuFc8W4NRN5Y4DPcARYhNmHs1s/32TcfDMu2G1pIizYR2V+2ym8wY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X02t.ka_1774925455;
Received: from 30.221.131.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X02t.ka_1774925455 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 10:50:55 +0800
Message-ID: <669c3c5c-aece-42a6-907a-fdee99e9f1a8@linux.alibaba.com>
Date: Tue, 31 Mar 2026 10:50:54 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix missing folio_unlock causing lock imbalance
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: "open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260331023306.18574-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260331023306.18574-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3131-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 39364363918
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zhan,

On 2026/3/31 10:33, Zhan Xusheng wrote:
> folio_trylock() in erofs_try_to_free_all_cached_folios() may
> successfully acquire the folio lock, but the subsequent check
> for erofs_folio_is_managed() can skip unlocking when the folio
> is not managed by EROFS.

Do you find some real timing?

I don't think it can really happen, because:

> 
> This leads to a lock imbalance and leaves the folio permanently
> locked, which may cause reclaim stalls or interfere with memory
> management.
> 
> Fix this by ensuring folio_unlock() is called before continuing.

If a folio links to a pcluster, folio->private will be non-NULL,
and pcl->compressed_bvecs[i] points to that folios.

And z_erofs_cache_release_folio() will be called with folio lock,
and pcl->compressed_bvecs[i] will be set NULL here.

So I don't think erofs_try_to_free_all_cached_folios() can find
!erofs_folio_is_managed(sbi, folio) in the real world.

> 
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>   fs/erofs/zdata.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index fe8121df9ef2..9d7ff22f1622 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -605,8 +605,10 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
>   			if (!folio_trylock(folio))
>   				return -EBUSY;
>   
> -			if (!erofs_folio_is_managed(sbi, folio))
> +			if (!erofs_folio_is_managed(sbi, folio)) {
> +				folio_unlock(folio);
>   				continue;
> +			}
>   			pcl->compressed_bvecs[i].page = NULL;
>   			folio_detach_private(folio);

But I admit that we should rewrite in function as:

			if (!erofs_folio_is_managed(sbi, folio)) {
				DBG_BUGON(1);
			} else {
				pcl->compressed_bvecs[i].page = NULL;
				folio_detach_private(folio);
			}
			folio_unlock(folio);

Thanks,
Gao Xiang


>   			folio_unlock(folio);


