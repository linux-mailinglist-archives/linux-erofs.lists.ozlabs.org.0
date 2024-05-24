Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 461A38CE0A1
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 07:36:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wmPT6m9b;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VltrG0hP7z87Ry
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 15:29:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wmPT6m9b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vltr93PMsz87Rf
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 15:28:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716528533; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=63HiWKurucdbNu9rfWfEw/ErheAa7bRn+7CcZyeEhkM=;
	b=wmPT6m9bMxGMnbdwSI2tbO5HDN4iCVVSdshs/SsPACv5H3XFO6XqiBJpPKduVuFyplnMCLJuy+0C3xXp3jHJ7SM5gfdFl9P4uM4bVSwx9ZIGoyy+ayEj4awzcshseCa3gxW/GFbrgbdxh3Fvxju4CesUI2Fq8L7o/kORGiLvw+s=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W74ta-B_1716528531;
Received: from 30.97.48.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W74ta-B_1716528531)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 13:28:52 +0800
Message-ID: <d207a747-2199-41e2-bee5-1c7ac7ded6b4@linux.alibaba.com>
Date: Fri, 24 May 2024 13:28:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs-utils: lib: provide helper to disable hashmap
 shrinking
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org
References: <20240523210131.3126753-1-dhavale@google.com>
 <20240523210131.3126753-2-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240523210131.3126753-2-dhavale@google.com>
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
Cc: kernel-team@android.com, junbeom.yeom@samsung.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/5/24 05:01, Sandeep Dhavale wrote:
> This helper sets hasmap.shrink_at to 0. This is helpful to iterate over
> hashmap using hashmap_iter_next() and use hashmap_remove() in single
> pass efficeintly.
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
