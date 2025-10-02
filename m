Return-Path: <linux-erofs+bounces-1155-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A438CBB2295
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Oct 2025 02:39:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccXxd2cP2z2ywC;
	Thu,  2 Oct 2025 10:39:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759365589;
	cv=none; b=kxvA9la/cBxUu/ty+6aAr9OkxI/vClohqY4fl7x2BnA20dz3nM8kn4OWfT95mTAb9GdZL79J19bGH8572BHUcwEBqgBbqBDZB9n8uhamvL98H8ZAHR6bJ5yO0xiC6WqChwy4nrPWevkqy1OBV1EtgJF6KVttTDGo5uA5XZydBz2+s9lUHiIC5DPNw+7rFKI4y3hfT9cEfitax0WKHBPfdBzoxOIap19a34e6IaTvSDquTOcgxYaT+i6+8t6ZY9OfAUxSXHuE8DFuk0d+6cuEWxpI8V/som2XXACFzKC63T1o9Y33Sp/hG0ENPVRrd9Dj5kSobGgpZbRniTV0rIk/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759365589; c=relaxed/relaxed;
	bh=rwjQ6AHGDtdnF/SeDdxY2mPwwPYfL2et6/jHGy7XH00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1vMica4wX8AEwD7VN/vyvSri4OvKdbkuxm4zXQ6ADDOvBYWtnyXbcf8pufCGHcUo2NE3LezGeVinKJojKsnwPDzqO1jzj+HlrHs/LAbrWmCVbdo9my8E2vzmTM4EmdEy5bQW89aOQvaseoX6W9uqFRGwj971qm4CSTlgPwp5GMHRkjEBfSAkhmXwRZPBd3FR96NLKqDQan8VZ3ydTSzD3n5UwXhQ0US1roxlI/Y/VM6+BxD9Hd4omzZUAGBSjkuMCpd40OeDe+Ne032/7w8py+KmTlABTMDPBuOEuDe+JQibrB+YE7ColQJqIhZbWk/fPuEzwAff98GQOp5sjWXSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hJ5drEWR; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hJ5drEWR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccXxc1HXnz2yr9
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 10:39:47 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759365584; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rwjQ6AHGDtdnF/SeDdxY2mPwwPYfL2et6/jHGy7XH00=;
	b=hJ5drEWRAlN7Ybg98Qt6+5VSBK9czW9TvulhLulbSL8O2nMF4zPw2hAl4SJgw8y1Td5/69jzembNGILGhLO2fGqqjxt+LRWizBw9bBjdp3OUJIi86onUyVwyKlePixvj3q8Yv7HFpM5fDuq7n2lBBgeQOX6VSQIsQy+NdoRkw18=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpGDhDr_1759365582 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Oct 2025 08:39:42 +0800
Message-ID: <e7bc9ed6-a097-4cde-85bd-e2b6c12d618a@linux.alibaba.com>
Date: Thu, 2 Oct 2025 08:39:41 +0800
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
Subject: Re: [PATCH v2] erofs-utils: tar: support archives without
 end-of-archive entry
To: Ivan Mikheykin <ivan.mikheykin@flant.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
References: <20250929133222.38815-1-ivan.mikheykin@flant.com>
 <20251001171341.87845-1-ivan.mikheykin@flant.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251001171341.87845-1-ivan.mikheykin@flant.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/2 01:13, Ivan Mikheykin wrote:
> Tar standard https://www.gnu.org/software/tar/manual/html_node/Standard.html
> says that archive "terminated by an end-of-archive entry,
> which consists of two 512 blocks of zero bytes".
> 
> Is also says:
> 
> "A reasonable system should write such end-of-file marker at the end
> of an archive, but must not assume that such a block exists when
> reading an archive. In particular, GNU tar does not treat missing
> end-of-file marker as an error and silently ignores the fact."
> 
> It is rare for erofs to encounter such problem, as images are mostly
> built with docker or buildah. But if you create image using tar library
> in Golang directly uploading layers to registry, you'll get tar layers
> without end-of-archive block. Running containers with such images will
> trigger this error during extraction:
> 
> mkfs.erofs --tar=f --aufs --quiet -Enoinline_data test.erofs test-no-end.tar
> <E> erofs: failed to read header block @ 42496
> <E> erofs: 	Could not format the device : [Error 5] Input/output error
> 
> This patch fixes the problem by assuming that eof is equal to the end-of-archive.
> 
> Reproducible tar without end-of-archive (base64-encoded gzipped blob):
> H4sICKVi2mgAA3Rlc3QtMTAtMi1ibG9ja3MudGFyAAtzDQr29PdjoCUwAAIzExMwbW5mCqYN
> jQzANBgYGTEYmhqYmpqamRoaGTMYGBqaGJkyKBjQ1FVQUFpcklikoMCQkpmYll9ahFNdYkpu
> Zh49HERfYKhnoWdowGVkYGSqa2Cua2jKNdAuGgX0BADwFwqsAAQAAA==
> 
> Also, add warning about non-conformant tar layers:
> 
> mkfs.erofs --tar=f --aufs -Enoinline_data test.erofs test-no-end.tar
> mkfs.erofs 1.8.10-g0a2bc574-dirty
> <W> erofs: unexpected end of file @ 1024 (may be non-standard tar without end of archive zeros)
> Build completed.
> ...
> 
> Signed-off-by: Ivan Mikheykin <ivan.mikheykin@flant.com>

Thanks, will apply.

Thanks,
Gao Xiang

