Return-Path: <linux-erofs+bounces-3245-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB94GvW112lURwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3245-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 16:21:41 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E53CBEAF
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 16:21:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs2Dc6kcQz2yfS;
	Fri, 10 Apr 2026 00:21:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775744496;
	cv=none; b=RMbs7we8z9Z7hSdW6n90thHunmX5ro/OU7RbNkB6OEbjAssOrPtHU6dY8aWPAbI/qXD3lTdULmas0QCMlRR71luwZSIR3w0nmkklT7QN0WRJiODIbWbp4SI8GEszPMK8zaj/Oc1S7K+grp01UO+PsN/5fzh5t4HPqFwiMPs16Fzgm1mauaaaSOZXcycMs9YbnCKq0iHGUIC9JbmXLitrfcd+s0KmV1E/kQ9CTSvufTy986ACLx2ISDyP+Jg5j01eDIgwFRFIfTsYvxA6qdr0qL+z1afIYn5G4nopaciwuuaYLP6H3FJfsxQMJi+R+/w2EGj8jFLr/1/YcmCQGMKdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775744496; c=relaxed/relaxed;
	bh=aTxGI8l0r04nOEb3UC/ArkCWhXNCZAZID+kdMOdexuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DORdZTeq+GOKcnYvs5EGArOyCPDmjFtPMBiyxicpZqK4NEZJn+/XFhKIR7kQWB8mhZBWqx8hEqanhihYA/WpinOFXp0YMn2wUptbXaxlR+nUnA/3xqSxqpu9p3AF7pkQfeFTeEcUZF3ealfxY4rxvq/33CgJtBDfBAUHQOBPwPgkSKfXGBRWQCQVVDC6BAHnQMj3A1jr0gPniyyC+ue6BnkBzxyhFcZEnZFwf+jbxZpl3Ffcb7beZ/Em6MOT7bvOShJhaiGI0YA+Cj6DyhYaAnRennWtkKn+4Fw2Syk6aOLfWf1/Pfxbzu0UhTdznpjTBzitBrfztVqqBu+b9Mfzbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KlsQT2qx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KlsQT2qx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs2DZ110Zz2yS9
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 00:21:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775744488; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aTxGI8l0r04nOEb3UC/ArkCWhXNCZAZID+kdMOdexuI=;
	b=KlsQT2qxCY2RoienJFh0CdEMjeZj2tv9Agx2CjDzvNag53GTZEg/Y2chZeqv0kgKZluAammNm8KjeDstf1wFuHw5II5shXN5saeSxCcqGa3v+yNUHPy0HepQTyw8gqqfMQpe9k+BiLFtVHc3ZbbZa5hNKvMvyxJHMBRtHUCq/yE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X0ibMHm_1775744485;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0ibMHm_1775744485 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 22:21:26 +0800
Message-ID: <d82bf7e2-a076-468f-89d1-754210c1e190@linux.alibaba.com>
Date: Thu, 9 Apr 2026 22:21:25 +0800
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
Subject: Re: [PATCH v2] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
To: Junrui Luo <moonafterrain@outlook.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <SYBPR01MB788118F7F3CBCD0B894B5460AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <SYBPR01MB788118F7F3CBCD0B894B5460AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
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
	FREEMAIL_TO(0.00)[outlook.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:moonafterrain@outlook.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3245-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,linux.alibaba.com,google.com,huawei.com,vivo.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,outlook.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: D66E53CBEAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/9 21:59, Junrui Luo wrote:
> Some crafted images can have illegal (!partial_decoding &&
> m_llen < m_plen) extents, and the LZ4 inplace decompression path
> can be wrongly hit, but it cannot handle (outpages < inpages)
> properly: "outpages - inpages" wraps to a large value and
> the subsequent rq->out[] access reads past the decompressed_pages
> array.
> 
> However, such crafted cases can correctly result in a corruption
> report in the normal LZ4 non-inplace path.
> 
> Let's add an additional check to fix this for backporting.
> 
> Reproducible image (base64-encoded gzipped blob):
> 
> H4sIAJGR12kCA+3SPUoDQRgG4MkmkkZk8QRbRFIIi9hbpEjrHQI5ghfwCN5BLCzTGtLbBI+g
> dilSJo1CnIm7GEXFxhT6PDDwfrs73/ywIQD/1ePD4r7Ou6ETsrq4mu7XcWfj++Pb58nJU/9i
> PNtbjhan04/9GtX4qVYc814WDqt6FaX5s+ZwXXeq52lndT6IuVvlblytLMvh4Gzwaf90nsvz
> 2DF/21+20T/ldgp5s1jXRaN4t/8izsy/OUB6e/Qa79r+JwAAAAAAAL52vQVuGQAAAP6+my1w
> ywAAAAAAAADwu14ATsEYtgBQAAA=
> 
> $ mount -t erofs -o cache_strategy=disabled foo.erofs /mnt
> $ dd if=/mnt/data of=/dev/null bs=4096 count=1
> 
> Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Thanks for catching this:
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang


