Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6438FC423
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 09:09:00 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RY7SC3Rb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvJTv73Kzz3bw2
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 17:08:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RY7SC3Rb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvJTk6Rfpz30Vr
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jun 2024 17:08:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717571316; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8FIEmjXz1qyz0t1CSUZA7bwKSoGsY887c9Xff0B2T9s=;
	b=RY7SC3Rb+/PU8R1mIKj7eibhU5EBNW+TzmLPTk8ALtHJK32Rc/2sOAu1OlzbxjXECfTnJx4ruDzswJ3TT0eA1xWPURO8H/rbeIMeUsuaaCUMu4HDwoJo+KAohRkMyse1iY4yH3qSA+/kaAR/UkqlmHXFLexA5flgENWaQVMTh5I=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7tWzN4_1717571313;
Received: from 30.97.48.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7tWzN4_1717571313)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 15:08:34 +0800
Message-ID: <3cf8cd58-ba9c-4f50-885e-70cd89ff4220@linux.alibaba.com>
Date: Wed, 5 Jun 2024 15:08:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs-utils: introduce the I/O manager
To: linux-erofs@lists.ozlabs.org
References: <20240605063312.3480769-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240605063312.3480769-1-hsiangkao@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/5 14:33, Gao Xiang wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Introduce the I/O manager to provide a more flexible way to specify
> the virtual storage.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

After rethinking, anyway I plan to drop this patch
since it's not clean.

Thanks,
Gao Xiang
