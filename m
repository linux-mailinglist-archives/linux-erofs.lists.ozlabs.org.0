Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4E95822A
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 11:27:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp3yh25lpz2yDt
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 19:27:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eA5IDrGa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp3yc1Ypgz2y1l
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 19:27:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724146036; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K/MrWzNIyumOIgtjq7Sac1rrkPi5s2Cv9Be/ma9e4Xg=;
	b=eA5IDrGaL8v8nOoyrKEVhiLL9x5MS7ZWKNnfu0DoyhN6FOM1POpq+FB5HC0wGpt8hVbwCPZ66bvAhVmtHBM4nl3gxFeaUMUYcOAGZWtnCmjopWhGU6mSgcx2Rl2id6p7C/DN3Adx9zG0vub+Fpe73cbc/NVHz61umrDn2Rb/5yY=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDI3ajq_1724146033)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:27:14 +0800
Message-ID: <c2a0cb7c-3858-4872-9d11-f620df03d476@linux.alibaba.com>
Date: Tue, 20 Aug 2024 17:27:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
To: Chunhai Guo <guochunhai@vivo.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <000000000000f7b96e062018c6e3@google.com>
 <20240820084224.1362129-1-hsiangkao@linux.alibaba.com>
 <8481ec6f-9f8a-4f76-8ab7-b45e38cc8d40@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <8481ec6f-9f8a-4f76-8ab7-b45e38cc8d40@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chunhai,

On 2024/8/20 17:25, Chunhai Guo wrote:
> 在 2024/8/20 16:42, Gao Xiang 写道:
>> If z_erofs_gbuf_growsize() partially fails on a global buffer due to
>> memory allocation failure or fault injection (as reported by syzbot [1]),
>> new pages need to be freed by comparing to the existing pages to avoid
>> memory leaks.
>>
>> However, the old gbuf->pages[] array may not be large enough, which can
>> lead to null-ptr-deref or out-of-bound access.
>>
>> Fix this by checking against gbuf->nrpages in advance.
>>
>> Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
>> Cc: <stable@vger.kernel.org> # 6.10+
>> Cc: Chunhai Guo <guochunhai@vivo.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
> Reviewed-by: Chunhai Guo <guochunhai@vivo.com>

I've sent a patch to add links and reported-by.

I assume I can add your reviewed-by to that version too?

Thanks,
Gao Xiang

> 
> Thanks,
> 
> Chunhai Guo
> 
