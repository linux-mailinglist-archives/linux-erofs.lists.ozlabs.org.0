Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEC3886DB7
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Mar 2024 14:46:20 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FVigjbvL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V1Ns5610zz3vZv
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Mar 2024 00:46:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FVigjbvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V1Nrz6zFHz3vYk
	for <linux-erofs@lists.ozlabs.org>; Sat, 23 Mar 2024 00:46:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711115166; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xYQlaJO1TSiLon+4ky5wQbB2yvCel6KiDidvWvN9938=;
	b=FVigjbvLOk2lcyqNt0ZAJQx4J93jibKyFtEfsh9bisxr04Tw/wNIdfiFZlqfZHq5cn8JBQtGvJ7rkslxNtGZAlkRr+ZlhVlRStcWc9qtK3QFGZ+GQdJBZHuDfBrvJWEjk7qyni1oCSXcz61IEDNL96zbU634oCSGjt9qcmOLrtY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W32K606_1711115158;
Received: from 192.168.26.88(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W32K606_1711115158)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 21:46:04 +0800
Message-ID: <bfb383a6-de23-4fdf-805b-09f8630f056e@linux.alibaba.com>
Date: Fri, 22 Mar 2024 21:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: rename per CPU buffer to global buffer pool and
 make it configurable
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
References: <20240322134540.1118625-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240322134540.1118625-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/22 21:45, Chunhai Guo wrote:
> It will cost more time if compressed buffers are allocated on demand for
> low-latency algorithms (like lz4) so EROFS uses per-CPU buffers to keep
> compressed data if in-place decompression is unfulfilled.  While it is kind
> of wasteful of memory for a device with hundreds of CPUs, and only a small
> number of CPUs concurrently decompress most of the time.
> 
> This patch renames it as 'global buffer pool' and makes it configurable.
> This allows two or more CPUs to share a common buffer to reduce memory
> occupation.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> Suggested-by: Gao Xiang <xiang@kernel.org>
> ---

Side note: it'd be better to have a changelog here against the previous
version next time.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
