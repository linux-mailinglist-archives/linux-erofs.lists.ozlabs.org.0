Return-Path: <linux-erofs+bounces-244-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A590A9E333
	for <lists+linux-erofs@lfdr.de>; Sun, 27 Apr 2025 15:04:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZlmyJ0WKKz2yr8;
	Sun, 27 Apr 2025 23:04:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745759096;
	cv=none; b=oLoxa6YG352xOfa2YTcDFKtPbZH+7fAUPSezCG4joOvQeeLRPeDmNDNcI0LQAkpe3F0mmC7PlJFuWtcav1x5SsXiIx4PnlwylgWNSiJU8laU76K5r5WpHgBo+GGIb8i5p6u17ySAyQwPOUBmsJR9Xp4kETue6n2abTTWOp7MahGGuPHB93PRpVAGKqWU0VBjtddd5MejvxDECs2zNwONuiGXKKEpZ3qiujLuDekFfHdRPP1ba5D/tjGWjDP0v+1loWWwNfd9DMvQT2XEt0qXz3npflHV6E/tDbMus1U8m+zRc/8Y12pxL1MiTYIlkaq4bWaCe1R1FOUhqjEP5kWtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745759096; c=relaxed/relaxed;
	bh=6b5z3CHC2jtB+vN+eZPx4fu7OyHdalqY5rg3kPJkuPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=du9h7z/ueADOW8bbZFsCSXv5waljTf1yBYgdA1Q940ii3zjpR9cLcfeKhIJe5KAp8c/22Yx1tfdgQsbn0yJWxxYC5VtsSKqc5lIpUQbpkQHao7d26hRViUzgAMFZEdNTcfJcgC1Tgd2r+d/9vYgjwXKHrCJB58JtJhA+xDlZS2KC7Errvnn1KQ33ttQFD5YvioAWLCHV+fdMxC/3rONiLJlFXczbsX+A3jjzFfICLJiaWpKW8mVuPB2ImdeZXYQavjNUaUx2SLvumlncFow06k/onwydcKq9dc/F3dhmABrXSsVumZkX7j73+cB1tzX8t8ROq1hDW/JiRRnofNGLqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UuaOax4F; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UuaOax4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZlmyG06qlz2yr0
	for <linux-erofs@lists.ozlabs.org>; Sun, 27 Apr 2025 23:04:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745759089; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6b5z3CHC2jtB+vN+eZPx4fu7OyHdalqY5rg3kPJkuPU=;
	b=UuaOax4FYX12yjAlTJXVNWKUZCvT8ulwxNiJ5dZtmeNkWp31ePUoSpdelNEUxjQ0qOHEnWcUyC1DrqnZ8GbAR2QvDdefxJ5Xp/0aGCSA/mDq1O6JgP7SsASM/v2WDOaPhDHDvtBJm9MpV1lEeNXL6+tNAEFtrOCJ2KAEBMk7Z9M=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WY9qg7A_1745759086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 27 Apr 2025 21:04:47 +0800
Message-ID: <9544bece-bd7e-44a6-a66c-bed2c38211ef@linux.alibaba.com>
Date: Sun, 27 Apr 2025 21:04:46 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fix `--blobdev=X`
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20250427021555.99648-1-hsiangkao@linux.alibaba.com>
 <334053aa-57c9-4153-af5a-f929cf1f3a0b@huawei.com>
 <cc616110-1324-4524-a690-90ebf744d932@linux.alibaba.com>
 <ecd39d65-7852-439c-af2d-f28e3f979066@huawei.com>
 <d4556599-58a0-46be-89b4-5c84e3e7c696@linux.alibaba.com>
 <7a10f3fb-1da9-49b4-9198-fa369fc64372@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7a10f3fb-1da9-49b4-9198-fa369fc64372@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/4/27 17:17, Hongbo Li wrote:
> 
> 

...

>>
> Because some formatting options cannot be used in combination (such as --blobdev --chunksize --incremental=xxx in non-tar mode). But this might be outside the scope of this patch.
> 
> Perhaps we can add the constraints or some explanation to avoid any misunderstanding later. What's about your opinion?

Okay, I understand.

Yeah, I think they should be explicitly warned out, but
they're just unimplemented due to lack of development resource...

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo

