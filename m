Return-Path: <linux-erofs+bounces-597-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933ABB028FC
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Jul 2025 04:29:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bfCGT1T92z30MY;
	Sat, 12 Jul 2025 12:29:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752287393;
	cv=none; b=ZFZcFEb90fqHyEcWAgpeEqinxEAShLGEHPqw6dGhh8z5ytxIf08WVq1RAFak9Yl5s5s2yq52JAW0LMTc/ZjPIPB4WmOfRPwJ34UjvRqWnCpfREi36vJ0jEVv6dexDfoJf7v/ZEL+g9DmLLfPFSv/FQQ7rPSqWILFpXq8qN5Bnk5U3SsXe1+w55GFXukS3lJ89THmaXKyjF74eK+0Dn6ygA75/zaxY7ZUtGOjEJz02TfalOm0RV25H78HD4SQV22NRrK/zsElaHQN9Jqz6EXTufJIH2c4gSMicj94KS55xnvcyFR4dQ7aldKewVDvyImwB3WcWWUm8Iam3dCHn4syLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752287393; c=relaxed/relaxed;
	bh=weKi5IJezNOCR2rUOHKGMnqeS6jg6SXJUv73Dpua+Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JALMzceCtdnv6t74WK4JpPb9AGAND79q5i5FN1+x9wY4g4siB42T51y9ugRitXUMWzJHKtVcTaoGQznlrjHpWPSpm8OabUqvEVKuXVbdpLWJ+mab2fEXIkhzeBTbORbTPhjeOLTXGF82aIMMUA235V1XA2wHs+yPic6fwNan34+ahBjiez++b1hiBtu21UFj6p4F2MuMQgete0JvPvtBZukHgmJHRZFXAJggk8BtuTrfBj4Oz0qY7+k/sD/jpA4PGUJqE90Yy6VUDzjMbrCNCffFPqItW28ctfUpeNCTAZMhgBCEZqy2kAH7FJCAltsyNAvZ8LQFn8NcjdQNDG06KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gVvBB5fA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gVvBB5fA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bfCGR4sqJz2yMw
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 12:29:49 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752287291; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=weKi5IJezNOCR2rUOHKGMnqeS6jg6SXJUv73Dpua+Lk=;
	b=gVvBB5fA1ieulVb2IiD+3qqyVDUDcSuyfSiklIl6vhoDCPKgivf4CFGZKDv0vAnCfUKqpVliXg4CLQblBJXFno8Vxk0bye8x6fJmFPx4d0iany1tgTlxfKTkMvIBVN5Wkq9qx+WonP5Fq53CeO5hGt9dzKCQoZkoDzSAHGI8qr4=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiiaB4V_1752287289 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Jul 2025 10:28:09 +0800
Message-ID: <d4edd794-2694-4068-848a-20ff33b92568@linux.alibaba.com>
Date: Sat, 12 Jul 2025 10:28:08 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: fix memory leak in xattr handling
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, kernel-team@android.com
References: <20250711233548.195561-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250711233548.195561-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/12 07:35, Sandeep Dhavale wrote:
> In android the LeakSanitizer reported memory leaks originating
> from functions like erofs_get_selabel_xattr.
> 
> The root cause is that the 'kvbuf' buffer, which is allocated to
> store xattr data, was not being freed when its owning
> 'xattr_item' struct was deallocated. The functions put_xattritem()
> and erofs_cleanxattrs() were freeing the xattr_item struct but
> neglected to free the kvbuf pointer within it.
> 
> This patch fixes the leak by adding the necessary free() calls for
> kvbuf in both functions.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

