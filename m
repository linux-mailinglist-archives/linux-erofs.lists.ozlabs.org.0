Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F214F8FE512
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 13:17:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UIFY/Qto;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vw1xx0tlQz3dGn
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 21:17:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UIFY/Qto;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vw1xq5xvCz3cbL
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 21:17:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717672619; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=swYQlt5bzygOLNSKE1bUXjCZIoYSZdl3Yo9bMwnPsHc=;
	b=UIFY/QtoQRJQzNGA56wVTqb2Xt/u/kq5XK7GhPSAjXRb3LSY6UQMQPkMfZlCZ78mR1VVP4pJNVYnj0Rfq5rJappvGXFftTNs5tcSdAKX+gSqk4j3p/KGuxQWvQT1JS2XX+IUG4LdyYY/8NL8axN89Y7rgM5mhKluo0lhliUM5nY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7y6kY4_1717672617;
Received: from 30.221.132.172(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W7y6kY4_1717672617)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:16:58 +0800
Message-ID: <07469998-9c84-4baa-9107-7de82b2b0e1e@linux.alibaba.com>
Date: Thu, 6 Jun 2024 19:16:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: introduce erofs_vfile
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240606110720.2380365-1-hongzhen@linux.alibaba.com>
 <52a2671f-5a9a-48d7-b3bb-14f276d5e02e@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <52a2671f-5a9a-48d7-b3bb-14f276d5e02e@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/6/6 19:11, Gao Xiang wrote:
>
>
> On 2024/6/6 19:07, Hongzhen Luo wrote:
>> The current implementation of reading/writing in erofs is through
>> file descriptors. The `erofs_vfile` provides a more flexible way
>> to perform I/O control.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>
> I don't think it's your latest version, please resend the latest
> version instead.
>
> Thanks,
> Gao Xiang

Sorry about that, you're right. I will send the latest version soon.


---

Thanks,

Hongzhen Luo

