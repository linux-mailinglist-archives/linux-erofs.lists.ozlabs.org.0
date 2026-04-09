Return-Path: <linux-erofs+bounces-3241-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HSJA0qY12lNQAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3241-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 14:15:06 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2353CA3F5
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 14:15:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frzQY0phJz2ygf;
	Thu, 09 Apr 2026 22:15:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775736901;
	cv=none; b=KkhRNOYUbJc/Cvv1Zf+U6S7V41zHpu/xep6jPy+UgUK6qxhjhSx66quYewyQX6ZEn2ZpIjNjvDPXuSt6Ounn9zObjQWMtKEV0hYpdHwFkmu9QGhc6sh9geHH1EtqZc2Hr/ULR/14Ksvc7kTCpZ4wiRy/0E6ga2MMExGwflXK1luzyK+FjCP6+y90JRYwR7bTEHcaprkVoJS9zA2PVwmM0pofZjocP5X07JeqPUgyxG5RTfBI9AR+3wWiP9m7+1Fmq+xGgOY6TKUdK9rSp8sg6P7rC8UJWNIFeva74HQ5hdPRcuxSf7JWK21QYAtntva39moUAihJ0AxCfGnJIWTNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775736901; c=relaxed/relaxed;
	bh=QsBZlsOs/aPVR09Nx2+/RG2UPFE2Ga7fdOknV0byQxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jga3hYmKw0RUX9UgTpV3ozwYJJo465c/MV8xJScC+sDQHMJtD6ySYZmcRwOl3Alm7APtYX0IZ5c68mzSjt8RueU/W5rbivwKsXbHhpPB7K7hbRxoIY3LodS3lvKhQBn3wnBAdM1UlEHpfMRMmRYAQBNDTLrNp8ohFZhHV60XAUaEwU3wDOva7Sps2CfSQ4DObM4IQbn70za6Tu+zu0gNIgfsgHgHYNz1WPZmJN19GGA38XLjkSLoHhCIlfTRrdaUuADoguoVDjdGttGys2SjpyXUDsYQT1RS9nGuSEsGIDJRXhUsTDBxkcvEOnQm70SeHtKCE7SN/cHQjR/eV6XLKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eP1+KH5j; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eP1+KH5j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frzQW0j5Kz2xpn
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 22:14:57 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775736891; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QsBZlsOs/aPVR09Nx2+/RG2UPFE2Ga7fdOknV0byQxw=;
	b=eP1+KH5jV31zS+eSbnzS4RcnTGeqTp2oqQvq1pf5h0KSLwBPhtZ+yS17tLnrMTbMmK6pemwo9ivibSNQKS5Nya57GhcJC2v6i9Ug0AiOh1va1qE7SkpIi7e6LRY17wCWmJ9e+iIOvN3aKWzOjSWu6Wy6NsO38PC6dCy3pUD7R6A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0iI0If_1775736888;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0iI0If_1775736888 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 20:14:50 +0800
Message-ID: <17f2ec58-e8ec-4f59-9e8f-0e88bde7d98b@linux.alibaba.com>
Date: Thu, 9 Apr 2026 20:14:46 +0800
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
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
 <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
 <f608d440-6d26-4dd9-b838-b5ad1e70541c@linux.alibaba.com>
 <1922A494-0E56-4E11-9D3E-3604BCBE33AD@outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1922A494-0E56-4E11-9D3E-3604BCBE33AD@outlook.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3241-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: BC2353CA3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 19:49, Junrui Luo wrote:
> On Thu, Apr 09, 2026 at 06:56:42PM +0800, Gao Xiang wrote:
>> Can you share your initial crafted image binary
>> with `gzip -9 | base64` encoding here?
> 
> $ gzip -9 < /tmp/erofs-test/test.erofs | base64
> H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+gdilS
> Jo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9iPNtbjhan
> 04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz2DF/21+20T/l
> dgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1wywAAAAAAAADwu14A
> TsEYtgBQAAA=
> 
> In QEMU:
> $ mount -t erofs -o cache_strategy=disabled test.erofs /mnt
> $ dd if=/mnt/data of=/dev/null bs=4096 count=1
> 
>> I think the proper place to fix this is in
>> z_erofs_map_sanity_check().
>   
> I will resend with the check in
> z_erofs_map_sanity_check() instead if the reproducer is acceptable.

It's not a very trivial fix without having some more
understanding of EROFS compression codebase, I will
add your `Repored-by:` and try to tidy up the related
code.

Thanks,
Gao Xiang

> 
> Thanks,
> Junrui Luo


