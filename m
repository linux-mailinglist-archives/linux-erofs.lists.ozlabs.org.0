Return-Path: <linux-erofs+bounces-2753-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKiSCCU3uGkDagEAu9opvQ
	(envelope-from <linux-erofs+bounces-2753-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:00:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD9729DC35
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 18:00:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZLtn5Cs9z2ygl;
	Tue, 17 Mar 2026 04:00:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773680417;
	cv=none; b=FcUr6sJxch51sDBTsG/zVbl9H6OMtlSSbgDTp7eQH3ETFvkzXHKahfDqdJCCBtwZVLPMGHDoeriAM0jSTaID0cPcTe6U9yZDCMYUShtbHETKAhXKD0uDWsPNgma4kdcppkwVc7jX4gnZZUGcM59COMhlVOP3DoUoDRvfXeXl+ECoxHWU0kfkB1GwZtE4XLnZmOpgMpVBWKAvNxuBQC0H+8ftoIX7FEIWc50/pShKtlIZQ8i5ejuYrTWtn58KKN1AYnDpflDzbnw17hMcD2Z/kYuDgKVvjatiy5LI2TpTyb9PaR1I/uFv44RcmkgAD8Ohslu96PHnBcOFoPHdFf/1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773680417; c=relaxed/relaxed;
	bh=0A45twAKblJsoYFUgABexUIbN8Gh76AgW4BbNLmtxsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUxpF2GVlGewNlbpz5Br2Mj4F2vNsUCsA36/dp2VdngjGZNqlmn2vyXcbh/jrt2ec+P6mDVGPu/xDETiqvBTLvpNHtI8m6pMyDSQpy0PrxQ8EDwaV9wpV5eXDCVZU2wqfStEAdE+K/ZSfmc6jAeDV1ye+vMYXqmILr01RviP9R8N5+5GeLiFwDykrjGqkwk0FaxcsAyF/EVmGTF/9rtlayBnBfZ98AgU0mm+Xuqw9gy0VHZ2ecFDaXDXHLjFaL5F7bBN5asWRwbcktL8ZjRVnKqUF2uVyOYS5xcgZq1kwMZdxIPmottTSSRPHcqoLT+lXorUJradKX7nGu6BYe+ybw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AU7Oj/nq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=AU7Oj/nq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZLtl1fQTz2xS3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:00:13 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773680408; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0A45twAKblJsoYFUgABexUIbN8Gh76AgW4BbNLmtxsc=;
	b=AU7Oj/nqdpa12zhw+uqaqDQlcx9ZPAt/DOaO4YozUk1gl4olMou8HAu96Lw8rBnSHBx5ZMXwkn/Ni8D7oBPuZ3/m/qIvkRCrlPoK/fKz4TIVmr9d+KSPsgutxZGzhOZbANF5Qp+4B0uPY7uVRiPEEtF1hBW4AUPPGOl3eywWoJo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X.5royw_1773680406;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.5royw_1773680406 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 01:00:07 +0800
Message-ID: <19a568d7-17f2-4eac-890c-1e66a9592edc@linux.alibaba.com>
Date: Tue, 17 Mar 2026 01:00:06 +0800
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
Subject: Re: [PATCH v2] erofs-utils: lib: name worker threads erofs_compress
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org
References: <6edda81f-5d2e-49d0-9b31-181e3fdf0b18@linux.alibaba.com>
 <20260316165418.7051-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260316165418.7051-1-nithurshen.dev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2753-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 3BD9729DC35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 00:54, Nithurshen wrote:

..

>   static void *worker_thread(void *arg)
>   {
> @@ -9,6 +12,12 @@ static void *worker_thread(void *arg)
>   	struct erofs_work *work;
>   	void *tlsp = NULL;
>   
> +#if defined(__linux__)
> +	prctl(PR_SET_NAME, "erofs_compress");
> +#elif defined(__APPLE__)
> +	pthread_setname_np("erofs_compress");
> +#endif

I'm not happy with this part, please read the v1 reply.


