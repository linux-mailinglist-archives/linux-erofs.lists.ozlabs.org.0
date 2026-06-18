Return-Path: <linux-erofs+bounces-3669-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F1G7HWWoM2olEwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3669-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 10:12:21 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7DF69E5D5
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 10:12:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=u41YZEYa;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3669-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3669-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggtkB07hsz2xM7;
	Thu, 18 Jun 2026 18:12:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781770337;
	cv=none; b=XZTvEVGoFBdebvXn/u+BzbflR4bBcfzKMUMoXgW0ZTX9k8BKdAMoxoOn8EBBqYUFaYznIduQwRHLzXQQGTFQCbokE0yA+xU0jDRFH2Rm93JBE62Wnbyxd7ZpnIdar8qUEkng3Z+3636azaQZ+pB8S5pDiqRdqTXjcwP98MzUPT4hYG01Y8dUznJG+7ib01qMKl+WVDQl3e2SxK1ll26+8ZC241i7+Y4D1BeyAteg+moSxzAb+aYBu5u3Hhb1BLDBZ3skSxIJj2ayphOPVrZKYowNlwJZG44e/RNsdNoy0bRbE6P/wUIrRQOsBvL6kFWEFSS2xXCAVdRWDZFnri9TiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781770337; c=relaxed/relaxed;
	bh=bRlkZ7keD0srCGw9lERg/DlCO+IejhvauYgwJImWaFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL1ywyqWModLP+yAn80NLpALRR2tbBXizYueuc7a37fgVAySnm0HU5UHxlYybF7+2CeM4qN8Bwt+hlOQSVmkY32ARh1mFg8a00fdzTNv+/P0AfWGzD9DPZJYC3FTVuO1Y1snzd6dQvQvXLi/q/gpZEL4gKQg5dFiVdKVI7x2V3nTruS8OSV5pP43ts5CmdynSk0nIOJ5Z+DHI7OrjENrJbB9GThO41r3EvF66j+WmyaVlAyDx5j0I+c/ItihKGGp81dQ6X5e5T/JVVqPMJyXzqPmxupuBNQrYrqS20Hir7Ct7H8qxi1byfvJqzRvpX3WCocI0LIFkSjWXc2eHFH1vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=u41YZEYa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggtk54GCPz2xC3
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 18:12:11 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781770327; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bRlkZ7keD0srCGw9lERg/DlCO+IejhvauYgwJImWaFM=;
	b=u41YZEYaRJ1mzznNl64V5yQA8Umd/nk/VyZpuaL5cZFI95/HaKu60SaD3ZQCi7dglWJAvrG6UdQoVa0x9fchMg6n/7BEPqGi4F7yH7hQenPShbk6o3M6H17B3gvh97gvVRsTCFKZa8bTHHR3Br6Iagi6908sc0yj7perWxvCdQg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X56DeDJ_1781770324;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X56DeDJ_1781770324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 16:12:04 +0800
Message-ID: <6d3abdf7-8395-40fe-8b68-95a3bcbb63d4@linux.alibaba.com>
Date: Thu, 18 Jun 2026 16:12:03 +0800
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
Subject: Re: [PATCH v2] erofs: add folio order to trace_erofs_read_folio
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <446789d7-af2c-4a0a-8017-21c6ac69077c@linux.alibaba.com>
 <20260617074334.2761632-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260617074334.2761632-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3669-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,xiaomi.com:email,ozlabs.org:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E7DF69E5D5



On 2026/6/17 15:43, Zhan Xusheng wrote:
> erofs supports large folios for reads, but the actual folio order
> instantiated in the page cache may be lower due to allocation
> constraints such as memory fragmentation.
> 
> trace_erofs_read_folio already receives the folio being read but
> currently records only its index. Add folio_order() to the tracepoint
> so that users can observe the realized folio order and verify the
> effectiveness of large folio reads.
> 
> Also drop the uptodate field: read_folio() is only called for a
> non-uptodate folio, so it is always 0.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

But pls also Cc erofs mailing list <linux-erofs@lists.ozlabs.org>
next time

Thanks,
Gao Xiang

> ---
>   include/trace/events/erofs.h | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
> index cd0e3fd8c23f..0a178cb10fb1 100644
> --- a/include/trace/events/erofs.h
> +++ b/include/trace/events/erofs.h
> @@ -90,7 +90,7 @@ TRACE_EVENT(erofs_read_folio,
>   		__field(erofs_nid_t,    nid     )
>   		__field(int,		dir	)
>   		__field(pgoff_t,	index	)
> -		__field(int,		uptodate)
> +		__field(unsigned int,	order	)
>   		__field(bool,		raw	)
>   	),
>   
> @@ -99,16 +99,15 @@ TRACE_EVENT(erofs_read_folio,
>   		__entry->nid	= EROFS_I(inode)->nid;
>   		__entry->dir	= S_ISDIR(inode->i_mode);
>   		__entry->index	= folio->index;
> -		__entry->uptodate = folio_test_uptodate(folio);
> +		__entry->order	= folio_order(folio);
>   		__entry->raw = raw;
>   	),
>   
> -	TP_printk("dev = (%d,%d), nid = %llu, %s, index = %lu, uptodate = %d "
> -		"raw = %d",
> +	TP_printk("dev = (%d,%d), nid = %llu, %s, index = %lu, order = %u, raw = %d",
>   		show_dev_nid(__entry),
>   		show_file_type(__entry->dir),
>   		(unsigned long)__entry->index,
> -		__entry->uptodate,
> +		__entry->order,
>   		__entry->raw)
>   );
>   


