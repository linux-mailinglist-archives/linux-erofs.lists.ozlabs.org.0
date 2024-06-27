Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB491A6F4
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 14:51:53 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GYwKZF2q;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8z3V1YsBz3cWF
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 22:51:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GYwKZF2q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8z3Q1WwZz3cPS
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 22:51:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719492700; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=6ML6P5bC0GW9WHrlSn9Sk7h/HnYyf8MWAjxCeC4OnGo=;
	b=GYwKZF2q3HKjF9NbsjzS0KExreE7IZYceHMQPSPXGz4CiwfHKldtn7zk2q/jljaGDlx+W2FHMZh0pSfJVJk4eW0TLp1ytZFiyMM/scc69UjKOtN9GDzMLEi5GdMnDIz2eQ/2hH441kv4uT9Bs9lgk44kSo6zwMvEXrf3Wpv8ntU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9MvDrh_1719492697;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9MvDrh_1719492697)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 20:51:38 +0800
Message-ID: <32dce802-692f-4050-b153-d5c4541fd835@linux.alibaba.com>
Date: Thu, 27 Jun 2024 20:51:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Greg KH <gregkh@linuxfoundation.org>
References: <20240627091345.3569167-1-lihongbo22@huawei.com>
 <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
 <9e81761d-e769-4b14-b72c-77b74e707364@linux.alibaba.com>
 <2a427366-0f63-4024-a3b3-759a4f902061@linux.alibaba.com>
 <2024062733-cradle-imprecise-002f@gregkh>
 <2abcf8cf-5cfc-4932-a544-ee0788bb2ed3@linux.alibaba.com>
In-Reply-To: <2abcf8cf-5cfc-4932-a544-ee0788bb2ed3@linux.alibaba.com>
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
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/27 20:36, Gao Xiang wrote:
> Hi Greg,
> 
> On 2024/6/27 19:16, Greg KH wrote:

...

>>
>> So what specifically should we do here?
> 
> Thanks for the reply..  Honestly I'd like to revert
> 
> block: Provide bdev_open_* functions
> erofs: Convert to use bdev_open_by_path()
> erofs: fix handling kern_mount() failure
> 
> Not quite sure if they can be cleanly reverted, but
> since the upstream doen't have 'bdev_handle' anymore,
> I will resend a proper backport for
> "erofs: fix handling kern_mount() failure".

Sigh, I just tried and it seems it causes more
conflicts due to my revert.  It seems another churn..

Anyway, on 6.6 LTS only the erofs one uses the
obsolete `struct bdev_handle`, but I think at least
it doesn't cause some serious issue.

Hi Greg,

Could you just pick up Hongbo's backport to resolve
the NULL dereference issue?

Thanks,
GaoXiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> thanks,
>>
>> greg k-h
