Return-Path: <linux-erofs+bounces-1516-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D642FCCB3A4
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 10:42:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dX5L26w1Jz2xqr;
	Thu, 18 Dec 2025 20:42:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766050938;
	cv=none; b=ZG21+l//Q6sTNg+Mgu0VIlOEbd0cXq3lN/ZpHIiDNrJ4NxdATvioo5JA0xnaFhRL0vYcH0a1BdVgBXD70dclrwdPR5xwUFxAeovGlHeYEIGZ4rCCAyogJ8dyKxu56t28y5LrvV7MTaANdLSANR2iSRwGKViH2vIpWIiyhfcYVaCB2Elq6yhqVUhDi7Opa8oEIXJZT2OvMxcKGD4Ci9YbQw1RfR3f42BLGE1E/HP9/K7Y1J3Qu1lHfe3pWu/UFGJorjLE3vwu827G8F0UcaysQMYRZkUGu3BGETxZIct2OfNU2wq9/YbmVyQfL5afB56xXw20zEnaQi6ogzZEG+t9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766050938; c=relaxed/relaxed;
	bh=rOrb97JL+bGL9rIUXvO1Bd9hyAtcd+vHe3k2kVuBO1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjkGTOEUivaJPugsHq2UR6Hy+OpRKmHkkPGbPUhZpgRRjtfejwPHlPN5WKJ5CGiZXcVQfe+tSuOGK5J2cmSiWJ6TVSmHsP2SBIRzoDw/UTYkikxiqSCTFjm1+fiYGklvR/R7YrtbwaCRVud2gFoisOya7UqqwK3HT3/CFWSZWc0n3ivWUdRJHmqCjZm13/tP6hD7EMusxwCjzoyftP8ow6i0ac8m4Hv7s/DT53T65TIJPH46KbVL7nGTLiyYGDqhZgfV+4CZsDGd5R+EjTj9PCansaaWQIy/Z0PgeWck1S/nrpyYZ5gHrJe8oPNTB8RM1IPKjqquRYefQqpPw98j3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pvoaittk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pvoaittk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dX5L04gxxz2xqm
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 20:42:15 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766050929; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rOrb97JL+bGL9rIUXvO1Bd9hyAtcd+vHe3k2kVuBO1A=;
	b=pvoaittkuMLS/RiGkzPwgvyBs9jJJghxgSq2Kahs2Hq3vDJw6OS9XOjn2CbeXpUsuT0tnRkTxY3D/ZhlhmrrRrvlnbjF7QNIStwWHhT6SPGo1fjwKnV7PBLHCSln1HrUYNJVBBxph83JlU9Uk2lTBP1POqAtOEyQ7uvhAwcJiCc=
Received: from 30.221.132.6(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wv82spd_1766050926 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 17:42:06 +0800
Message-ID: <d7afa0a4-6c21-4e9b-a207-f0c8d822d717@linux.alibaba.com>
Date: Thu, 18 Dec 2025 17:42:05 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: lib: oci: allow HTTP connections to
 registry
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, hudsonzhu@tencent.com, wayne.ma@huawei.com,
 jingrui@huawei.com, hudsonZhu <hudson@cyzhu.com>
References: <20251130104257.877660-1-zhaoyifan28@huawei.com>
 <20251130104257.877660-2-zhaoyifan28@huawei.com>
 <812452D6-5119-46D0-B173-C65291D16307@cyzhu.com>
 <2d654f7f-86d0-485a-814f-1edf02caa16b@huawei.com>
 <65b4743c-8720-4493-aff1-8cc73e606f53@linux.alibaba.com>
 <b1a8afa4-c297-46ca-8b0a-b96e60bf09f7@huawei.com>
 <333670e0-cebb-435b-afa2-ce0e3191a173@linux.alibaba.com>
 <74f84d5c-d81e-4a94-94ff-d3b70faa8578@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <74f84d5c-d81e-4a94-94ff-d3b70faa8578@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yifan,

On 2025/12/18 17:39, zhaoyifan (H) wrote:
> Hi Xiang,
> 
> 
> Could you please consider these two patches?
> 
> 
> The first patch includes unit tests covering the modified parts,
> 
> while for the second patch, I added some simple smoke tests [1] to prevent regressions.
> 
> 
> As we previously discussed, I suggest handling the documentation updates in a separate,
> 
> subsequent commit—since the entire `--oci=` (and also `--s3=`) argument is currently
> 
> undocumented, not just the newly added `oci.insecure` option.
> 
> 
> [1] https://github.com/erofs/erofsnightly/pull/2

Sorry, I just missed this series (intercepted by conferences
last week), let me apply now.

Thanks,
Gao Xiang

