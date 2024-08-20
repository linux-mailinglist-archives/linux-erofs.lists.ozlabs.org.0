Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC389582BB
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 11:37:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wp4B52hTpz2yDx
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Aug 2024 19:37:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BIUUqygJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wp4B11T7Nz2xHY
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Aug 2024 19:37:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724146626; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l2+jDibFcpxXd+8JTIGUgTimQc0/BrFrXtvpGWrXZNI=;
	b=BIUUqygJonJKevlVRZzaD/QP2Qd7scNjm8QPtz93TrZXe9iSbE48vkTW1GkDqH13+j3F9hJcHyjFSobdT1zbT9ZUZp6/nUmo2ohlObumQFrSojTVpNy4rRrayBbT4J++k8g6SFlq8atsTKjsk1YkS6ONMmNMtH99fO/lWADzP00=
Received: from 30.221.130.129(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDI3eJo_1724146624)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:37:05 +0800
Message-ID: <4130fe2b-59eb-47ac-9e14-0274bffdefc0@linux.alibaba.com>
Date: Tue, 20 Aug 2024 17:37:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: allow large folios for compressed files
To: Barry Song <21cnbao@gmail.com>
References: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
 <CAGsJ_4yQMN+j2UMWO3ycRqiwh16sOQoSQSMatNg667Qzr=QmPQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4yQMN+j2UMWO3ycRqiwh16sOQoSQSMatNg667Qzr=QmPQ@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/8/20 17:29, Barry Song wrote:
> On Mon, Aug 19, 2024 at 2:52 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> As commit 2e6506e1c4ee ("mm/migrate: fix deadlock in
>> migrate_pages_batch() on large folios") already landed upstream,
>> large folios can be safely enabled for compressed inodes since all
>> prerequisites already landed in 6.11-rc1.
>>
>> Stress tests has been working on my fleet for > 20 days without any
>> regression.  Besides, users [1] has requested it for months.  Let's
>> allow large folios for EROFS full cases upstream now for wider testing.
>>
>> [1] https://lore.kernel.org/r/CAGsJ_4wtE8OcpinuqVwG4jtdx6Qh5f+TON6wz+4HMCq=A2qFcA@mail.gmail.com
>> Cc: Barry Song <21cnbao@gmail.com>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thank you, Xiang! We'll run some tests and update you with our findings.

Yeah, findings and patches are welcome as always.

Thanks,
Gao Xiang
