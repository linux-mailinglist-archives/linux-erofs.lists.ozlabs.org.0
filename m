Return-Path: <linux-erofs+bounces-1610-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB6CDE669
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Dec 2025 07:57:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dcxJH6SDrz2xcB;
	Fri, 26 Dec 2025 17:57:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766732255;
	cv=none; b=l1fXxewu7WzOG9Z5T3TiE1vGyCyQRNBsI9rjVKTKqfIlm2+xHlcPlewkDNL8Zbh2i05uF+9WrnOZOaLNZwKQzQPPg/9N99Eo9C+8xY4sOw5e2+WMh1dW+aJuHuGvGRpzdhIgE+droFcbTbrBSfHLG35oS9FxooJmSqLDSi9KDwNmL1XeDrqP4Xlau0Zd87CeIav6XNvIzq6kTWJ52HXLYXHj1pdvsJIVPJxx9gFe5e7L/gnynty+xsicpR1V0Vbtz4VLSihH7tmofJaCWhbBJgnlnZlYoVvGHBB3OK/sHWbufqMnWzwRLDeAh0351YEIh71baLUtq/VhPOocudvo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766732255; c=relaxed/relaxed;
	bh=i+3Hea5V415WILAXDs7zuCxuMcj/s7xrd6cOupQRhJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqKOgewFcnyOiq40S1Wuf1GT5a6tuo1Ih3TtyHdCsPAK+GwuUgyogsVql0npQPmlUcsTndXaBiXVcbA83ExcIhFzXD551nR8R2VIaGX8wGpex2VVRkwYIOLMm3FnZjOhiGwia8KyaiE4SjI+gSssJnnXCAjOopl8/5AfuINFIdokHdG4VZasSUBro//YWP2WNMG8S6MJ+O8gU+4L5IJ2kv4XD5BwvU++LZmp8fJ6nvhYKhHSCUq7gv/1rbslaSnM6Gtnk7+3uR7FE0Ag0ytXXC74FL40ut9psqM9fJcUalo23MdWMK8d6peJCmWyzBfdv1BFxvXRHiJup+szk48XcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E4fPKe7/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=E4fPKe7/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcxJF5Fvlz2x99
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Dec 2025 17:57:32 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766732244; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i+3Hea5V415WILAXDs7zuCxuMcj/s7xrd6cOupQRhJQ=;
	b=E4fPKe7/ucd+BFMdM/Wcjr7JV77/KBa5+1TzwPbtBG1zNec51C2wM8Se/yu1q9ZJrOqZZCYg7zsbiyBXS4rJ/OjWKAhz6sd5X/6H/p+FnaoAB3GjUduYXFUyCVBtqM+Ey1BC7Gb5vneMhJqi/pqoOMkEMrK8Z1258RdfKlGAUlE=
Received: from 30.221.133.83(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvgk0x0_1766732243 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 14:57:23 +0800
Message-ID: <706b0839-ab0f-4f66-959e-74152a4e1243@linux.alibaba.com>
Date: Fri, 26 Dec 2025 14:57:22 +0800
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
Subject: Re: [PATCH 2/5] erofs-utils: mount: Refactor NBD connection logic in
 erofsmount_nbd()
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223100452.229684-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/23 18:04, Yifan Zhao wrote:
> From: Yifan Zhao <yifan.yfzhao@foxmail.com>
> 
> The current NBD connection logic has the following issues:
> 
> 1.It first tries netlink (forking a child), then falls back to ioctl
> (forking another), causing redundant process overhead and double-opening
> of erofs_nbd_source on fallback.

But I don't want to open source on the main process.  Especially if we'd
like to trigger multiple layers.

If you really want to optimize this, how about just forking one child
process for both netlink and ioctl, and opening erofs_nbd_source in
the child process too.

> 2.Child processes fail silently, hiding the error cause from the parent
> and confusing users.
> 3.erofsmount_startnbd() doesn’t ignore SIGPIPE, causing nbd_loopfn to be
> killed abruptly without clean up during disconnect.
> 4.During disconnect, -EPIPE from NBD socket I/O is expected, but
> erofsmount_nbd_loopfn() does not suppress it, leading to uncessary
> "NBD worker failed with EPIPE" message printed in erofsmount_startnbd().

Could we address these issues independently?

Thanks,
Gao Xiang

> 
> This patch consolidates the netlink and ioctl fallback logic into a
> single child process, eliminating redundant erofs_nbd_source opens. It
> also ensure SIGPIPE and -EPIPE are properly suppressed during disconnect
> in erofsmount_nbd_loopfn(), enabling cleanup and graceful exit.
> Additionally, the child process now reports error code via exit() for
> better user visibility.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>


