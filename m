Return-Path: <linux-erofs+bounces-186-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC53AA83A1B
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Apr 2025 09:01:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZY9jC6vbzz3bV6;
	Thu, 10 Apr 2025 17:01:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744268511;
	cv=none; b=ICZJ9dBKw68mnNvjIxeC7JVBAmcjKmtQ5xtTN3pGkqIwDykOvANRmf/LjxC7zhAgfB9rpQkmaRGGboxxCS3QUpYCSngdGlyoDN8WiVtXKNXFDLCS6DNNwXtM8sjjfJdfa0Y/VuI90GMTaKNnph3R7eA1s+gCrXLXoBvQSnZaCuAj7syASRP+fd8rUzys5m03Z9MM6iGUJTVRzY4i5W/baU4a9uRlRo5QmC34JccKzAuLrzjzhReF5V9IhvhXN/UVQj41zXF9R77OPR7vLuyJ1Po/bfA9uT8+6tyldmi1Sgpx9YPVLfbG9MqtnzoRB3iQ5wvoawjYgLDAkloFYBLc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744268511; c=relaxed/relaxed;
	bh=2z1J7ZXhjjnNNDckIG2t+2NOpBprOfn5kG8oL0D1X+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=moLIPyXuKkHdGgjPCsMs5Y5LHW5DbZ6o+HRWoKAOCaYqXUn7evTLhwaURS+wsbS2JJkeCmUnab4NVqiMfEJw1T8oQm21UC7hBjpXmt1NokS4EbHDgkKNzGiAIz0aIbwxpxzVxJwCYr8r8C2bcPYVeX6D1vrgLlfuSQGuDEpgvtfY16qjP+bjh9J9epCkuATSHOrAatjorLhpCXyxPZNiAoAx59lgdrbAg33byblQmczbtVmzQUyoeWzfiKMBGUItM6RimVk4jsmk2usMr2VcGMzvkqNIP5ojOy4bx+oJKehD64xcaKAMJahsi5PLPpN9JqT3/6EP7nPn3/JcaR2Pgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=idyBOyB2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=idyBOyB2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZY9jB0z3Fz2ySc
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 17:01:48 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744268503; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2z1J7ZXhjjnNNDckIG2t+2NOpBprOfn5kG8oL0D1X+g=;
	b=idyBOyB2hbGMKipuJ5D2DcIlZhZSh9R4WGBFGfGUtBJdwPHYtSWL0502aid1KHZMweITxa9SiZvKuid3ZulxMWk5WWcMiTIjjXj37YExgnQx05Pucxb4MfuIt+TCw8I5TrPTnT3noVV3kZ7HYq2nmj+znPC3edBLRYJ9xQBobTA=
Received: from 30.74.129.130(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWNYdI9_1744268501 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Apr 2025 15:01:41 +0800
Message-ID: <a0ff44bd-1db0-436a-8350-1637bacb02a8@linux.alibaba.com>
Date: Thu, 10 Apr 2025 15:01:40 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix `1UL << vi->u.chunkbits` on 32-bit
 platforms
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
References: <3bc4c375-9a5b-41cc-a91c-a15fb4b073ba@app.fastmail.com>
 <20250409061731.1267689-1-hsiangkao@linux.alibaba.com>
 <0f9fea0f-22b1-4407-98e6-c8df41293b81@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0f9fea0f-22b1-4407-98e6-c8df41293b81@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Colin,

On 2025/4/10 00:51, Colin Walters wrote:
> Patch looks sane to me.

I've pushed it out into -dev branch.

> 
> On Wed, Apr 9, 2025, at 2:17 AM, Gao Xiang wrote:
> 
>> I think it should be fixed on the kernel side too, yet I rarely look
>> after 32-bit platforms due to lack of test environments.
> 
> It is relatively easy to run 32 bit containers on a 64bit host, that’s what the Debian CI environment that hit this is doing.

I know it's easy to test for erofs-utils, but it's somewhat complex
(althrough doable, need 32-bit rootfs too) to test 32-bit kernels.

> 
> I think the bigger question here is fuzzing on 32 bit right? That likely would have caught this quickly.
> 
> I don’t know…roughly though it feels to me as long as the Linux kernel supports 32 bit we are going to keep getting pulled to do so too. Especially there’s a long tail of 32 bit ARM out there as I understand it.

I will find more time working on this, but sigh..

Thanks,
Gao Xiang

> 
>>


