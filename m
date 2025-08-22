Return-Path: <linux-erofs+bounces-882-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C9B31476
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:58:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7bH55Lwsz3cZL;
	Fri, 22 Aug 2025 19:58:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755856705;
	cv=none; b=WSQtIbbkg2HLlktKSBnmB71pbQu6JcK3J5kQZk5GlTukmKFIWy+uAgTJumlNlxjTpmCIpaNQs9IyA7zBfA3N+ZPhbuqSFHA7jeDUaueZe0jb9rjiNKPi71aD1sBPa5SqFw0lU/TkCCXkj3gYYcSStjXpRQjI8pehdIO5/oArOeGh+ngDTzbKm407iSATPxQFsgepAFV6NspwNKTKh0qRAvUoFz7onYf6vCUKWl1kptqZm6BdoA3WJFLAGM4mPpKkxc78v/GAnNIfiKxKvcNF7f83hkfdSKwXgC4XGmPtGMO0Gz8+m1DOx6Oebr5IPlCtZOTO4whHsnI3mhGm+ASrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755856705; c=relaxed/relaxed;
	bh=T5XC/k4bRKFwFeG7oyh86axw/hRobh4wDh++HNbky4s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c9dgNI3uOiARdKxMVLsokb8vY56K+R1P4+5ns9f2evOFaz2CYeHjJZa237Ez/WKa5DyYHdlwaIfCTlhBUL+k8EfElm/MrmIy4T5yzLN4cAWrSERxwDKK/yxDbPRLpTwgnSJ8TwDugplNPGdxKCH97o6lCQ07Np2x6P2xHex31o5RdYF2NN7NETeujMBWMkM2zmulp+hCyp5mAZNxzGvrAQyHPO1/4oDJmmRBslU4InL0omBR2idNJcUMG2tKT4FziPmm1SLRlJWBTJ3HwtzongeIfVT1e8DrQ8p0FNEWA60fDA8iP8Pu1qDywPNrU+Sv1NLhheQ0EYMfWXcPcIK7lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XSJpPBrW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XSJpPBrW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7bH44xbHz3cZ8
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:58:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755856699; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=T5XC/k4bRKFwFeG7oyh86axw/hRobh4wDh++HNbky4s=;
	b=XSJpPBrWZ+UBi5EA3XcC9pobCMJqy0gmFGNcJVTXCwhOEV9ZQSJPPGgEL1oiskfDZAUDC+RiUxGCeOs43SbE+JBL9Q+62BgfnVaCWT6pPDlSu+6YpxrGbRsHfupcZegFw3K/4+sQFojGW+VldqV2HreL3eSIsfPeyrzFN3549oA=
Received: from 30.221.131.67(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmJJP4e_1755856697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 17:58:18 +0800
Message-ID: <888293c9-8fe7-4d5b-b5c5-b69196a8d854@linux.alibaba.com>
Date: Fri, 22 Aug 2025 17:58:17 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <TY0PR04MB6191A41E6265D02BCF22E8FBFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <a22386fd-d5b2-426f-a6d7-83abce5cf593@linux.alibaba.com>
In-Reply-To: <a22386fd-d5b2-426f-a6d7-83abce5cf593@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/22 17:56, Gao Xiang wrote:
> 
> 
> On 2025/8/22 17:52, Friendy.Su@sony.com wrote:
>> +       if (cfg.c_chunkbits && dsunit && 1u << (cfg.c_chunkbits - g_sbi.blkszbits) < dsunit) {
>> +               erofs_warn("chunksize %u bytes is smaller than dsunit %u blocks, ignore dsunit !",
>> +                               1u << cfg.c_chunkbits, dsunit);
>> +               dsunit = 0;
>> +       }
>>
>> 'ignore dsunit' means set it to default, default dsunit is 0. Is this correct?
>> > Then sbi->bmgr->dsunit will be set to 'dsunit'.
> 
> I think it just ignores `dsunit` since the current behavior also
> ignores `dsunit` for blobchunks.
> 
> Let's not introduce extra behavior otherwise it could have three
> different behaviors among different mkfs.erofs versions.
> 
> So you could just drop `dsunit = 0` line.

So I tend to just kill `dsunit = 0` here, and change

`if (sbi->bmgr->dsunit > 1) {` into
`if (sbi->bmgr->dsunit >= 1u << (cfg.c_chunkbits - g_sbi.blkszbits)) {`

to match the previous `ignore` behavior for dsunit < chunksize.

Thanks,
Gao Xiang

